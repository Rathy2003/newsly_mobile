class ApiResponse {
  bool? success;
  String? message;
  int? status;
  dynamic data;
  ApiResponse({this.success, this.message,this.status,this.data});
}