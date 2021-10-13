import 'package:flutter/material.dart';

const bottomMargin = 60;
const itemsCount = 8;

class TimeLinePainter extends CustomPainter {
  TimeLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    //Draw top line
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, 0),
      pathPaint,
    );
    //Draw bottom line
    canvas.drawLine(
      Offset(0, size.height - bottomMargin),
      Offset(size.width, size.height - bottomMargin),
      pathPaint,
    );

    final oneItemWidth = size.width / itemsCount;

    for (int i = 0; i <= itemsCount; i++) {
      //Draw lines
      var dx = (i * oneItemWidth);
      var heightMargin = bottomMargin - 10;
      if (i == 0 || i == itemsCount) {
        heightMargin = 20;
      }
      final heightEnd = size.height - heightMargin;
      final p1 = Offset(dx, 0);
      final p2 = Offset(dx, heightEnd);
      canvas.drawLine(p1, p2, pathPaint);

      var text = '${i * 3}:00';
      if (i < 4) {
        text = '0${i * 3}:00';
      }
      //Draw text
      final textSpan = TextSpan(
        text: text,
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
      final textDx = dx - textPainter.width / 2;
      final offset = Offset(textDx, -20);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Paint get pathPaint {
    var paint = Paint()..color = Colors.grey.withOpacity(0.5);
    paint.strokeWidth = 1.5;
    return paint;
  }

  TextStyle get textStyle {
    return const TextStyle(fontSize: 11, color: Colors.black);
  }
}
