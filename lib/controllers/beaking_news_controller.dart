import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsly/models/news.dart';
import 'package:newsly/utils/app_config.dart';

class BreakingNewsController extends GetxController{
  RxList<News> breakingNewsList = <News>[].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAllBreakingNews();
  }

  void fetchAllBreakingNews() async{
    breakingNewsList.clear();
    isLoading.value = true;
    var response = await http.get(Uri.parse("${AppConfig.baseUrl}/news/breaking"));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      for(var item in data){
        breakingNewsList.add(News.fromJson(item));
      }
      print(breakingNewsList.length);
      isLoading.value = false;
    }
  }
}