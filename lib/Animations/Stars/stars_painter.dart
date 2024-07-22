import 'package:flutter/material.dart';
import 'package:fubble_animations/Animations/Stars/star_model_logic.dart';

class StarPainter extends CustomPainter {
  List<Star> stars;
  Offset? offset;
  AnimationController controller;

  StarPainter({
    required this.stars,
    required this.controller,
    this.offset,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    stars.forEach((star) {
      star.draw(canvas, canvasSize);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
