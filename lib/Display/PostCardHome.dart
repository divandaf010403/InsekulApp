import 'package:flutter/material.dart';

class PostCardHome extends StatefulWidget {
  final String profilePhoto;
  final String name;
  final String postImage;
  final String description;

  PostCardHome({
    required this.profilePhoto,
    required this.name,
    required this.postImage,
    required this.description,
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
                    child: Image.network(widget.postImage),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.description, style: TextStyle(fontSize: 16),),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
