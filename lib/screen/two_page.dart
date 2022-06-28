


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RwoPage extends StatefulWidget {
  const RwoPage({ Key? key }) : super(key: key);

  @override
  State<RwoPage> createState() => _RwoPageState();
}

class _RwoPageState extends State<RwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _page()
          // Column(
          //   children: [
          //     Container(
          //       height: 100,
          //       width: 200,
          //       color: Colors.amber[300],
          //       child: Text("Milky"),
          //     ),
          //     Container(
          //       height: 100,
          //       width: 200,
          //       color: Colors.green[300],
          //       child: Text("Milky"),
          //     ),
          //     Container(
          //       height: 100,
          //       width: 200,
          //       color: Colors.accents[300],
          //       child: Text("Milky"),
          //     ),
          //   ],
          // )
        )
      ),
    );
  }


  Widget _page(
    // Animation<double> transitionAnimation
    ){
     final transitionAnimation = Provider.of<Animation<double>>(context, listen: false);
   return  Column(
      children: <Widget>[
        // Expanded remains as the direct child of a Column
        Expanded(
          child: AnimatedBuilder(
            animation: transitionAnimation,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  // X, Y - Origin (0, 0) is in the upper left corner.
                  begin: Offset(1, 0),
                  end: Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    curve: Interval(0, 0.5, curve: Curves.easeOutCubic),
                    parent: transitionAnimation,
                  ),
                ),
                child: child,
              );
            },
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: transitionAnimation,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(-1, 0),
                  end: Offset(0, 0),
                ).animate(transitionAnimation),
                child: child,
              );
            },
            child: Container(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }


}



class SlidingContainer extends StatelessWidget {
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final Color color;

  const SlidingContainer({
    Key? key,
    required this.initialOffsetX,
    required this.intervalStart,
    required this.intervalEnd,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(initialOffsetX, 0),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              curve: Interval(
                intervalStart,
                intervalEnd,
                curve: Curves.easeOutCubic,
              ),
              parent: animation,
            ),
          ),
          child: child,
        );
      },
      child: Container(
        color: color,
      ),
    );
  }
}