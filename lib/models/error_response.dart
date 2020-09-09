class ErrorResponse{
  final String message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      ErrorResponse(message: json["message"]);

  Map<String, String> toJson() => {
    "message": message,
  };
}