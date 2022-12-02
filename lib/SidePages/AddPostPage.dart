import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2963AF),
        title: Text('Postingan Baru'),
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 40,),
          Container(
              child: MaterialButton(
                onPressed: () {},
                textColor: Color(0xFF2963AF),
                child: Icon(
                  Icons.camera_alt,
                  size: 24,
                ),
                padding: EdgeInsets.all(40),
                shape: CircleBorder(side: BorderSide(width: 3, color: Color(0xFF2963AF))),
              )
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Tambahkan Keterangan',
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: Color(0xFFF6F7F9),
              ),
            ),
          )
        ],
      )
    );
  }
}
