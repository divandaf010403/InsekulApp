import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Image? postImage;
  Timestamp? createdAt;
  String? eventDate;
  String? eventCategory;
  String? jenjang;
  String? keterangan = '';
  String? lokasi = '';
  String? postDate;
  String? name;
  String? userImage;

  void getData() async {
    // final DocumentSnapshot userDoc = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.uploadedBy)
    //     .get();
    final DocumentSnapshot Database = await FirebaseFirestore.instance
        .collection('post')
        .doc(widget.postId)
        .get();

    // if (userDoc == null) {
    //   return;
    // } else {
    //   setState(() {
    //     name = userDoc.get('name');
    //     postImage = userDoc.get('userImage');
    //   });
    // }

    if (Database == null) {
      return;
    } else {
      setState(() {
        postImage = Database.get('jobTitle');
        createdAt = Database.get('createdAt');
        eventDate = Database.get('eventDate');
        eventCategory = Database.get('eventCategory');
        jenjang = Database.get('jenjang');
        keterangan = Database.get('keterangan');
        lokasi = Database.get('lokasi');

        var postedDate = createdAt!.toDate();
        postDate = '${postedDate.year}-${postedDate.month}-${postedDate.day}';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              Text('Khusus Untuk Jenjang Pendidikan : ' +
                  jenjang! == null ? '' : jenjang!,),
              // Text('Kategori Event : ' +
              //     eventCategory! == null ? '' : eventCategory!,),
              // Text('Dilaksanakan Pada : ' +
              //     eventDate! == null ? '' : eventDate!,),
              // Text('Lokasi Event : ' +
              //     lokasi! == null ? '' : lokasi!,),
              // Divider(thickness: 2,),
              // Text(keterangan! == null ? '' : keterangan!,),
            ],
          ),
        ),
      ),
    );
  }
}
