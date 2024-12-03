import 'dart:ui';
import 'dart:ui' as ui;

class QuadrantBubble {
  Offset position;
  double size;
  Color color;
  String label;
  ui.Image image;

  QuadrantBubble({
    required this.position,
    required this.size,
    required this.color,
    required this.label,
    required this.image,
  });
}