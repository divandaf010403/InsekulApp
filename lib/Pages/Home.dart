import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insekul_app/Display/PostCardHome.dart';
import 'package:insekul_app/SidePages/AddPostPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        title: Text('INSEKUL', style: GoogleFonts.oleoScript(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage()));},
            icon: Icon(Icons.add_box_outlined,),
            enableFeedback: false,
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Ionicons.chatbox_ellipses_outline,),
            enableFeedback: false,
          ),
        ],
      ),
      body: ListView(
        children: [
          PostCardHome(
            profilePhoto: Icon(Ionicons.person, color: Colors.black,),
            name: 'Divanda Firdaus',
            postImage: 'https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',
            description: 'Belum ada deskripsi'
          ),
        ],
      )
    );
  }
}
