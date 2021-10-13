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
  String text = '';
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    text = '';
    screenWidth = context.size!.width;
    oneStep = (screenWidth - 40) / itemsCount;
    maxX = (itemsCount) * oneStep;
    savedLeft = oneStep * 3;
    currentLeft = savedLeft + 10;
    _isReady = true;
    _updateText();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Container();
    }
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
            const SizedBox(height: 30),
            Text(
              text,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
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
      _updateText();
    });
  }

  void _updateText() {
    var time = (currentLeft / oneStep).round();
    text = '${time * 3}:00';
    if (time < 4) {
      text = '0${time * 3}:00';
    }
  }

  void _onDragEnd(DragEndDetails details) {
    _updateText();
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
