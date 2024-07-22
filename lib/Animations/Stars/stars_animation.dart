import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fubble_animations/Animations/Stars/star_model_logic.dart';
import 'package:fubble_animations/Animations/Stars/star_settings.dart';
import 'package:fubble_animations/Animations/Stars/stars_painter.dart';


class Stars extends StatefulWidget {
  final double? starCount;
  final double? maxStarSize;
  final double? speed;
  final Color? color;
  final double? canvasWidth;
  final double? canvasHeight;
  final String? animation;
  final String? gesture;

  const Stars({
    super.key,
    this.starCount,
    this.maxStarSize,
    this.speed,
    this.color,
    this.canvasWidth,
    this.canvasHeight,
    this.animation,
    this.gesture,
  });
  @override
  State<StatefulWidget> createState() {
    return _StarsState();
  }
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Star> listOfStars = [];
  String selectedAnimation = "Default";
  String selectedGesture = "Default";
  late Timer _timer;

  void _addStar(Offset position) {
    setState(() {
      Star newStar = Star(
        widget.color ?? Colors.red,
        widget.maxStarSize ?? 20,
        widget.speed ?? 0.2,
        animation: widget.animation ?? "Default",
        gesture: widget.gesture ?? "Default",
      )..x = position.dx
        ..y = position.dy;

      listOfStars.add(newStar);

      // Remove the star after 5 seconds
      _timer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            listOfStars.remove(newStar);
          });
        }
      });
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _handleTapOrMove(DragUpdateDetails details) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(details.globalPosition);
    _addStar(localPosition);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapUp: (details) {
          print('onTapUp');
          _addStar(details.globalPosition);
        },
        onPanUpdate: (details) {
          print('onPanUpdate');
          _handleTapOrMove(details);
        },
        child: CustomPaint(
          painter: StarPainter(
            stars: listOfStars,
            controller: animationController,
          ),
          size: Size(
            widget.canvasWidth ?? MediaQuery.of(context).size.width,
            widget.canvasHeight ?? MediaQuery.of(context).size.height,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StarSetting()));
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.gesture),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(minutes: 1000), vsync: this);
    animationController.addListener(() {
      changeStarPosition();
    });
    animationController.forward();
  }


  void changeStarPosition() {
    listOfStars.forEach((star) => star.changeThePosition(
        selectedAnimation ?? "Default"));
    setState(() {});
  }
}

