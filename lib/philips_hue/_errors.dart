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

class HueFetchError extends HueError {
  HueFetchError.withDetails(int statusCode, List<String>? details)
      : super(message: _formatMessage(statusCode, details));

  static String _formatMessage(int statusCode, List<String>? details) {
    List<String> output = ["Hue request failed with code $statusCode."];
    if (details != null && details.isNotEmpty) {
      output.add("Details (${details.length}):");
      output.addAll(details);
    } else {
      output.add("No details.");
    }

    return output.join('\n');
  }
}
