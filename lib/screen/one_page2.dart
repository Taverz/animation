import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'two_page.dart';

class OnePage2 extends StatefulWidget {
  const OnePage2({Key? key}) : super(key: key);

  @override
  State<OnePage2> createState() => _OnePage2State();
}

class _OnePage2State extends State<OnePage2> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation opacityTween;
  late Animation sizeAnimation;
  late Animation opacityAnimation;

  late Animation positionTopAnimation;
  late Animation positionleftAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    // sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
    // positionTopAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
    positionleftAnimation =
        Tween<double>(begin: 100.0, end: 40.0).animate(controller);
    //  controller.repeat();
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Positioned(
              left: positionleftAnimation.value,
              top: 150,
              child: GestureDetector(
                onTap: () {
                  controller.forward();///Run animation
                  // controller.repeat();
                  // controller.repeat();
                  _routeP();
                  // controller.addListener(() {
                  //   setState(() {});
                  // });
                },
                child: Container(
                  height: 50,
                  width: 140,
                  color: Colors.amber.withOpacity(opacityAnimation.value),
                  child: Text("Retetwrl"),
                ),
              ),
            ),

            // SizedBox(height: 20,),
            Positioned(
              left: positionleftAnimation.value,
              top: 150 + 70,
              child: Container(
                height: 50,
                width: 140,
                color: Colors.amber.withOpacity(opacityAnimation.value),
                child: Text("Retetwrl"),
              ),
            ),
            // ),
          ],
        )),
      ),
    );
  }

  _routeP() {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return RwoPage(
    //         transitionAnimation: animation,
    //       );
    //     },
    //     transitionDuration: Duration(seconds: 1),
    //   ),
    // );
    controller.addStatusListener((status) {
     if(status == AnimationStatus.completed){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ListenableProvider(
                create: (context) => animation,
                child: RwoPage(),
              );
            },
            transitionDuration: Duration(seconds: 1),
          ),
        );  
     }
    });
    
  }
}
