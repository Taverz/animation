

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Onepage extends StatefulWidget {
  const Onepage({ Key? key }) : super(key: key);

  @override
  State<Onepage> createState() => _OnepageState();
}

class _OnepageState extends State<Onepage> with SingleTickerProviderStateMixin  {
  
  final int peaks = 0;
  final double fraction = 0.0;
  final Offset? centerOffset = Offset(0.0, 0.0);
  late AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: buildWW(context, 
             Column(
              children: [
                SizedBox(height: 80,),
                Container(
                  height: 100,
                  width: 200,
                  color: Colors.amber[300],
                  child: Text("Milky"),
                ),
                SizedBox(height: 80,),
                Container(
                  height: 100,
                  width: 200,
                  color: Colors.green[300],
                  child: Text("Milky"),
                ),
                SizedBox(height: 80,),
                Container(
                  height: 100,
                  width: 200,
                  color: Colors.black,
                  child: Text("Milky"),
                ),
              ],
            ),
          )
        )
      ),
    );
  }


 
   
  Widget buildWW(BuildContext _, Widget child) => 
  AnimatedBuilder(
        animation: animation,
        builder: (_, __) => ClipPath(
          clipper: CircularClipper3(
            fraction: animation.value ,
            centerOffset: centerOffset??Offset(0,0),
          ),
          child: child,
        ),
      );

  

  static double maxRadius(Size size, Offset center) {
    final width = max(center.dx, size.width - center.dx);
    final height = max(center.dy, size.height - center.dy);
    return sqrt(pow(width, 2) + pow(height, 2));
  }

  @override
  Path getClip(Size size) {
    final center = centerOffset ?? Offset(size.width / 2, size.height / 2);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(0, maxRadius(size, center), fraction)!,
        ),
      );
  }
  


  
  // Rest of the snippet as above

  @override
  Path getClip2(Size size) {
    final center = centerOffset ?? Offset(size.width / 2, size.height / 2);

    final path = Path();

    final innerRadius = lerpDouble(0, maxRadius(size, center), fraction)!;
    final outerRadius = 1.5 * innerRadius;

    for (var k = 0; k < peaks; k++) {
      /// radial offset between peaks
      /// coordinates of points are [𝑟cos(2𝜋𝑘/n+𝜋/2), 𝑟sin(2𝜋𝑘/5+𝜋/2)]
      final _bAngle = 2 * pi * k / peaks + pi / 2;
      final _sAngle = 2 * pi * k / peaks + pi / 2 + pi / peaks;

      final outerVertices =
          Offset(outerRadius * cos(_bAngle), outerRadius * sin(_bAngle));
      final innerVertices =
          Offset(innerRadius * cos(_sAngle), innerRadius * sin(_sAngle));

      if (k == 0) {
        path
          ..moveTo(outerVertices.dx, outerVertices.dy)
          ..lineTo(innerVertices.dx, innerVertices.dy);
      } else {
        path
          ..lineTo(outerVertices.dx, outerVertices.dy)
          ..lineTo(innerVertices.dx, innerVertices.dy);
      }
    }
    return Path()..addPath(path..close(), center);
  }


  // Route _colorRotationRoute({Offset? offset}) {
  //   final nextColor = colorsRotation.random();
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => ColorView(
  //       background: nextColor.values.first,
  //       text: nextColor.keys.first,
  //       animationType: animationType,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) =>
  //     CircularRevealAnimation(
  //       animation: animation,
  //       centerOffset: offset,
  //       child: child,
  //     ),
  //   );
  // }  



}

// import 'dart:math';

// import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Rect> {
  ///百分比, 0-> 1,1 => 全部显示
  final double percentage;
  final Offset offset;

  const CircularClipper({this.percentage = 0, this.offset = Offset.zero});

  @override
  Rect getClip(Size size) {
    double maxValue = maxLength(size, offset) * percentage;
    return Rect.fromLTRB(-maxValue + offset.dx, -maxValue + offset.dy, maxValue + offset.dx, maxValue + offset.dy);
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) {
    return percentage != oldClipper.percentage || offset != oldClipper.offset;
  }

  ///     |
  ///   1 |  2
  /// ---------
  ///   3 |  4
  ///     |
  double maxLength(Size size, Offset offset) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    if (offset.dx < centerX && offset.dy < centerY) {
      ///1
      return getEdge(size.width - offset.dx, size.height - offset.dy);
    } else if (offset.dx > centerX && offset.dy < centerY) {
      ///2
      return getEdge(offset.dx, size.height - offset.dy);
    } else if (offset.dx < centerX && offset.dy > centerY) {
      ///3
      return getEdge(size.width - offset.dx, offset.dy);
    } else {
      ///4
      return getEdge(offset.dx, offset.dy);
    }
  }

  double getEdge(double width, double height) {
    return sqrt(pow(width, 2) + pow(height, 2));
  }
}


class CircularClipper2 extends CustomClipper<Rect> {
  final Offset? center;
  final double fraction;

  CircularClipper2({required this.fraction, required this.center});
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromCircle(
        center: center ?? Offset(size.width / 2, size.height / 2),
        radius: size.height * this.fraction);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class CircularClipper3 extends CustomClipper<Path> {
  const CircularClipper3({required this.fraction,required this.centerOffset});
  final double fraction;
  final Offset? centerOffset;


  final int peaks = 0;

   static double maxRadius(Size size, Offset center) {
    final width = max(center.dx, size.width - center.dx);
    final height = max(center.dy, size.height - center.dy);
    return sqrt(pow(width, 2) + pow(height, 2));
  }

  @override
  Path getClip(Size size) {
    // final Path path = Path();
    // path.addOval(Rect.fromCircle(radius: fraction, center: center));
    // return path;

     final center = centerOffset ?? Offset(size.width / 2, size.height / 2);

    final path = Path();

    //  final center = centerOffset ?? Offset(size.width / 2, size.height / 2);
     path
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(0, maxRadius(size, center), fraction)!,
        ),
      );

    final innerRadius = lerpDouble(0, maxRadius(size, center), fraction)!;
    final outerRadius = 1.5 * innerRadius;

    for (var k = 0; k < peaks; k++) {
      /// radial offset between peaks
      /// coordinates of points are [𝑟cos(2𝜋𝑘/n+𝜋/2), 𝑟sin(2𝜋𝑘/5+𝜋/2)]
      final _bAngle = 2 * pi * k / peaks + pi / 2;
      final _sAngle = 2 * pi * k / peaks + pi / 2 + pi / peaks;

      final outerVertices =
          Offset(outerRadius * cos(_bAngle), outerRadius * sin(_bAngle));
      final innerVertices =
          Offset(innerRadius * cos(_sAngle), innerRadius * sin(_sAngle));

      if (k == 0) {
        path
          ..moveTo(outerVertices.dx, outerVertices.dy)
          ..lineTo(innerVertices.dx, innerVertices.dy);
      } else {
        path
          ..lineTo(outerVertices.dx, outerVertices.dy)
          ..lineTo(innerVertices.dx, innerVertices.dy);
      }
    }
    return Path()..addPath(path..close(), center);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}