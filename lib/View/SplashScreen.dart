import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin
{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this)..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Center(
                child: Container(
                  child: Center(child: Image(image: AssetImage("images/virus.png"),)),
                ),
              ),
              builder: (BuildContext context, Widget? child)
              {
                return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.08,
            ),
            Center(child: Text("Covid-19 \n Tracker App",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),))
            
          ],
        ),
      ),
    );
  }
}
