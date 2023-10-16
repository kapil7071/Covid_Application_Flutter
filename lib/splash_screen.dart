import 'dart:async';

import 'package:covid/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController control =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    control.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldSate()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: control,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: Center(
                  child: Image(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Virus_green.svg/640px-Virus_green.svg.png")),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: control.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Covid -19",
              style: TextStyle(color: Colors.white, fontSize: 70),
            ),
          )
        ],
      ),
    );
  }
}
