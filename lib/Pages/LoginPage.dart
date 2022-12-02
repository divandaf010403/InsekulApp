import 'package:flutter/material.dart';
import 'package:insekul_app/Custom/CustomTextInput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Pages/SignUpPage.dart';
import 'package:insekul_app/Display/BottomNav.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('Login', style: GoogleFonts.poppins(fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                ),
                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.center,
                  child: Text('INSEKUL', style: Theme.of(context).textTheme.headline1,),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('Info Seputar Kuliah', style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextInput(
                    hint: 'Email or Phone Number',
                    icon: Icon(Ionicons.mail_outline,),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextInput(
                    hint: 'Password',
                    icon: Icon(Ionicons.lock_closed_outline,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password', style: TextStyle(fontSize: 17),),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                    },
                    child: Text('Login', style: TextStyle(fontSize: 20),),
                    style: ButtonStyle(
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
              ]
          )
      ),
    );
  }
}

