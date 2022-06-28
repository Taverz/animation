
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return ListenableProvider(
                  create: (context) => animation,
                  child: SecondPage(transitionAnimation: animation,),
                );
              },
              transitionDuration: const Duration(seconds: 1),
            ),
          );
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
