import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2963AF),
        automaticallyImplyLeading: false,
        title: Text('INSEKUL', style: Theme.of(context).textTheme.headline4,),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Ionicons.chatbox_ellipses_sharp,),
            enableFeedback: false,
          )
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
