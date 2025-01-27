class HueError extends Error {
  final String? message;

  HueError({this.message});

  @override
  String toString() {
    if (message == null) {
      return "Unknown Hue error.";
    } else {
      return "Hue error: $message";
    }
  }
}

class HueAuthenticationError extends HueError {
  HueAuthenticationError.statusCode(int statusCode)
      : super(message: "Authentication failed with status code: $statusCode");

  HueAuthenticationError.withDescription(String? description)
      : super(
          message: description == null
              ? "Authentication failed."
              : "Authentication failed with message: '$description'",
        );
}
