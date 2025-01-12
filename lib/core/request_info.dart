class RequestInfo {
  static const String packageName = "com.nalstudio.nysse_asemanaytto";
  static const String userAgent = "NALStudioNysseAsemanaytto";

  /// GraphQL request timeout
  // We picked a suitably long time that is below our rate limits
  // so that if digitransit is slow, we don't show an error right away.
  static const Duration qlTimeout = Duration(seconds: 20);

  static const RequestInfoRatelimits ratelimits = RequestInfoRatelimits(
    stoptimesRequest: Duration(seconds: 30),
    alertsRequest: Duration(seconds: 60),
    stopInfoRequest: Duration(days: 1),
    tripRouteRequest: Duration(days: 1),
  );
}

class RequestInfoRatelimits {
  final Duration stoptimesRequest;
  final Duration alertsRequest;
  final Duration stopInfoRequest;
  final Duration tripRouteRequest;

  const RequestInfoRatelimits({
    required this.stoptimesRequest,
    required this.alertsRequest,
    required this.stopInfoRequest,
    required this.tripRouteRequest,
  });
}
