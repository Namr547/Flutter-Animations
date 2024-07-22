import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Star {
  late Color colour;
  late double direction;
  late double speed;
  late double radius;
  late double x;
  late double y;
  late String animation;
  late String gesture;

  Star(
      Color colour,
      double maxBubbleSize,
      double speed, {
        String animation = "",
        String gesture = "",
      }) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = speed;
    this.radius = Random().nextDouble() * maxBubbleSize;
    this.x = Random().nextDouble();
    this.y = Random().nextDouble();
    this.animation = animation;
    this.gesture = gesture;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    defineOffsetCoordinateInitially(canvasSize);

    shiftTheOreintationIfCanvasBorderReached(canvasSize);

    Path starPath = createStarPath(); // Create a path for the star shape
    canvas.drawPath(starPath, paint);
  }
  // Add the radians function
  double radians(double degrees) {
    return degrees * (pi / 180);
  }

  // This method creates a path for a simple star shape
  Path createStarPath() {
    double angle = 360 / 5; // 5-pointed star
    double x = this.x;
    double y = this.y;
    double outerRadius = radius;
    double innerRadius = radius / 2;

    Path path = Path();
    path.moveTo(x + outerRadius * cos(radians(0)), y + outerRadius * sin(radians(0)));

    for (int i = 1; i <= 5; i++) {
      double currentAngle = radians(angle * i);
      if (i % 2 == 0) {
        path.lineTo(x + outerRadius * cos(currentAngle), y + outerRadius * sin(currentAngle));
      } else {
        path.lineTo(x + innerRadius * cos(currentAngle), y + innerRadius * sin(currentAngle));
      }
    }

    path.close();
    return path;
  }

  void defineOffsetCoordinateInitially(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }
//add the Star animation here
  changeThePosition(String animation) {
    switch (animation) {
      case "Default":
        {
          direction > 0 && direction < 180
              ? x = x + speed * cos(radians(direction)) / sin(speed)
              : x = x - speed * cos(radians(direction)) / sin(speed);
          direction > 90 && direction < 270
              ? y += speed * sin(radians(direction)) / sin(speed)
              : y -= speed * sin(radians(direction)) / sin(speed);
        }
        break;
      case "WallBreaker":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * cos(radians(direction)) / sin(speed) * pi
              : x = x - speed * cos(radians(direction)) / sin(speed) * pi;
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / sin(speed)
              : y -= speed * sin(angle) / sin(speed);
        }
        break;
      case "OnWeed":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / (sin(speed) * pi)
              : y -= speed * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Goodnbad":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += direction * sin(angle) / (sin(speed) * pi)
              : y -= speed * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Battle":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += direction * sin(angle) / (sin(speed) * pi)
              : y -= direction * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Rain":
        {
          //travelling wave : surface problem
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / sin(speed)
              : y -= speed * sin(angle) / sin(speed);
        }
        break;
      default:
        {
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / sin(speed)
              : x = x - speed * sin(direction) / sin(speed);
          direction > 90 && direction < 270
              ? y += speed * sin(direction) / sin(speed)
              : y -= speed * sin(direction) / sin(speed);
        }
        break;
    }
  }
//add the  gesture here

  onDraw(Offset _localPosition, Star star, BuildContext context,
      String gesture) {
    switch (gesture) {
      case "Default":
        {
          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            star.x = diffx + _localPosition.dx;
            star.y = diffy + _localPosition.dy;
          }
        }
        break;
      case "CenterBlast":
        {

          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          if (dist < 60) {
            star.x = width / 2;
            star.y = height / 2;
          }
        }
        break;
      case "Dart":
        {
          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            star.x = 0;
            star.y = 0;
          }
        }
        break;
      case "Attract":
        {
          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            star.x = _localPosition.dx;
            star.y = _localPosition.dy;
          }
        }
        break;
      case "Eraser":
        {
          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            star.x = diffx;
            star.y = diffy;
          }
        }
        break;
      default:
        {

          double diffx = _localPosition.dx - star.x;
          double diffy = _localPosition.dy - star.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            star.x = diffx + _localPosition.dx;
            star.y = diffy + _localPosition.dy;
          }
        }
        break;
    }
  }

  shiftTheOreintationIfCanvasBorderReached(Size canvasSize) {
    if (x >= canvasSize.width || x < 0 || y >= canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
