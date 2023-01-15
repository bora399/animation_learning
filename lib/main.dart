// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:animation_learning/main2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Animation Learning",
      home: HomePage2(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //setting animation variables
  Animation? animation;
  AnimationController? animationController;
  bool controller = false;

  //animation for changing width and height
  void sizeAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation = Tween(begin: 20.0, end: 100.0).animate(animationController!);
    animation!.addListener(() {
      setState(() {});
    });
    animation!.addStatusListener((status) => print(status));
    animationController!.forward();
  }

  //animation for changing colors
  void colorAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    animation = ColorTween(begin: Colors.yellow, end: Colors.green)
        .animate(animationController!);
    animation!.addListener(() {
      setState(() {});
    });
    animation!.addStatusListener((status) => print(status));
    animationController!.forward();
  }

  //animation for changing width and height
  void scaleAnimation() {
    int counter = 0;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController!);
    //animation!.addListener(() {
    //  setState(() {
    //    print(animation!.value);
    //  });
    //});
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.reverse();
        counter += 1;
        if (counter == 3) {
          animationController!.stop();
        }
      } else if (status == AnimationStatus.dismissed) {
        animationController!.forward();
        counter += 1;
      }
    });

    animationController!.forward();
  }

  @override
  void initState() {
    super.initState();
    //colorAnimation();
    scaleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Center(
              //  child: AnimatedLogo(animation: animation),
              //),
              Center(
                child: ScaledLogo(animation: animation),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key? key, Animation? animation})
      : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable as Animation;
    return Container(
      width: 100.0,
      height: 100.0,
      color: animation.value,
    );
  }
}

class ScaledLogo extends AnimatedWidget {
  final Tween<double> sizeAnim = Tween(begin: 0.0, end: 10.0);

  ScaledLogo({Key? key, Animation? animation})
      : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return Transform.scale(
      scale: sizeAnim.evaluate(animation),
      child: FlutterLogo(),
    );
  }
}
