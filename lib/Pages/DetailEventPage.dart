import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailEventPage extends StatefulWidget {

  final String uploadedBy;
  final String postId;

  DetailEventPage({
    required this.uploadedBy,
    required this.postId,
});

  @override
  State<DetailEventPage> createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Image? postImage;
  Timestamp? createdAt;
  String? eventDate;
  String? eventCategory;
  String? jenjang;
  String? keterangan = '';
  String? lokasi = '';
  String? postDate;

  void getDetailData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadedBy)
        .get();

    final DocumentSnapshot postData = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(widget.postId)
        .get();

    if (postData == null) {
      return;
    } else {
      setState(() {
        postImage = postData.get('postImage');
        createdAt = postData.get('createdAt');
        eventCategory = postData.get('eventCategory');
        jenjang = postData.get('jenjang');
        keterangan = postData.get('keterangan');
        lokasi = postData.get('lokasi');
        eventDate = postData.get('eventDate');

        var postedDate = createdAt!.toDate();
        postDate = '${postedDate.year}-${postedDate.month}-${postedDate.day}';
      });
      // var date = eventDate!.toDate();
      // eventDay = date.isAfter(DateTime.now());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        title: Text('Postingan Baru'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Divider(thickness: 2,),
              Text('Khusus Untuk Jenjang Pendidikan : ' + jenjang!),
              Text('Kategori Event : ' + eventCategory!),
              Text('Dilaksanakan Pada : ' + eventDate!),
              Text('Lokasi Event : ' + lokasi!),
              Divider(thickness: 2,),
              Text(keterangan!),
            ],
          ),
        ),
      ),
    );
  }
}
