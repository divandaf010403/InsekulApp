import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insekul_app/Custom/CustomNotification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),
        title: Text('INSEKUL', style: GoogleFonts.oleoScript(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Divider(thickness: 2,),
          CustomNotification(
            nama: 'Divanda Firdaus',
            keterangan: 'Memposting Event Seminar Nasional tentang pentingnya mencintai tanah air'
          ),
          Divider(thickness: 2,),
          CustomNotification(
            nama: 'Tiara Rizky',
            keterangan: 'Memposting Event Lomba 17 Agustus di Balai Kota Semarang',
          ),
          Divider(thickness: 2,),
          CustomNotification(
            nama: 'Chaidir Ali',
            keterangan: 'Memposting Informasi Magang di perusahaan PT.Industri Indonesia',
          ),
          Divider(thickness: 2,),
        ],
      )
    );
  }
}
