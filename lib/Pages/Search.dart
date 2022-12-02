import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Display/PostCardHome.dart';

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
        title: Text('INSEKUL', style: Theme.of(context).textTheme.headline4,),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
      body: ListView(
        children: [
          PostCardHome(
              profilePhoto: Icon(Ionicons.person, color: Colors.black,),
              name: 'Divanda Firdaus',
              postImage: 'https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',
              description: 'Belum ada deskripsi'
          ),
          PostCardHome(
              profilePhoto: Icon(Ionicons.person, color: Colors.black,),
              name: 'Divanda Firdaus',
              postImage: 'https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',
              description: 'Belum ada deskripsi'
          ),
          PostCardHome(
              profilePhoto: Icon(Ionicons.person, color: Colors.black,),
              name: 'Divanda Firdaus',
              postImage: 'https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',
              description: 'Belum ada deskripsi'
          ),
        ],
      ),
    );
  }
}
