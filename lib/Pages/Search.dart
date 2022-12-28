import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Custom/SearchCategory.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final List<dynamic> btn = ['Pelatihan', 'Lomba', 'Seminar', 'Magang'];
  final List<dynamic> img = [
    'images/pelatihan.png',
    'images/lomba.png',
    'images/seminar.png',
    'images/magang.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        automaticallyImplyLeading: false,
        title: Text('INSEKUL', style: GoogleFonts.oleoScript(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Ionicons.search_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                isDense: true
              ),
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text('Paling Populer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              )
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3.2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: btn.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFFA0D2C7),
                        borderRadius: BorderRadius.circular(20)),
                    child: SearchCategory(
                      img: Image.asset(img[index], height: 30,),
                      category: btn[index],
                    ),
                  );
                }
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset('images/pelatihan.png'),
                      title: Text('Pelatihan', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Divider(thickness: 3, height: 0,),
                    SizedBox(
                      height: 150.0,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('post').where('eventCategory', isEqualTo: 'Pelatihan').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.data?.docs.isNotEmpty == true) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(snapshot.data?.docs[index]['postImage']),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('Tidak Ada Data'),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset('images/lomba.png'),
                      title: Text('Lomba', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Divider(thickness: 3, height: 0,),
                    SizedBox(
                      height: 150.0,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('post').where('eventCategory', isEqualTo: 'Lomba').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.data?.docs.isNotEmpty == true) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(snapshot.data?.docs[index]['postImage']),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('Tidak Ada Data'),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset('images/seminar.png'),
                      title: Text('Seminar', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Divider(thickness: 3, height: 0,),
                    SizedBox(
                      height: 150.0,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('post').where('eventCategory', isEqualTo: 'Seminar').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.data?.docs.isNotEmpty == true) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(snapshot.data?.docs[index]['postImage']),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('Tidak Ada Data'),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset('images/magang.png'),
                      title: Text('Magang', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Divider(thickness: 3, height: 0,),
                    SizedBox(
                      height: 150.0,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('post').where('eventCategory', isEqualTo: 'Magang').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.data?.docs.isNotEmpty == true) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(snapshot.data?.docs[index]['postImage']),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('Tidak Ada Data'),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
