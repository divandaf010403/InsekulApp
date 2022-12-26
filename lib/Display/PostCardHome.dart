import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insekul_app/SidePages/DetailEventPage.dart';

class PostCardHome extends StatefulWidget {
  final String profilePhoto;
  final String name;
  final String postImage;
  final String description;
  final String uploadedBy;
  final String postId;

  PostCardHome({
    required this.profilePhoto,
    required this.name,
    required this.postImage,
    required this.description,
    required this.uploadedBy,
    required this.postId,
});

  @override
  State<PostCardHome> createState() => _PostCardHomeState();
}

class _PostCardHomeState extends State<PostCardHome> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){},
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.network(widget.profilePhoto),
                    color: Colors.grey.shade200,),
                ),
                title: Text(widget.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    child: Image.network(widget.postImage, fit: BoxFit.fill,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.description, style: TextStyle(fontSize: 16),
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, bottom: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailEventPage(
                          uploadedBy: widget.uploadedBy,
                          postId: widget.postId,
                      )));
                    },
                    child: Text('Click for Detail', style: TextStyle(color: Colors.blue, fontSize: 17),),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
