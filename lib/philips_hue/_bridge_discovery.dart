import 'package:multicast_dns/multicast_dns.dart';

class HueDiscoveredBridge {
  final String name;
  final String ipAddress;

  HueDiscoveredBridge({required this.name, required this.ipAddress});
}

class HueBridgeDiscovery {
  /// The same bridge might get discovered multiple times.
  static Stream<HueDiscoveredBridge> discoverBridges(
      {Duration scanDuration = const Duration(seconds: 10)}) async* {
    final MDnsClient client = MDnsClient();
    try {
      await client.start();

      await for (final PtrResourceRecord ptr
          in client.lookup<PtrResourceRecord>(
              ResourceRecordQuery.serverPointer("_hue._tcp.local"))) {
        await for (final SrvResourceRecord srv
            in client.lookup<SrvResourceRecord>(
                ResourceRecordQuery.service(ptr.domainName))) {
          await for (final IPAddressResourceRecord ip
              in client.lookup<IPAddressResourceRecord>(
                  ResourceRecordQuery.addressIPv4(srv.target))) {
            yield HueDiscoveredBridge(
              name: ptr.domainName.split('.').first,
              ipAddress: ip.address.address,
            );
          }
        }
      }
    } finally {
      client.stop();
    }
  }
}
