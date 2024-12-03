import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/quadrant_chart/bubble_util.dart';
import 'dart:ui';
import 'dart:ui' as ui;
import 'bubble.dart';

class QuadrantGraphPainter extends CustomPainter {

  final BubbleUtil bubbleUtil;
  final List<QuadrantBubble> bubbles;
  final Function(BuildContext, Offset, String)? showTooltip;

  const QuadrantGraphPainter({
    required this.bubbles,
    required this.bubbleUtil,
    this.showTooltip,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print('Size : ${size.width} ${size.height}');

    // Define the center as the origin of the graph (0,0)
    // Offset center = Offset( size.width / 2,  size.height / 2);

    drawGrids(canvas, size);
    drawAxis(canvas, size);
    drawQuadrantLabels(canvas, size);

    // Draw the bubbles
    for (int i = 0; i < bubbles.length; i++) {
      QuadrantBubble bubble = bubbles[i];
      ui.Image image = bubbles[i].image;

      Offset bubblePosition = bubble.position;
      var bubblePaint = Paint()
        ..color = bubble.color.withOpacity(0.7)
        ..style = PaintingStyle.fill;

      var bubbleStroke = Paint()
        ..color = bubble.color
        ..strokeWidth = 1.0  // Stroke thickness
        ..style = PaintingStyle.stroke;

      // Draw the bubble
      canvas.drawCircle(bubblePosition, bubble.size, bubblePaint);
      canvas.drawCircle(bubblePosition, bubble.size, bubbleStroke);

      // Draw the image inside the bubble
      double imageSize = bubbleUtil.imageSize;  // Adjust size to fit in the bubble
      Offset imagePosition = bubblePosition - Offset(imageSize / 2, imageSize / 2);
      paintImage(
        canvas: canvas,
        image: image,
        rect: Rect.fromLTWH(imagePosition.dx, imagePosition.dy, imageSize, imageSize),
        fit: BoxFit.cover,
      );
    }

  }

  void drawGrids(Canvas canvas, Size size) {
    // Draw grid lines for reference (Optional)
    var gridDistance = size.width / 7;
    var gridPaint = Paint()
      ..color = ColorUtilsV2.hex_F3F4F6
      ..strokeWidth = 1.0;
    for (double x = 1; x <= size.width + 2; x += (gridDistance)) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint); // Vertical lines
    }
    for (double y = 1; y <= size.height + 2; y += gridDistance) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint); // Horizontal lines
    }
  }

  void drawAxis(Canvas canvas, Size size){
    var axisPaint = Paint()
      ..color = ColorUtilsV2.hex_E5E7EB
      ..strokeWidth = 2.0;

    // Draw X and Y axes (centered axes)
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // X-Axis (Horizontal line through the center)
    canvas.drawLine(Offset(10, centerY), Offset(size.width - 10, centerY), axisPaint);

    // Y-Axis (Vertical line through the center)
    canvas.drawLine(Offset(centerX, 10), Offset(centerX, size.height - 10), axisPaint);

    // Draw arrow on the positive X-Axis (right side)
    drawArrow(canvas, Offset(size.width, centerY), Offset(size.width - 10, centerY - 5), Offset(size.width - 10, centerY + 5), axisPaint);
    // Draw arrow on the positive X-Axis (Left side)
    drawArrow(canvas, Offset(0, centerY), Offset(10, centerY - 5), Offset(10, centerY + 5), axisPaint);
    // Draw arrow on the positive Y-Axis (top side)
    drawArrow(canvas, Offset(centerX, 0), Offset(centerX - 5, 10), Offset(centerX + 5, 10), axisPaint);
    // Draw arrow on the positive Y-Axis (bottom side)
    drawArrow(canvas, Offset( centerX, size.height), Offset(centerX - 5,  size.height -10), Offset(centerX + 5,  size.height -10), axisPaint);

  }

  // Method to draw arrows
  void drawArrow(Canvas canvas, Offset tip, Offset leftWing, Offset rightWing, Paint paint) {
    Path path = Path();
    path.moveTo(tip.dx, tip.dy);  // Tip of the arrow
    path.lineTo(leftWing.dx, leftWing.dy);  // Left side of arrow
    // path.moveTo(tip.dx, tip.dy);
    path.lineTo(rightWing.dx, rightWing.dy);  // Right side of arrow
    // path.moveTo(tip.dx, tip.dy);
    // path.moveTo(tip.dx, tip.dy);
    path.close();  // Close the path to form a triangle
    canvas.drawPath(path, paint);  // Draw the arrow path
  }

  void drawQuadrantLabels(Canvas canvas, Size size){
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Optional: Add labels for quadrants
    var textStyle = const TextStyle(color: ColorUtilsV2.hex_717182, fontSize: 16, height: 1.5);
    // var textStyle = const TextStyle(color: Colors.black, fontSize: 16, height: 1.5);
    drawText(canvas, size, "Low\nPerformance", 0, centerY, textStyle, 1);
    drawText(canvas, size, "High    Risk", centerX, 0, textStyle, 2);
    drawText(canvas, size, "High\nPerformance", size.width, centerY, textStyle, 3);
    drawText(canvas, size, "Low    Risk", centerX, size.height, textStyle, 4);
  }

  // Helper method to draw text on the canvas (for labeling)
  void drawText(Canvas canvas, Size size, String text, double x, double y, TextStyle style, int side) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style, ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,

    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    // Calculate the offset to draw the text centered on the point
    Offset textOffset = Offset(x, y);
    if(side == 1) {
      //Left
      textOffset = Offset(x, y) - Offset(-15, textPainter.height / 1.8);
    }else if(side == 2) {
      //top
      textOffset = Offset(x, y) - Offset(textPainter.width / 2, -15);
    } else if(side == 3) {
      //Right
      textOffset = Offset(x, y) - Offset(textPainter.width + 15, textPainter.height / 1.8);
    } else {
      //bottom
      textOffset = Offset(x, y) - Offset(textPainter.width / 2, textPainter.height + 15 );
    }
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when data changes
  }
}
