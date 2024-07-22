import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fubble_animations/Animations/Bubbles%20Animations/setting.dart';

import 'bubble.dart';
import 'model_logic.dart';

class Bubbles extends StatefulWidget {
  final double? bubbleCount;
  final double? maxBubbleSize;
  final double? speed;
  final Color? color;
  final double? canvasWidth;
  final double? canvasHeight;
  final String? animation;
  final String? gesture;

  const Bubbles({
    super.key,
    this.bubbleCount,
    this.maxBubbleSize,
    this.speed,
    this.color,
    this.canvasWidth,
    this.canvasHeight,
    this.animation,
    this.gesture,
  });
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Bubble> listOfBubbles = [];
  String selectedAnimation = "Default";
  String selectedGesture = "Default";

  void _addBubble(Offset position) {
    setState(() {
      Bubble newBubble = Bubble(
        widget.color ?? Colors.blue,
        widget.maxBubbleSize ?? 20,
        widget.speed ?? 0.2,
        animation: widget.animation ?? "Default",
        gesture: widget.gesture ?? "Default",
      )..x = position.dx
        ..y = position.dy;

      listOfBubbles.add(newBubble);

      // Remove the bubble after 5 seconds (adjust the duration as needed)
      Timer(const Duration(seconds: 5), () {
        setState(() {
          listOfBubbles.remove(newBubble);
        });
      });
    });
  }

  void _handleTapOrMove(DragUpdateDetails details) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(details.globalPosition);
    _addBubble(localPosition);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapUp: (details) => _addBubble(details.globalPosition),
        onPanUpdate: _handleTapOrMove,
        child: CustomPaint(
          painter: BubblePainter(
            bubbles: listOfBubbles,
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
              context, MaterialPageRoute(builder: (context) => Setting()));
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
      changeBubblePosition();
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void changeBubblePosition() {
    listOfBubbles.forEach((bubble) => bubble.changeThePosition(
        selectedAnimation ?? "Default"));
    setState(() {});
  }
}
