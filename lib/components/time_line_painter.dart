import 'package:flutter/material.dart';

class TimeLinePainter extends CustomPainter {
  TimeLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), mainPathPaint);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), mainPathPaint);
    print(size.height);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Paint get mainPathPaint {
    var paint = Paint()..color = Colors.grey.withOpacity(0.5);
    paint.strokeWidth = 1.5;
    return paint;
  }

  Paint get halfPathPaint {
    var paint = Paint()..color = Colors.grey.withOpacity(0.3);
    paint.strokeWidth = 1.5;
    return paint;
  }

  Paint get pathPaint {
    var paint = Paint()..color = Colors.grey.withOpacity(0.2);
    paint.strokeWidth = 1.5;
    return paint;
  }
}
