import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsly/utils/app_color.dart';

class AppFont{
  static TextStyle heading = GoogleFonts.nunitoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      );

  static TextStyle normal = GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      );
                    

  static TextStyle secondary = GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 97, 96, 96)
                      ); 

  static TextStyle textButton = GoogleFonts.poppins(
                        fontSize: 13,
                        color: Color(AppColor.primaryColor)
                      );        

  static TextStyle newsTitle = GoogleFonts.hanuman(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      );                                    
}