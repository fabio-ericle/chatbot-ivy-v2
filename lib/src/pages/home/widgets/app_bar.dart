import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({Key? key})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(250),
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                children: const <Widget>[
                  Text("AppBar"),
                ],
              ),
            ),
          ),
        );
}
