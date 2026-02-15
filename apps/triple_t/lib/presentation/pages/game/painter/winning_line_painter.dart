import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  WinningLinePainter({
    required this.combination,
    required this.progress,
    required this.gap,
    required this.color,
  });

  final List<int>? combination;
  final double progress;
  final double gap;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (combination == null || progress <= 0) {
      return;
    }

    final cellSize = (size.width - gap * 2) / 3;
    final start = _cellCenter(combination!.first, cellSize, gap);
    final end = _cellCenter(combination!.last, cellSize, gap);
    final current = Offset.lerp(start, end, progress) ?? end;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, current, paint);
  }

  Offset _cellCenter(int index, double cellSize, double gap) {
    final row = index ~/ 3;
    final col = index % 3;
    final x = col * cellSize + col * gap + cellSize / 2;
    final y = row * cellSize + row * gap + cellSize / 2;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return oldDelegate.combination != combination || oldDelegate.progress != progress || oldDelegate.color != color || oldDelegate.gap != gap;
  }
}
