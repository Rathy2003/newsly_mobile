import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsly/models/news.dart';
import 'package:newsly/routes/app_route.dart';
import 'package:newsly/utils/app_config.dart';

class NewsController extends GetxController {
  RxList<News> news = RxList([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNews();
  }

  void fetchAllNews() async{
    news.clear();
    var response = await http.get(Uri.parse("${AppConfig.baseUrl}/news"));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      for(var item in data){
        news.add(News.fromJson(item));
      }
      isLoading.value = false;
    }
  }

  void fetchNewsByCategoryId(int categoryId) async{
    isLoading.value = true;
    news.clear();
    var response = await http.get(Uri.parse("${AppConfig.baseUrl}/news/category/$categoryId"));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      for(var item in data){
        news.add(News.fromJson(item));
      }
      isLoading.value = false;
    }
  }

  void onViewNews(int newId){
    var foundedNews = news.firstWhere((element) => element.id == newId);
    Get.toNamed(AppRoute.viewNews,arguments: foundedNews);
  }
}