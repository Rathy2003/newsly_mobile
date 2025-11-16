import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newsly/models/api_response.dart';
import 'package:newsly/utils/app_config.dart';

class UserService{
  Future<ApiResponse> updateUserProfile(String userId,String username,String email, File? image) async{
    var apiResponse = ApiResponse();
    try{
      var uri = Uri.parse("${AppConfig.baseUrl}/user/$userId");
      var request = http.MultipartRequest("PUT", uri);
      request.fields["username"] = username;
      request.fields["email"] = email;
      if(image != null){
        request.files.add(await http.MultipartFile.fromPath("profile", image.path));
      }
      final response = await request.send();
      final resBody = await response.stream.bytesToString();
      apiResponse.success = response.statusCode == 200 ? true : false;
      apiResponse.data = json.decode(resBody);
    }catch(e){
      apiResponse.success = false;
      apiResponse.message = e.toString();
    }
    return apiResponse;
  }
}