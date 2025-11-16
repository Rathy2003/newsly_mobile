import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/controllers/search_news_controller.dart';
import 'package:newsly/helper/helper.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/widgets/news_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavbarController = Get.find<BottomNavbarController>();
    var searchNewsController = Get.put(SearchNewsController());

    return SafeArea(
      child: Material(
        child: Column(
          children: [
            // Start AppBar
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    bottomNavbarController.changeIndex(bottomNavbarController.old_index);
                  },
                  icon: Icon(Icons.arrow_back_ios)
                  
                ),
                SearchBar(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 60,
                    minHeight: 45
                  ),
                  keyboardType: TextInputType.text,
                  elevation: WidgetStatePropertyAll(0),
                  hintText: "ស្វែងរកព័ត៌មាននៅទីនេះ...",
                  onSubmitted: (value){
                    searchNewsController.keyword.value = value;
                    searchNewsController.searchNews();
                  },
                )
              ],
            ),
            // End AppBar

            // News Item
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx((){
                  if(searchNewsController.news.isEmpty){
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 250,),
                          FaIcon(
                            FontAwesomeIcons.newspaper,
                            size: 50,
                            color: Colors.black45,
                          ),
                          SizedBox(height: 15,),
                          Text("មិនមានព័ត៌មាននោះទេ",
                            style: AppFont.normal,
                          ),
                        ],
                      ),
                    );
                  }else{
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: searchNewsController.news.length,
                      itemBuilder: (context, index) {
                        return NewsCard(
                          id: searchNewsController.news[index].id ?? 0,
                          title: searchNewsController.news[index].title,
                          image: searchNewsController.news[index].fullImagePath,
                          postedDate: Helper.displayKmDate(searchNewsController.news[index].postedAt),
                        );
                      },
                      separatorBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(height: 5,),
                            Divider(),
                            SizedBox(height: 10,),
                          ],
                        );
                      },
                    );
                  }
                }),
              ),
            ),
            SizedBox(height: 100,),
            // End News Item
          ],
        ),
      ),
    );
    //  return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: (){
    //         bottomNavbarController.changeIndex(bottomNavbarController.old_index);
    //       },
    //       icon: Icon(Icons.arrow_back_ios)
          
    //     ),
    //     title: Text("សារជូនដំណឹង", style: AppFont.heading,),
    //     centerTitle: true,
    //     elevation: 1,
    //   ),
    //   body: ListView(
    //     children: [
    //       SearchBar(
    //         keyboardType: TextInputType.text,

    //         hintText: "Search news here...",
    //       )
    //     ],
    //   )
    // );
  }
}