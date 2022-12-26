import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),
        title: Text('Message'),
      ),
      body: Column(
        children: [
          Chat(
            nama: 'Divanda Firdaus',
            pesan: 'Halooooooo',
          ),
          Divider(thickness: 2,),
          Chat(nama: 'Tiara', pesan: 'Pagiiiiii')
        ],
      ),
    );
  }
}

class Chat extends StatelessWidget{
  String nama;
  String pesan;

  Chat({
    required this.nama,
    required this.pesan
});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Ionicons.person, color: Colors.black, size: 30,),
        title: Text(nama, style: TextStyle(fontSize: 20),),
        subtitle: Text(pesan, style: TextStyle(fontSize: 16)),
        dense: true,
      )
    );
  }
}
