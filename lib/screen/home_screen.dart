import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/controllers/beaking_news_controller.dart';
import 'package:newsly/controllers/category_controller.dart';
import 'package:newsly/controllers/news_controller.dart';
import 'package:newsly/controllers/tabbar_controller.dart';
import 'package:newsly/helper/helper.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/widgets/breaking_news_item.dart';
import 'package:newsly/widgets/custom_bottom_navbar.dart';
import 'package:newsly/widgets/news_card.dart';
import 'package:newsly/widgets/tab_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var tabBarController = Get.find<TabBarController>();
  var categoryController = Get.find<CategoryController>();
  var newsController = Get.find<NewsController>();
  var authController = Get.find<AuthController>();
  var breakingNewsController = Get.find<BreakingNewsController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(categoryController.isLoading.value){
        return Center(child: CircularProgressIndicator(),);
      }else{
        _tabController = TabController(length: categoryController.categorys.length, vsync: this);
        return Scaffold(
      appBar: AppBar(
        title: Text('សួរស្តី, ${authController.currentUser.value.username}'),
        actions: [
          Stack(
            children: [
              // Start Profile Picture
              Obx((){
                var profileImage = authController.currentUser.value.profile;
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: profileImage == null ? AssetImage("assets/images/default-avatar.webp") : NetworkImage(profileImage),
                );
              }),
              // End Profile Picture
            ],
          ),
          SizedBox(width: 15,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            // Start Breaking News Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ព័ត៌មានទាន់ហេតុការណ៍', style: AppFont.heading),
                    Text(Helper.displayKmDate(DateTime.now().toString()), style: AppFont.secondary),
                  ],
                ),
              ],
            ),

            // End Breaking News Heading
            SizedBox(height: 25),

            // Start Breaking News Slider
            Obx((){
              if(breakingNewsController.isLoading.value){
                return Center(child: CircularProgressIndicator(),);
              }else{
                if(breakingNewsController.breakingNewsList.isNotEmpty){
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 4 / 2.9,
                      initialPage: 0,
                      enlargeFactor: 0.5,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                    items:List.generate(breakingNewsController.breakingNewsList.length, (index) => index).map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return BreakingNewsItem(
                            title: breakingNewsController.breakingNewsList[i].title,
                            description: breakingNewsController.breakingNewsList[i].description,
                            image:breakingNewsController.breakingNewsList[i].fullImagePath
                          );
                        },
                      );
                    }).toList(),
                  );
                }else{
                  return Center(child: Text("No Breaking News"),);
                }
              }
            }),

            // End Breaking News Slider
            SizedBox(height: 25),

            // Start News Categories
            Obx(
              () => TabBar(
                controller: _tabController,
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                onTap: (value) {
                  tabBarController.tabIndex.value = value;
                  categoryController.onChangeCategory(value);
                },
                splashBorderRadius: BorderRadius.circular(20),
                overlayColor: WidgetStateProperty.all(
                  Colors.white.withOpacity(0.1),
                ),

                tabs: List.generate(categoryController.categorys.length, (
                  index,
                ) {
                  return TabItem(
                    index:index,
                    label: categoryController.categorys[index].name,
                  );
                }),
              ),
            ),
            // End News Categories

            SizedBox(height: 25),
            
            // News Item
            Obx((){
              if(newsController.news.isEmpty){
                return Center(
                  child: Column(
                    children: [
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsController.news.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      id: newsController.news[index].id ?? 0,
                      title: newsController.news[index].title,
                      image: newsController.news[index].fullImagePath,
                      postedDate: Helper.displayKmDate(newsController.news[index].postedAt),
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
            SizedBox(height: 100,),
            // End News Item
          ],
        ),
      ),
      floatingActionButton: CustomBottomNavBar(),
    );
      }
      
    },);
  }
}




