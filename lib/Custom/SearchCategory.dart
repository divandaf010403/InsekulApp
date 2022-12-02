import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCategory extends StatefulWidget {
  final Image img;
  final String category;

  SearchCategory({
    required this.img,
    required this.category,
});

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.img,
          SizedBox(width: 10,),
          Text(widget.category, style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
