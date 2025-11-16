import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsly/models/news.dart';
import 'package:newsly/utils/app_config.dart';

class SearchNewsController extends GetxController{
  RxList<News> news = RxList([]);
  RxBool isLoading = true.obs;
  RxString keyword = "".obs;

  void searchNews() async{
    news.clear();
    var response = await http.get(Uri.parse("${AppConfig.baseUrl}/news/search/$keyword"));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      for(var item in data){
        news.add(News.fromJson(item));
      }
      isLoading.value = false;
      print(news.length);
    }
  }
}