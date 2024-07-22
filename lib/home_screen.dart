import 'package:flutter/material.dart';
import 'Animations/Bubbles Animations/bubbles_animation.dart';
import 'Animations/Fluid/draw_drrect.dart';
import 'Animations/Fluid/draw_oval.dart';
import 'Animations/Fluid/draw_paint.dart';
import 'Animations/Fluid/draw_path.dart';
import 'Animations/Fluid/draw_rect.dart';
import 'Animations/Fluid/draw_shadow.dart';
import 'Animations/Fluid/fluid_animations.dart';
import 'Animations/Fluid/fluid_animations_1.dart';
import 'Animations/Stars/stars_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DrawShadow()));
            }, Colors.blueGrey, 'Draw Shadow'),
            MyButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DrawDRRect()));
            }, Colors.deepPurple, 'Draw DRRect'),
            MyButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DrawOval()));
            }, Colors.deepOrange, 'Draw Oval'),
            MyButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DrawPaint()));
            }, Colors.green, 'Draw Paint'),
            MyButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DrawPath()));
            }, Colors.blueAccent, 'Draw Path'),
            MyButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DrawRect()));
            }, Colors.red, 'Draw Rect'),
            MyButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FluidAnimation()));
            }, Colors.brown, 'Fluid Animation'),
            MyButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FluidAnimation1()));
            }, Colors.deepPurpleAccent, 'Fluid Animation 1'),
            MyButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Stars()));
            }, Colors.amber, 'Stars'),
            MyButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Bubbles()));
            }, Colors.purple, 'Bubbles'),
          ],
        ),
      ),
    );
  }

  Widget MyButton(Function() onPressed, Color color, String text) {
    return MaterialButton(
      onPressed: onPressed,
      highlightColor: Colors.orangeAccent,
      splashColor: Colors.yellow,
      color: color,
      height: 50,
      minWidth: 130,
      elevation: 9,
      colorBrightness: Brightness.dark,
      child: Text(text),
    );
  }
}
