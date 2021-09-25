import 'package:app_ivy_v2/src/pages/chat/chat.dart';
import 'package:app_ivy_v2/src/pages/home/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarWidget(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            width: 60,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChatPage()));
              },
              child: const Text("Chat"),
            ),
          )
        ],
      ),
    );
  }
}
