import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Pages/SignUpPage.dart';
import 'package:insekul_app/Custom/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:insekul_app/SidePages/ForgetPaswword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passController = TextEditingController(text: '');

  final FocusNode _passFocusNode = FocusNode();
  bool _isLoading = false;
  bool _obscureText = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passController.text.trim(),
        );

        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        print('Error Occured $error');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: RotationTransition(
            turns: AlwaysStoppedAnimation(180 / 360),
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Color(0xFF58A191),
                  Color(0xFF49c2a8),
                  Color(0xFF6fe7cd),
                  Color(0xFF6fe7cd)
                ],
                durations: [3500, 19000, 10800, 6000],
                heightPercentages: [0.64, 0.66, 0.68, 0.70],
              ),
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 2,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.center,
                          child: Text('WELCOME BACK', style: GoogleFonts.roboto(fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                        ),
                        SizedBox(height: 50,),
                        Container(
                          alignment: Alignment.center,
                          child: Text('INSEKUL', style: GoogleFonts.oleoScript(fontSize: 50, fontWeight: FontWeight.w400, color: Colors.white),),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text('Info Seputar Kuliah', style: GoogleFonts.courgette(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black),),
                        ),
                        SizedBox(height: 50,),
                        Container(
                          alignment: Alignment.center,
                          child: Text('Login to your account',
                              style: GoogleFonts.poppins(fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(height: 15,),
                        Form(
                            key: _loginFormKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
                                    keyboardType: TextInputType.emailAddress,
                                    controller:_emailController,
                                    validator: (value) {
                                      if (value!.isEmpty | !value.contains('@')) {
                                        return 'Please Enter Your Valid Email Address';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        prefixIcon: Icon(Ionicons.mail_outline),
                                        hintText: 'Email',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    focusNode: _passFocusNode,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: _passController,
                                    obscureText: !_obscureText,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 7) {
                                        return 'Please Enter a Valid Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        prefixIcon: Icon(Ionicons.lock_closed_outline),
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
                                        hintText: 'Password',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        )
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                                      },
                                      child: const Text(
                                        'Forgot Password', style: TextStyle(fontSize: 17),),
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
                                    onPressed: _submitFormOnLogin,
                                    color: Color(0xFF58A191),
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Login',
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
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Does not have account?',
                                        style: TextStyle(fontSize: 20),),
                                      TextButton(
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                      ]
                  )
              ),
            ),
          ),
        )
      ],
    );
  }
}


