import 'package:flutter/material.dart';

class PostCardHome extends StatefulWidget {
  final Icon profilePhoto;
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
                  child: widget.profilePhoto,
                  color: Colors.grey.shade200,),
              ),
              title: Text(widget.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  child: Image.network('https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',),
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
    );
  }
}
