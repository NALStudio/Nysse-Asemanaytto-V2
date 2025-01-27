import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/philips_hue/_authentication.dart';
import 'package:nysse_asemanaytto/philips_hue/_bridge.dart';
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
  final List<HueDiscoveredBridge> _bridges = List.empty(growable: true);

  bool authenticating = false;
  static const Duration _authTimeout = Duration(seconds: 20);
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
    setState(() {
      authenticating = true;
    });

    HueBridgeCredentials? creds;
    bool cancelAuth = false;

    final auth = HueAuthentication(bridgeIp: ip.ipAddress);

    _updateConnectDuration.start();
    Future.delayed(_authTimeout).then((_) => cancelAuth = true);
    while (creds == null && !cancelAuth) {
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
            ipAddress: ip.ipAddress,
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
            child: ListView.builder(
              itemCount: _bridges.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(getBridgeTitle(_bridges[index])),
                  onTap: () => handleConnect(_bridges[index]),
                );
              },
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
