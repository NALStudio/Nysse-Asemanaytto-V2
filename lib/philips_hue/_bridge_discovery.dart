import 'package:multicast_dns/multicast_dns.dart';

class HueDiscoveredBridge {
  final String name;
  final String ipAddress;

  HueDiscoveredBridge({required this.name, required this.ipAddress});
}

class HueBridgeDiscovery {
  static Stream<HueDiscoveredBridge> discoverBridges(
      {Duration scanDuration = const Duration(seconds: 10)}) async* {
    final MDnsClient client = MDnsClient();
    try {
      await client.start();

      await for (SrvResourceRecord r in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service("_hue._tcp local"),
        timeout: scanDuration,
      )) {
        yield HueDiscoveredBridge(name: r.name, ipAddress: r.target);
      }
    } finally {
      client.stop();
    }
  }
}
