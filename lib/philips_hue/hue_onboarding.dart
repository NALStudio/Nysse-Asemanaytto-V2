import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hue/flutter_hue.dart';

/// Must be wrapped inside a [Dialog] widget.
class PhilipsHueOnboardingDialog extends StatefulWidget {
  const PhilipsHueOnboardingDialog({super.key});

  @override
  State<PhilipsHueOnboardingDialog> createState() =>
      _PhilipsHueOnboardingDialogState();
}

class _PhilipsHueOnboardingDialogState extends State<PhilipsHueOnboardingDialog>
    with SingleTickerProviderStateMixin {
  List<DiscoveredBridge> _bridges = List.empty();

  DiscoveryTimeoutController? _firstContact;
  Duration? _elapsedSinceConnectStart;
  late Ticker _updateConnectDuration;

  late GlobalKey<RefreshIndicatorState> _refresh;

  @override
  void initState() {
    _refresh = GlobalKey();

    _updateConnectDuration = Ticker((time) {
      setState(() {
        _elapsedSinceConnectStart = time;
      });
    });

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refresh.currentState!.show());
  }

  Future reloadBridges() async {
    List<DiscoveredBridge> b =
        await BridgeDiscoveryRepo.discoverBridges(writeToLocal: false);

    setStateIfMounted(() {
      _bridges = b;
    });
  }

  Future handleConnect(DiscoveredBridge ip) async {
    setStateIfMounted(() {
      _firstContact = DiscoveryTimeoutController(timeoutSeconds: 15);
    });

    _updateConnectDuration.start();
    Bridge? bridge = await BridgeDiscoveryRepo.firstContact(
      bridgeIpAddr: ip.ipAddress,
      controller: _firstContact,
      writeToLocal: false,
    );
    _updateConnectDuration.stop();

    if (bridge == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bridge connection failed.")),
        );
      }

      setStateIfMounted(() {
        _firstContact = null;
      });
    } else {
      if (mounted) {
        Navigator.pop(context, bridge);
      }
    }
  }

  void setStateIfMounted(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  String getBridgeTitle(DiscoveredBridge b) {
    String id = b.id ?? "unknown";
    return "Bridge $id (${b.ipAddress})";
  }

  @override
  Widget build(BuildContext context) {
    if (_firstContact == null) {
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
      int elapsedUs = _elapsedSinceConnectStart?.inMicroseconds ?? 0;
      int totalUs =
          _firstContact!.timeoutSeconds * Duration.microsecondsPerSecond;
      double progress = elapsedUs / totalUs;

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
