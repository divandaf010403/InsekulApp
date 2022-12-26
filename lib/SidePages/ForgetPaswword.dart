import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insekul_app/Pages/LoginPage.dart';
import 'package:insekul_app/Custom/CustomTextInput.dart';

class ForgetPassword extends StatefulWidget {

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with TickerProviderStateMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _forgetPassTextController = TextEditingController(text: '');

  void _forgetPassSubmitForm() async {
    try {
      await _auth.sendPasswordResetEmail(
        email: _forgetPassTextController.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

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
                heightPercentages: [0.60, 0.62, 0.64, 0.70],
              ),
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 2,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                      ),
                    ),
                    const SizedBox(height: 40,),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    // TextField(
                    //   controller: _forgetPassTextController,
                    //   decoration: const InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white54,
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.white),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                    CustomTextInput(
                      controller: _forgetPassTextController,
                      icon: Icon(Ionicons.mail_outline),
                      hint: 'Email',
                    ),
                    const SizedBox(height: 20,),
                    MaterialButton(
                      onPressed: () {
                        //forgetPass
                        _forgetPassSubmitForm();
                      },
                      color: Colors.cyan,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        )
      ],
    );
  }
}