import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insekul_app/Custom/Category.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/test.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key,}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  final TextEditingController _jenjang = TextEditingController(text: 'Pilih Jenjang Pendidikan');
  final TextEditingController _lokasi = TextEditingController(text: '');

  String? jenjang;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF58A191),
        title: Text('Postingan Baru'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                  child: MaterialButton(
                    onPressed: () {

                    },
                    textColor: Color(0xFF58A191),
                    child: Icon(
                      Icons.camera_alt,
                      size: 24,
                    ),
                  )
              ),
            ),
            SizedBox(height: 5),
            _textFormFields(
              valueKey: 'jenjang',
              controller: _jenjang,
              enabled: false,
              icon: Icon(Ionicons.school_outline, color: Colors.black, size: 30,),
              fct: (){
                AlertCategory(size: size, title: 'Pilih Jenjang Pendidikan', itemCount: Category.jenjang.length);
              },
              maxLenght: 100
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), //border corner radius
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value){
                  if (value!.isEmpty) {
                    return 'Value is Misssing';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 20),
                controller: _lokasi,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Ionicons.location_outline, color: Colors.black, size: 30,),
                  border: InputBorder.none,
                  suffixIcon: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Text("Maps"),
                      onPressed: () {},
                    ),
                  ),
                ),
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
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jenjang.dispose();
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLenght,
    required Icon icon,
  }) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: (){fct();},
        child: TextFormField(
          validator: (value){
            if (value!.isEmpty) {
              return 'Value is Misssing';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: icon,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _showTaskCategoriesDialog({required String title, required Size size, required int itemCount}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        _jenjang.text = Category.jenjang[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Category.jenjang[index],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Cancel', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                ),
              )
            ],
          );
        }
    );
  }
}
