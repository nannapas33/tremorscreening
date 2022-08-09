import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PenPainter extends CustomPainter {
  final offsets;

  PenPainter(this.offsets) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red[900]!
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    for (var i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      }
      else if (offsets[i] != null && offsets[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [offsets[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
