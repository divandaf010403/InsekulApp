import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insekul_app/Custom/Category.dart';
import 'package:insekul_app/Custom/global_methods.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insekul_app/Custom/user.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key,}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  final TextEditingController _jenjang = TextEditingController(text: '');
  final TextEditingController _eventCategory = TextEditingController(text: '');
  final TextEditingController _lokasi = TextEditingController(text: '');
  final TextEditingController _keterangan = TextEditingController(text: '');
  final TextEditingController _eventDate = TextEditingController(text: '');

  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? postImage;
  DateTime? picked;
  Timestamp? timeStamp;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void _posting() async {
    final postId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (_eventCategory.text == 'Pilih Kategori Event' || _jenjang.text == 'Pilih Jenjang Pedidikan' || _lokasi.text == 'Pilih Lokasi Acara' || imageFile == null || _keterangan.text == 'Isi Keterangan') {
        GlobalMethod.showErrorDialog(
            error: 'Pastikan Semua Sudah Diisi', ctx: context
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        final ref = FirebaseStorage.instance.ref().child('postImage').child(postId + '.jpg');
        await ref.putFile(imageFile!);
        postImage = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('post').doc(postId).set({
          'postId': postId,
          'uploadedBy': _uid,
          'email': user.email,
          'postImage': postImage,
          'eventCategory': _eventCategory.text,
          'jenjang': _jenjang.text,
          'lokasi': _lokasi.text,
          'eventDate': _eventDate.text,
          'keterangan': _keterangan.text,
          'name': name,
          'userImage': userImage,
          'createdAt': Timestamp.now(),
        });
        await Fluttertoast.showToast(
          msg: 'Upload Berhasil',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          fontSize: 18.0,
        );
        Navigator.pop(context);
      } catch (error) {
        {
          setState(() {
            _isLoading = false;
          });
          GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        }
      }
      finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    else {
      print('Its Not Valid');
    }
  }

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = userDoc.get('name');
      userImage = userDoc.get('userImage');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showImageDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          // height: size.width * 0.5,
                          constraints: BoxConstraints(
                            minHeight: size.width * 0.5,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Color(0xFF58A191),),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: imageFile == null
                                ? const Icon(Icons.camera_enhance_rounded, color: Color(0xFF58A191), size: 40,)
                                : Image.file(imageFile!, fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                _textFormFields(
                    valueKey: 'event',
                    controller: _eventCategory,
                    enabled: false,
                    hint: 'Pilih Kategori Event',
                    icon: Icon(Ionicons.list_outline, color: Colors.black),
                    fct: (){
                      _showContentCategoriesDialog(size: size, title: 'Pilih Kategori Event', itemCount: Category.eventCategory.length,
                      );
                    },
                    maxLenght: 100
                ),
                SizedBox(height: 20,),
                _textFormFields(
                    valueKey: 'jenjang',
                    controller: _jenjang,
                    enabled: false,
                    hint: 'Pilih Jenjang Pendidikan',
                    icon: Icon(Ionicons.school_outline, color: Colors.black),
                    fct: (){
                      _showTaskCategoriesDialog(size: size, title: 'Pilih Jenjang Pendidikan', itemCount: Category.jenjang.length,
                      );
                    },
                    maxLenght: 100
                ),
                SizedBox(height: 20,),
                Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
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
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 17),
                      controller: _lokasi,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Lokasi Event',
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(Ionicons.location_outline, color: Colors.black),
                        border: InputBorder.none,
                        // suffixIcon: Container(
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.blue,
                        //       shape: new RoundedRectangleBorder(
                        //         borderRadius: new BorderRadius.circular(50.0),
                        //       ),
                        //     ),
                        //     child: Text("Maps"),
                        //     onPressed: () {},
                        //   ),
                        // ),
                      ),
                    )
                ),
                SizedBox(height: 20,),
                _textFormFields(
                    valueKey: 'eventDate',
                    controller: _eventDate,
                    enabled: false,
                    hint: 'Tanggal Event',
                    icon: Icon(Ionicons.school_outline, color: Colors.black),
                    fct: (){
                      _pickDateDialog();
                    },
                    maxLenght: 100
                ),
                const SizedBox(height: 20,),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _keterangan,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Tambahkan Keterangan',
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Color(0xFFF6F7F9),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                _isLoading
                    ?
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const CircularProgressIndicator(),
                  ),
                )
                    :
                MaterialButton(
                  onPressed: (){
                    _posting();
                  },
                  color: Colors.cyan,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jenjang.dispose();
    _lokasi.dispose();
    _eventCategory.dispose();
    _keterangan.dispose();
    _eventDate.dispose();
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLenght,
    required Icon icon,
    required String hint,
  }) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
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
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: 17),
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.all(10.0),
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
            title: Text(title, style: TextStyle(fontSize: 20, color: Colors.white),),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {_jenjang.text = Category.jenjang[index];});
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_right_alt_outlined, color: Colors.grey,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(Category.jenjang[index], style: const TextStyle(color: Colors.grey, fontSize: 16,),
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
                onPressed: (){Navigator.canPop(context) ? Navigator.pop(context) : null;},
                child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 16,),
                ),
              )
            ],
          );
        }
    );
  }

  _showContentCategoriesDialog({required String title, required Size size, required int itemCount}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: Text(title, style: TextStyle(fontSize: 20, color: Colors.white),),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {_eventCategory.text = Category.eventCategory[index];});
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_right_alt_outlined, color: Colors.grey,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(Category.eventCategory[index], style: const TextStyle(color: Colors.grey, fontSize: 16,),
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
                onPressed: (){Navigator.canPop(context) ? Navigator.pop(context) : null;},
                child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 16,),
                ),
              )
            ],
          );
        }
    );
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please Chose An Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    //Image From Camera
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    //Image From Gallery
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath, maxHeight: 1000, maxWidth: 1000
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _eventDate.text = '${picked!.day} - ${picked!.month} - ${picked!.year}';
        timeStamp = Timestamp.fromMicrosecondsSinceEpoch(picked!.microsecondsSinceEpoch);
      });
    }
  }
}
