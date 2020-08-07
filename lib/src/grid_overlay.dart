// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

//TODO check how to use this in terms of license issues

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _GridPaperPainter extends CustomPainter {
  const _GridPaperPainter({
    this.color,
    this.xInterval,
    this.yInterval,
  });

  final Color color;
  final double yInterval;
  final double xInterval;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()..color = color;

    for (double x = 0.0; x <= size.width; x += xInterval) {
      linePaint.strokeWidth = (x % 48.0 == 0.0) ? 0.6 : 0.4;
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), linePaint);
    }

    for (double y = 0.0; y <= size.height; y += yInterval) {
      linePaint.strokeWidth = (y % 48.0 == 0.0) ? 0.6 : 0.4;
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(_GridPaperPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.xInterval != xInterval ||
        oldPainter.yInterval != yInterval;
  }

  @override
  bool hitTest(Offset position) => false;
}

/// Overlay a rectangular grid to align your layouts and widgets.
///
/// Use the default 8dp x 8dp grid or set a custom grid size.
///
/// Adjust the color and opacity of the line to suite your needs.
class GridOverlay extends StatelessWidget {
  /// Creates a widget that draws a rectilinear grid of lines.
  const GridOverlay({
    Key key,
    this.gridLineColor = Colors.indigo,
    this.gridXInterval = 8.0,
    this.gridYInterval = 8.0,
  }) : super(key: key);

  /// The color to draw the lines in the grid.
  ///
  /// Defaults to a light blue commonly seen on traditional grid paper.
  final Color gridLineColor;

  /// The distance between the horizontal lines in the grid, in logical pixels.
  ///
  /// Each primary line is 0.8 logical pixel wide.
  final double gridXInterval;

  /// The distance between the vertical lines in the grid, in logical pixels.
  ///
  /// Each primary line is 0.8 logical pixel wide.
  final double gridYInterval;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _GridPaperPainter(
        color: gridLineColor,
        xInterval: gridXInterval,
        yInterval: gridYInterval,
      ),
      child: Container(),
    );
  }
}
