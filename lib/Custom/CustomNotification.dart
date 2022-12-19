import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomNotification extends StatelessWidget {

  String nama;
  String keterangan;

  CustomNotification({Key? key, required this.nama, required this.keterangan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: Icon(Ionicons.chatbox_ellipses_outline),
          title: Text('Postingan Populer'),
          subtitle: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: nama, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                TextSpan(text: ' ' + keterangan, style: TextStyle(color: Colors.black)),
              ],
            ),
          )
      ),
    );
  }
}
