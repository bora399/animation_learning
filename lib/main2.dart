import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>
    with SingleTickerProviderStateMixin {
  //setting animation variables
  Animation? animation;
  AnimationController? animationController;
  bool controller = false;
  double begin = -1.0;
  double end = 1.0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.fastOutSlowIn,
    ));

    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.reset();
        animation = Tween(begin:0.0,end:1.0).animate(CurvedAnimation(
          parent: animationController!,
          curve: Curves.fastOutSlowIn,
        ));
        animationController!.forward();
      }
    });
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, child) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  transform: Matrix4.translationValues(
                      animation!.value * width, 0.0, 0.0),
                  child: Center(
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
