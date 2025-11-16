import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsly/models/api_response.dart';

class APICalling{

  // GET Method
  static Future<ApiResponse> get(String uri) async{
    var apiResponse = ApiResponse();
    try{ 
      var response = await http.get(Uri.parse(uri)).timeout(Duration(seconds: 10));
      apiResponse.status = response.statusCode;
      apiResponse.data = json.decode(response.body);
    }catch(e){
      apiResponse.status = 400;
      apiResponse.message = e.toString();
    }
    return apiResponse;
  }

  // POST Method
  static Future<ApiResponse> post(String url,Object body) async{
    var apiResponse = ApiResponse();
    try{ 
      var response = await http.post(Uri.parse(url),body: body).timeout(Duration(seconds: 10));
      apiResponse.status = response.statusCode;
      apiResponse.data = json.decode(response.body);
    }catch(e){
      apiResponse.status = 400;
      apiResponse.message = e.toString();
    }
    return apiResponse;
  }
}