import 'package:flutter/material.dart';

import 'components/time_line_painter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
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
                    child: Container(
                      height: 200,
                      color: Colors.yellow,
                      child: CustomPaint(
                        painter: TimeLinePainter(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
