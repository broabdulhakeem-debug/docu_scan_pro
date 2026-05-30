import 'package:flutter/material.dart';

class AnnotationCanvas extends StatefulWidget {
  final Function(List<Offset> points)? onStrokeComplete;

  const AnnotationCanvas({super.key, this.onStrokeComplete});

  @override
  State<AnnotationCanvas> createState() => _AnnotationCanvasState();
}

class _AnnotationCanvasState extends State<AnnotationCanvas> {
  List<Offset> points = [];
  List<List<Offset>> strokes = [];

  void _addPoint(Offset point) {
    setState(() {
      points.add(point);
    });
  }

  void _endStroke() {
    if (points.isNotEmpty) {
      strokes.add(List.from(points));
      widget.onStrokeComplete?.call(points);
      points.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        _addPoint(details.localPosition);
      },
      onPanEnd: (_) => _endStroke(),
      child: CustomPaint(
        painter: _CanvasPainter(strokes: strokes, current: points),
        size: Size.infinite,
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> current;

  _CanvasPainter({required this.strokes, required this.current});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (final stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }

    for (int i = 0; i < current.length - 1; i++) {
      canvas.drawLine(current[i], current[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}