import 'package:flutter/material.dart';

class HomeTabIndicator extends Decoration {
  HomeTabIndicator({
    required Color color,
  }) : _painter = _HomeTabIndicatorPainter(
          color: color,
        );
  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _HomeTabIndicatorPainter extends BoxPainter {
  final Paint _paint;
  final double _height = 2;
  final double _width = 16;

  _HomeTabIndicatorPainter({
    required Color color,
  }) : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paintSize = configuration.size ?? const Size(0, 0);
    final rect = Rect.fromLTWH(
      (paintSize.width / 2) - (_width / 2) + offset.dx,
      paintSize.height - 10,
      _width,
      _height,
    );
    canvas.drawRect(
      rect,
      _paint,
    );
  }
}
