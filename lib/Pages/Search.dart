import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2963AF),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Ionicons.search_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                isDense: true
              ),
            ),
          )
        ),
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}
