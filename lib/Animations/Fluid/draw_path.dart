import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DrawPath extends StatefulWidget {
  @override
  _DrawPathState createState() => _DrawPathState();
}

class _DrawPathState extends State<DrawPath> {
  List<FluidParticle> particles = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      _updateParticles();
    });
  }

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
        speed: Random().nextDouble() * 2.0 + 1.0,
        direction: Random().nextDouble() * 2 * pi,
        createdAt: DateTime.now(),
      ));
    });
  }

  void _updateParticles() {
    setState(() {
      particles.removeWhere((particle) =>
      DateTime.now().difference(particle.createdAt).inSeconds > 3);

      particles.forEach((particle) {
        particle.x += particle.speed * cos(particle.direction);
        particle.y += particle.speed * sin(particle.direction);

        if (particle.x < 0 || particle.x > MediaQuery.of(context).size.width) {
          particle.x = particle.x % MediaQuery.of(context).size.width;
        }
        if (particle.y < 0 || particle.y > MediaQuery.of(context).size.height) {
          particle.y = particle.y % MediaQuery.of(context).size.height;
        }
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
        ..color = particle.color.withOpacity(particle.opacity)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;

      // Create a path with a series of curves for a more organic shape
      Path path = Path()
        ..moveTo(particle.x, particle.y)
        ..quadraticBezierTo(particle.x - 20, particle.y - 20, particle.x, particle.y - 40)
        ..quadraticBezierTo(particle.x + 20, particle.y - 20, particle.x, particle.y);

      // Use drawPath to draw the path with the color and style
      canvas.drawPath(path, paint);
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
  double speed;
  double direction;
  DateTime createdAt;
  double opacity;


  FluidParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.speed,
    required this.direction,
    required this.createdAt,
    this.opacity = 1.0,

  });
}
