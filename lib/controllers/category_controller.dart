import 'dart:convert';
import 'package:get/get.dart';
import 'package:newsly/controllers/news_controller.dart';
import 'package:newsly/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:newsly/utils/app_config.dart';

class CategoryController extends GetxController{
  RxList<Category> categorys = <Category>[] = RxList<Category>([]);
  RxBool isLoading = true.obs;
  var newsController = Get.find<NewsController>();

  @override
  void onInit() {
    super.onInit();
    fetchAllCategory();
  }

  void fetchAllCategory() async{
    categorys.clear();
    categorys.add(Category(id:0,name: "ទាំងអស់"));
    var response = await http.get(Uri.parse("${AppConfig.baseUrl}/category"));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      for(var item in data){
        categorys.add(Category.fromJson(item));
      }
      isLoading.value = false;
    }
  }

  void onChangeCategory(int index){
    int? categoryId = categorys[index].id;
    if(categoryId != null){
      if(categoryId == 0) newsController.fetchAllNews();
      newsController.fetchNewsByCategoryId(categoryId);
    }
  }
}