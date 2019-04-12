import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finger print scan animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FingerScanAnimationDemo(),
    );
  }
}

class FingerScanAnimation extends StatelessWidget {
  FingerScanAnimation({Key key, this.controller})
      : height = Tween<double>(begin: 0.0, end: 128.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.500,
              curve: Curves.easeInOutSine,
            ),
          ),
        ),
        borderWidth = Tween<double>(begin: 3.0, end: 7.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.500,
              curve: Curves.easeInOutSine,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> height;
  final Animation<double> borderWidth;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment(0, 0),
            children: <Widget>[
              Icon(
                Icons.fingerprint,
                color: Colors.white,
                size: 128,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 128,
                  height: height.value,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                    border: Border(
                      top: BorderSide(
                        width: borderWidth.value,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class FingerScanAnimationDemo extends StatefulWidget {
  @override
  _FingerScanAnimationDemoState createState() =>
      _FingerScanAnimationDemoState();
}

class _FingerScanAnimationDemoState extends State<FingerScanAnimationDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 256,
          width: 256,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              stops: [0.2, 0.1, 0.5, 0.8],
              focal: AlignmentDirectional.center,
              colors: [
                Color.fromRGBO(56, 6, 107, 5),
                Color.fromRGBO(39, 7, 103, 5),
                Color.fromRGBO(80, 5, 109, 1),
                Color.fromRGBO(56, 6, 107, 5),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 2,
                color: Color.fromRGBO(39, 7, 103, 5),
              )
            ],
          ),
          child: FingerScanAnimation(controller: _controller),
        ),
      ),
    );
  }
}
