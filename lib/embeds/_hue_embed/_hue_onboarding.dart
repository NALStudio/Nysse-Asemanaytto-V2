import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/philips_hue/_authentication.dart';
import 'package:nysse_asemanaytto/philips_hue/_icons.dart';
import 'package:nysse_asemanaytto/philips_hue/philips_hue.dart';

/// Must be wrapped inside a [Dialog] widget.
class PhilipsHueOnboardingDialog extends StatefulWidget {
  const PhilipsHueOnboardingDialog({super.key});

  @override
  State<PhilipsHueOnboardingDialog> createState() =>
      _PhilipsHueOnboardingDialogState();
}

class _PhilipsHueOnboardingDialogState extends State<PhilipsHueOnboardingDialog>
    with SingleTickerProviderStateMixin {
  final LinkedHashSet<HueDiscoveredBridge> _bridges = LinkedHashSet();

  bool authenticating = false;
  static const Duration _authTimeout = Duration(seconds: 20);
  static const Duration _delayBetweenTries = Duration(seconds: 5);

  Duration? _elapsedSinceAuthStart;
  late Ticker _updateConnectDuration;

  late GlobalKey<RefreshIndicatorState> _refresh;

  @override
  void initState() {
    _refresh = GlobalKey();

    _updateConnectDuration = Ticker((time) {
      setState(() {
        _elapsedSinceAuthStart = time;
      });
    });

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refresh.currentState!.show());
  }

  Future reloadBridges() async {
    _bridges.clear();

    await for (HueDiscoveredBridge b in HueBridgeDiscovery.discoverBridges()) {
      setStateIfMounted(() {
        _bridges.add(b);
      });
    }
  }

  Future handleConnect(HueDiscoveredBridge ip) async {
    final auth = HueAuthentication(bridgeIp: ip.ipAddress);
    try {
      await authenticate(auth, ip.ipAddress);
    } finally {
      auth.dispose();
    }
  }

  Future authenticate(HueAuthentication auth, String ip) async {
    setState(() {
      authenticating = true;
    });

    HueBridgeCredentials? creds;
    int iterations =
        (_authTimeout.inMicroseconds / _delayBetweenTries.inMicroseconds)
            .ceil();

    _updateConnectDuration.start();
    for (int i = 0; i < iterations && creds == null; i++) {
      await Future.delayed(_delayBetweenTries); // Retry every 5 seconds
      creds = await auth.tryAuthenticate(
        appName: RequestInfo.philipsHueAppName,
        instanceName: RequestInfo.philipsHueInstanceName,
      );
    }
    _updateConnectDuration.stop();

    if (mounted) {
      setState(() {
        authenticating = false;
      });

      if (creds == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bridge connection failed.")),
        );
      } else {
        Navigator.pop(
          context,
          HueBridge(
            ipAddress: ip,
            credentials: creds,
          ),
        );
      }
    }
  }

  void setStateIfMounted(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  String getBridgeTitle(HueDiscoveredBridge b) {
    return "${b.name} (${b.ipAddress})";
  }

  @override
  Widget build(BuildContext context) {
    if (!authenticating) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: RefreshIndicator(
            key: _refresh,
            onRefresh: reloadBridges,
            child: ListView(
              children: _bridges
                  .map(
                    (b) => ListTile(
                      leading: Icon(HueIcons.bridge),
                      title: Text(getBridgeTitle(b)),
                      onTap: () => handleConnect(b),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _refresh.currentState!.show(),
          icon: Icon(Icons.refresh),
          label: Text("Reload Bridges"),
        ),
      );
    } else {
      int elapsedUs = _elapsedSinceAuthStart?.inMicroseconds ?? 0;
      double progress = elapsedUs / _authTimeout.inMicroseconds;

      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            Text("Press Link Button"),
            LinearProgressIndicator(value: progress)
          ],
        ),
      );
    }
  }
}
