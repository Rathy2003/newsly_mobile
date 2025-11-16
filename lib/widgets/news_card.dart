import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/news_controller.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';


class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.postedDate
  });

  final int id;
  final String title;
  final String image;
  final String postedDate;

  

  @override
  Widget build(BuildContext context) {

    var newsController = Get.find<NewsController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Start Title and Posted date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => newsController.onViewNews(id),
                    child: Text(title,
                      style: AppFont.newsTitle,
                      softWrap: true,
                      maxLines: 3,  
                    ),
                  ),
                ],
              ),
            ),
            // End Title and Posted date
                      
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15),
                color: Color(AppColor.secondary)
              ),
            )
          ],
        ),

        SizedBox(height: 15,),

        // Start Posted Date and Social Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(width: 5,),
                Text(postedDate,)
              ],
            ),
          ],
        )
      ],
    );
  }
}