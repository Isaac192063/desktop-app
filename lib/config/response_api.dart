class ResponseApi {
  String? message;
  dynamic data;
  bool? success;
  String? token;

  ResponseApi({this.message, this.data, this.success, this.token});

  ResponseApi.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    success = json["success"];
    token = json["token"];
    try {
      data = json["data"];
    } catch (e) {
      throw e.toString();
    }
  }

  Map<String, dynamic> toJson() => {"message": message, "success": success};
}
