import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsly/utils/app_color.dart';

class BreakingNewsItem extends StatelessWidget {
  const BreakingNewsItem({
    super.key,
    required this.title,
    required this.description,
    this.postedTime = 0,
    required this.image
  });

  final String title;
  final String description;
  final int postedTime;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Color(AppColor.secondary),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        )
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5)
                ]
              )
            ),
          ),
    
          // Start Title and Description
          Positioned(
            left: 15,
            bottom: 15,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ]
            )
          ),
          // End Title and Description
        ],
      ),
    );
  }
}