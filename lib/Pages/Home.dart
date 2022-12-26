import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insekul_app/Display/PostCardHome.dart';
import 'package:insekul_app/SidePages/AddPostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insekul_app/SidePages/DetailEventPage.dart';
import 'package:insekul_app/SidePages/ChatPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name = '';

  void _getData() {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            setState(() {
              name = snapshot.data()!['name'];
            });
          }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF58A191),
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
          ),
          bottom: PreferredSize(
            preferredSize: Size(0, 50),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 17),
              constraints: BoxConstraints.expand(height: 50),
              child: Text(
                "Hi, " + name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          ),
          title: Text('INSEKUL', style: GoogleFonts.oleoScript(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),),
          actions: [
            //
            OpenContainer(
              transitionDuration: Duration(seconds: 1),
              openBuilder: (context, _) => AddPostPage(),
              openColor: Colors.white,
              middleColor: Colors.white,
              openElevation: 0,
              closedColor: Colors.transparent,
              closedElevation: 0,
              closedBuilder: (context, openContainer) {
                return Icon(Icons.add_box_outlined, size: 25,);
              },
            ),
            SizedBox(width: 15,),
            OpenContainer(
              transitionDuration: Duration(seconds: 1),
              openBuilder: (context, _) => ChatPage(),
              openColor: Colors.white,
              middleColor: Colors.white,
              openElevation: 0,
              closedColor: Colors.transparent,
              closedElevation: 0,
              closedBuilder: (context, openContainer) {
                return Icon(Ionicons.chatbox_ellipses_outline, size: 25,);
              },
            ),
            SizedBox(width: 20,)
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>> (
          stream: FirebaseFirestore.instance.collection('post').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.docs.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index){
                    return PostCardHome(
                      postId: snapshot.data?.docs[index]['postId'],
                      uploadedBy: snapshot.data?.docs[index]['uploadedBy'],
                      name: snapshot.data?.docs[index]['name'],
                      postImage: snapshot.data?.docs[index]['postImage'],
                      description: snapshot.data?.docs[index]['keterangan'],
                      profilePhoto: snapshot.data?.docs[index]['userImage'],
                    );
                  },
                );
              }
              else {
                return const Center(
                  child: Text('Info Masih Kosong'),
                );
              }
            }
            return const Center(
              child: Text(
                'Coba Cek Internet Anda',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            );
          },
        ),
    );
  }
}
