import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({Key? key})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(100),
          child: SizedBox(
            height: 100,
            width: double.maxFinite,
            child: Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Center(child: Text("AppBar")),
                  ],
                ),
              ),
            ),
          ),
        );
}
