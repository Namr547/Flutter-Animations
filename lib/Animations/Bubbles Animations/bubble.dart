import 'package:flutter/material.dart';

import 'model_logic.dart';

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  Offset? offset;
  AnimationController controller;

  BubblePainter({
    required this.bubbles,
    required this.controller,
    this.offset
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((bubble) {
      bubble.draw(canvas, canvasSize);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
