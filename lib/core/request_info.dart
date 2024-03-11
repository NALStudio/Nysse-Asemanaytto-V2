class RequestInfo {
  static const String packageName = "com.nalstudio.nysse_asemanaytto";
  static const String userAgent = "NysseAsemanaytto";
  static const RequestInfoRatelimits ratelimits = RequestInfoRatelimits(
    stoptimesRequest: Duration(seconds: 30),
    stopInfoRequest: Duration(days: 1),
    tripRouteRequest: Duration(days: 1),
  );
}

class RequestInfoRatelimits {
  final Duration stoptimesRequest;
  final Duration stopInfoRequest;
  final Duration tripRouteRequest;

  const RequestInfoRatelimits({
    required this.stoptimesRequest,
    required this.stopInfoRequest,
    required this.tripRouteRequest,
  });
}
