

import 'dart:math';

import 'package:animated_clipper/animated_clipper.dart';
import 'package:flutter/material.dart';

class OnePage3 extends StatefulWidget {
  const OnePage3({ Key? key }) : super(key: key);

  @override
  State<OnePage3> createState() => _OnePage3State();
}

class _OnePage3State extends State<OnePage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [

            ],
          ),
        ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _bool = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleBool(bool newValue) {
    setState(() {
      _bool = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title??""),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ClipSwitch
                Text('ClipSwitch can be tapped'),
                Text('(you must manage the state, just like Switch)'),
                SizedBox(height: 12),
                ClipSwitch(
                  value: _bool,
                  onChanged: _toggleBool,
                  inactiveWidget: SimpleBox(text: 'OFF', color: Colors.black),
                  activeWidget: SimpleBox(text: 'ON', color: Colors.blue),
                ),
                SizedBox(height: 12),
                // AnimatedCrossClip
                Text('AnimatedCrossClip toggles between two widgets'),
                Text('(these use the same state value as above)'),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedCrossClipExample(
                      value: _bool,
                      pathBuilder: PathBuilders.splitHorizontalIn,
                    ),
                    SizedBox(width: 12),
                    AnimatedCrossClipExample(
                      value: _bool,
                      pathBuilder: PathBuilders.splitVerticalOut,
                    ),
                    SizedBox(width: 12),
                    AnimatedCrossClipExample(
                      value: _bool,
                      pathBuilder: PathBuilders.circleIn,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // AnimatedClipReveal
                Text('AnimatedClipReveal reveals the child as it changes'),
                Text('You have pushed the button this many times:'),
                SizedBox(height: 12),
                AnimatedClipRevealExample(value: _counter),
                SizedBox(height: 12),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 12),
                // ClipPathTransition
                Text('ClipPathTransition animates the ClipPath'),
                Text('Use an AnimationController to drive the animation'),
                ClipPathTransitionExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class AnimatedCrossClipExample extends StatelessWidget {
  const AnimatedCrossClipExample({
    Key? key,
    required this.value,
    required this.pathBuilder,
  }) : super(key: key);

  final bool value;

  final PathBuilder pathBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossClip(
      firstChild: SimpleBox(
        text: 'FIRST',
        color: Colors.purple,
      ),
      secondChild: SimpleBox(
        text: 'SECOND',
        color: Colors.orange.shade200,
      ),
      // ...optional
      crossClipState:
          value ? CrossClipState.showSecond : CrossClipState.showFirst,
      duration: Duration(milliseconds: 300),
      pathBuilder: pathBuilder,
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
    );
  }
}


class SimpleBox extends StatelessWidget {
  const SimpleBox({
    Key? key,
    this.color = Colors.blue,
    this.text = 'BOX',
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: FittedBox(
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}



class AnimationPlayhead extends StatefulWidget {
  const AnimationPlayhead({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  _AnimationPlayheadState createState() => _AnimationPlayheadState();
}

class _AnimationPlayheadState extends State<AnimationPlayhead> {
  // When the animation controller changes value, or state
  // ...we must run `setState` to make sure the Widget re-builds
  @override
  void initState() {
    widget._controller.addListener(onValueChange);
    widget._controller.addStatusListener(onStatusChange);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(onValueChange);
    widget._controller.removeStatusListener(onStatusChange);
    super.dispose();
  }

  void onValueChange() {
    setState(() {});
  }

  void onStatusChange(AnimationStatus status) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isAnimatingForward = widget._controller.isAnimating &&
        widget._controller.status == AnimationStatus.forward;
    bool isAnimatingReverse = widget._controller.isAnimating &&
        widget._controller.status == AnimationStatus.reverse;
    Icon _forwardIcon =
        Icon(isAnimatingForward ? Icons.pause : Icons.play_arrow);
    Icon _reverseIcon =
        Icon(isAnimatingReverse ? Icons.pause : Icons.play_arrow);
    return Row(
      children: <Widget>[
        IconButton(
          icon: _forwardIcon,
          onPressed: () {
            if (!isAnimatingForward) {
              widget._controller.forward();
            } else {
              widget._controller.stop();
              setState(() {}); // Stopping an animation doesn't emit events
            }
          },
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 1,
            value: widget._controller.value,
            label: '${widget._controller.value.toStringAsPrecision(3)}',
            onChanged: (double value) {
              widget._controller.value = value;
            },
          ),
        ),
        RotatedBox(
          quarterTurns: 2,
          child: IconButton(
            icon: _reverseIcon,
            onPressed: () {
              if (!isAnimatingReverse) {
                widget._controller.reverse();
              } else {
                widget._controller.stop();
                setState(() {}); // Stopping an animation doesn't emit events
              }
            },
          ),
        ),
      ],
    );
  }
}


class ClipPathTransitionExample extends StatefulWidget {
  const ClipPathTransitionExample({
    Key? key,
  }) : super(key: key);

  @override
  _ClipPathTransitionExampleState createState() =>
      _ClipPathTransitionExampleState();
}

class _ClipPathTransitionExampleState extends State<ClipPathTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PathBuilder _pathBuilder = PathBuilders.slideUp;

  List<DropdownMenuItem<PathBuilder>> _allPathBuilders = [
    DropdownMenuItem(
      value: PathBuilders.slideUp,
      child: Text('slideUp'),
    ),
    DropdownMenuItem(
      value: PathBuilders.slideDown,
      child: Text('slideDown'),
    ),
    DropdownMenuItem(
      value: PathBuilders.slideLeft,
      child: Text('slideLeft'),
    ),
    DropdownMenuItem(
      value: PathBuilders.slideRight,
      child: Text('slideRight'),
    ),
    DropdownMenuItem(
      value: PathBuilders.splitVerticalIn,
      child: Text('splitVerticalIn'),
    ),
    DropdownMenuItem(
      value: PathBuilders.splitVerticalOut,
      child: Text('splitVerticalOut'),
    ),
    DropdownMenuItem(
      value: PathBuilders.splitHorizontalIn,
      child: Text('splitHorizontalIn'),
    ),
    DropdownMenuItem(
      value: PathBuilders.splitHorizontalOut,
      child: Text('splitHorizontalOut'),
    ),
    DropdownMenuItem(
      value: PathBuilders.circleIn,
      child: Text('circleIn'),
    ),
    DropdownMenuItem(
      value: PathBuilders.circleOut,
      child: Text('circleOut'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<PathBuilder>(
          value: _pathBuilder,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (PathBuilder? newValue) {
            if(newValue != null)
            setState(() {
              _pathBuilder = newValue!;
            });
            
          },
          items: _allPathBuilders,
        ),
        SizedBox(height: 12),
        ClipPathTransition(
          animation: _controller.drive(CurveTween(curve: Curves.easeInOut)),
          pathBuilder: _pathBuilder,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Colors.grey.shade200,
            ),
            child: FlutterLogo(
              size: 200,
            ),
          ),
        ),
        SizedBox(height: 12),
        AnimationPlayhead(
          controller: _controller,
        ),
      ],
    );

    /*
    // To demonstrate, we render the AnimatedClipStack with random params
    Color randomColor =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    Curve curve = ClipPathTransitionExample
        ._curves[widget.value % ClipPathTransitionExample._curves.length];
    Duration randomDuration =
        Duration(milliseconds: Random().nextInt(1000) + 1000);
    PathBuilder pathBuilder = ClipPathTransitionExample._pathBuilders[
        widget.value % ClipPathTransitionExample._pathBuilders.length];
    // ...whenever the `child` is changed, the stack animates
    // ...we must use a `key` since the Widget type is the same
    return AnimatedClipReveal(
      child: SimpleBox(
        key: ValueKey<int>(widget.value),
        text: '${widget.value}',
        color: randomColor,
      ),
      // ...optional params
      duration: randomDuration,
      pathBuilder: pathBuilder,
      clipBehavior: Clip.antiAlias,
      curve: curve,
      revealFirstChild: true,
    );
    */
  }
}


class AnimatedClipRevealExample extends StatelessWidget {
  const AnimatedClipRevealExample({
    Key? key,
    required this.value,
  }) : super(key: key);

  final int value;

  static List<Curve> _curves = [
    Curves.easeIn,
    Curves.easeOut,
    Curves.easeInOut,
    Curves.linear,
  ];

  static List<PathBuilder> _pathBuilders = [
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleOut,
    PathBuilders.circleIn,
    PathBuilders.circleIn,
    PathBuilders.circleIn,
    PathBuilders.circleIn,
    PathBuilders.circleIn,
    PathBuilders.circleIn,
    PathBuilders.slideUp,
    PathBuilders.slideUp,
    PathBuilders.slideLeft,
    PathBuilders.slideLeft,
    PathBuilders.slideDown,
    PathBuilders.slideDown,
    PathBuilders.slideRight,
    PathBuilders.slideRight,
    PathBuilders.splitVerticalIn,
    PathBuilders.splitVerticalIn,
    PathBuilders.splitHorizontalIn,
    PathBuilders.splitHorizontalIn,
    PathBuilders.splitVerticalOut,
    PathBuilders.splitVerticalOut,
    PathBuilders.splitHorizontalOut,
    PathBuilders.splitHorizontalOut,
  ];

  @override
  Widget build(BuildContext context) {
    // To demonstrate, we render the AnimatedClipStack with random params
    Color randomColor =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    Curve curve = _curves[value % _curves.length];
    Duration randomDuration =
        Duration(milliseconds: Random().nextInt(1000) + 1000);
    PathBuilder pathBuilder = _pathBuilders[value % _pathBuilders.length];
    // ...whenever the `child` is changed, the stack animates
    // ...we must use a `key` since the Widget type is the same
    return AnimatedClipReveal(
      child: SimpleBox(
        key: ValueKey<int>(value),
        text: '$value',
        color: randomColor,
      ),
      // ...optional params
      duration: randomDuration,
      pathBuilder: pathBuilder,
      clipBehavior: Clip.antiAlias,
      curve: curve,
      revealFirstChild: true,
    );
  }
}