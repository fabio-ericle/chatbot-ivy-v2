import 'package:app_ivy_v2/src/pages/chat/chat.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                margin: const EdgeInsets.all(5),
                width: 100,
                height: 50,
                color: Colors.orange,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatPage()));
                  },
                  child: const SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text("Chat"),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
