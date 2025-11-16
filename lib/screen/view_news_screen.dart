import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/helper/helper.dart';
import 'package:newsly/models/news.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';

class ViewNewsScreen extends StatelessWidget {
  const ViewNewsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final News? news = Get.arguments as News?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('អានព័ត៌មាន'),
        centerTitle: true,
        elevation: 1,
        actions: [
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              // Image
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Color(AppColor.secondary),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(news!.fullImagePath),
                    fit: BoxFit.cover,
                  )
                ),
              ),

              SizedBox(height: 25,),

              // News Title
              Text(
                news.title,
                style: AppFont.newsTitle,
              ),

              // Posted Date and Category
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Helper.displayKmDate(news.postedAt),
                    style: AppFont.normal,
                  ),
                  Text("-"),
                  SizedBox(width: 15,),
                  Text(
                    news.categoryName,
                    style: AppFont.normal,
                  ),
                ],
              ),

              SizedBox(height: 25,),
              // News Content
              Text(
                news.content,
                style: AppFont.normal,
              ),
            ],
          ),
        ),
    );
  }
}