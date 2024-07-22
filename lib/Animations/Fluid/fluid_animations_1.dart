import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FluidAnimation1 extends StatefulWidget {
  @override
  _FluidAnimation1State createState() => _FluidAnimation1State();
}

class _FluidAnimation1State extends State<FluidAnimation1> {
  List<FluidParticle> particles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          _addFluidParticle(details.globalPosition);
        },
        child: CustomPaint(
          painter: FluidPainter(particles),
          size: MediaQuery.of(context).size,
        ),
      ),
    );
  }

  void _addFluidParticle(Offset position) {
    setState(() {
      Color randomColor = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1.0,
      );

      particles.add(FluidParticle(
        x: position.dx,
        y: position.dy,
        radius: Random().nextDouble() * 20.0 + 5.0,
        color: randomColor,
      ));

      // Remove the particle after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          particles.removeWhere((particle) => particle == particles.last);
        });
      });
    });
  }
}

class FluidPainter extends CustomPainter {
  final List<FluidParticle> particles;

  FluidPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((particle) {
      Paint paint = Paint()
        ..color = particle.color
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(particle.x, particle.y), particle.radius, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class FluidParticle {
  double x;
  double y;
  double radius;
  Color color;

  FluidParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
  });
}
