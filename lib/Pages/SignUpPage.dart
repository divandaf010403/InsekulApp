import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insekul_app/Custom/global_methods.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Custom/CustomTextInput.dart';
import 'package:insekul_app/Display/BottomNav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _fullNameController = TextEditingController(text: '');
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _phoneController = TextEditingController(text: '');
  final TextEditingController _passController = TextEditingController(text: '');
  final TextEditingController _confirmPassController = TextEditingController(text: '');

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _confirmPassFocusNode = FocusNode();

  final _signUpFormKey = GlobalKey<FormState>();
  bool _obscureText = false;
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? imageUrl;

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
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
        sourcePath: filePath,
        maxHeight: 1000,
        maxWidth: 1000,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void _submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethod.showErrorDialog(
          error: 'Please Pick An Image',
          ctx: context,
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child('userImage').child(_uid + '.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailController.text,
          'userImage': imageUrl,
          'phoneNumber': _phoneController.text,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    _showImageDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFF58A191),),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
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
            Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextInput(
                        action: TextInputAction.next,
                        inputType: TextInputType.name,
                        focusNode: _emailFocusNode,
                        controller: _fullNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field is Missing';
                          } else {
                            return null;
                          }
                        },
                        hint: 'Full Name',
                        icon: Icon(Ionicons.person_outline),
                      ),
                      SizedBox(height: 15,),
                      CustomTextInput(
                        action: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                        focusNode: _phoneFocusNode,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field is Missing';
                          } else {
                            return null;
                          }
                        },
                        hint: 'Email',
                        icon: Icon(Ionicons.mail_outline),
                      ),
                      SizedBox(height: 15,),
                      CustomTextInput(
                        action: TextInputAction.next,
                        inputType: TextInputType.phone,
                        focusNode: _passFocusNode,
                        controller: _phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field is Missing';
                          } else {
                            return null;
                          }
                        },
                        hint: 'Phone Number',
                        icon: Icon(Ionicons.phone_landscape_outline),
                      ),
                      const SizedBox(height: 15,),
                      CustomTextInput(
                        action: TextInputAction.next,
                        inputType: TextInputType.visiblePassword,
                        focusNode: _confirmPassFocusNode,
                        controller: _passController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field is Missing';
                          } else {
                            return null;
                          }
                        },
                        hint: 'Password',
                        icon: Icon(Ionicons.lock_closed_outline),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomTextInput(
                        action: TextInputAction.next,
                        inputType: TextInputType.visiblePassword,
                        controller: _passController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field is Missing';
                          } else {
                            return null;
                          }
                        },
                        hint: 'Confirm Password',
                        icon: Icon(Ionicons.lock_closed_outline),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _submitFormOnSignUp();
                },
                child: Text('Sign Up', style: TextStyle(fontSize: 20),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF58A191)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already have an account?',
                  style: TextStyle(fontSize: 20),),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

