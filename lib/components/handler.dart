import 'package:flutter/material.dart';

class SliderHandlerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    const lineWidth = 1.5;
    Path line = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, lineWidth, height),
          const Radius.circular(lineWidth / 2),
        ),
      );

    canvas.drawPath(
      Path()
        ..addPath(line, const Offset(0, 0))
        ..addPath(line, Offset((width - lineWidth) / 2, 0))
        ..addPath(line, Offset(width - lineWidth, 0)),
      Paint()..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
