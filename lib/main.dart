// ignore_for_file: prefer_const_constructors

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
      home: HomePage(),
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
  void sizeAnimation(){
    animationController = AnimationController(vsync:this,duration:Duration(milliseconds: 2000));
    animation = Tween(begin:20.0,end:100.0).animate(animationController!);
    animation!.addListener(() { 
      setState(() {
        
      });
    });
    animation!.addStatusListener((status) => print(status));
    animationController!.forward();
  }

  //animation for changing colors
  void colorAnimation(){
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation = ColorTween(begin: Colors.yellow, end: Colors.green)
        .animate(animationController!);
    animation!.addListener(() {
      setState(() {});
    });
    animation!.addStatusListener((status) => print(status));
    animationController!.forward();
  }

  @override
  void initState() {
    super.initState();
    colorAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Center(
              //  child: Container(
              //    width: animation!.value,
              //    height: animation!.value,
              //    color: Colors.yellow,
              //  ),
              //),
              //Center(
              //  child: ElevatedButton(
              //    onPressed: () {
              //      setState(() {
              //        if (controller == true) {
              //          animationController!.forward();
              //          controller = false;
              //        } else {
              //          animationController!.stop();
              //          controller = true;
              //          print(animation!.value);
              //        }
              //      });
              //    },
              //    child: Text("Press me"),
              //  ),
              //),
              Center(
                child: AnimatedLogo(animation: animation),
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
