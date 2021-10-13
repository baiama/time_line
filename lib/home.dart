import 'package:flutter/material.dart';

import 'components/time_line_painter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double currentLeft = 0;
  double savedLeft = 0;
  late double startDeltaX;
  late double xChange;
  late final double maxX;
  late final double oneStep;
  late final double screenWidth;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    screenWidth = context.size!.width;
    oneStep = (screenWidth - 40) / itemsCount;
    maxX = (itemsCount) * oneStep;
    savedLeft = oneStep * 0;
    currentLeft = savedLeft + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Time line'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 200),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 200,
                      child: CustomPaint(
                        painter: TimeLinePainter(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: currentLeft,
                    child: GestureDetector(
                      onHorizontalDragStart: _onDragStart,
                      onHorizontalDragUpdate: _onDrag,
                      onHorizontalDragEnd: _onDragEnd,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _onDrag(DragUpdateDetails details) {
    var newOffset = details.globalPosition.dx;
    xChange = newOffset - startDeltaX;

    setState(() {
      currentLeft = (xChange + savedLeft).clamp(0, maxX);
      currentLeft = currentLeft + 10;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      currentLeft = (currentLeft / oneStep).round() * oneStep;
      currentLeft = currentLeft + 10;
      savedLeft = currentLeft;
    });
  }

  void _onDragStart(DragStartDetails details) {
    startDeltaX = details.globalPosition.dx;
  }
}
