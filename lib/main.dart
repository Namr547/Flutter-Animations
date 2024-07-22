import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fubble_animations/Animations/Fluid/draw_path.dart';
import 'package:fubble_animations/home_screen.dart';

import 'Animations/Fluid/draw_drrect.dart';
import 'Animations/Fluid/draw_oval.dart';
import 'Animations/Fluid/draw_paint.dart';
import 'Animations/Fluid/draw_rect.dart';
import 'Animations/Fluid/draw_shadow.dart';
import 'Animations/Fluid/fluid_animations.dart';
import 'Animations/Fluid/fluid_animations_1.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fubble',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:  HomeScreen(),
    );
  }
}
//below are the list of animations you can call any of them
// DrawShadow  DrawDRRect   DrawOval   DrawPaint   DrawPath   DrawRect   FluidAnimation  FluidAnimation1

