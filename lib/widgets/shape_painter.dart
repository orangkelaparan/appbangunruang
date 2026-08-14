/// CustomPainter untuk menggambar ilustrasi sederhana tiap bentuk geometris
/// secara native (bukan icon generik), sesuai kebutuhan UI/UX prompt.
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Jenis bentuk yang digambar.
enum PainterShape {
  square,
  rectangle,
  triangle,
  circle,
  trapezoid,
  parallelogram,
  rhombus,
  kite,
  hexagon,
  pentagon,
  cube,
  box, // balok
  cylinder,
  cone,
  sphere,
  triangularPrism,
  squarePyramid,
  triangularPyramid,
  hemisphere,
}

/// Widget yang menggambar bentuk geometris dengan [CustomPainter].
class ShapePainter extends StatelessWidget {
  final PainterShape shape;
  final Color color;

  const ShapePainter({super.key, required this.shape, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ShapePainterDelegate(shape: shape, color: color),
    );
  }
}

class _ShapePainterDelegate extends CustomPainter {
  final PainterShape shape;
  final Color color;

  _ShapePainterDelegate({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(2.0, size.width * 0.02)
      ..strokeCap = StrokeCap.round;

    switch (shape) {
      case PainterShape.square:
        _drawSquare(canvas, size, paint, stroke);
        break;
      case PainterShape.rectangle:
        _drawRectangle(canvas, size, paint, stroke);
        break;
      case PainterShape.triangle:
        _drawTriangle(canvas, size, paint, stroke);
        break;
      case PainterShape.circle:
        _drawCircle(canvas, size, paint, stroke);
        break;
      case PainterShape.trapezoid:
        _drawTrapezoid(canvas, size, paint, stroke);
        break;
      case PainterShape.parallelogram:
        _drawParallelogram(canvas, size, paint, stroke);
        break;
      case PainterShape.rhombus:
        _drawRhombus(canvas, size, paint, stroke);
        break;
      case PainterShape.kite:
        _drawKite(canvas, size, paint, stroke);
        break;
      case PainterShape.hexagon:
        _drawPolygon(canvas, size, paint, stroke, sides: 6);
        break;
      case PainterShape.pentagon:
        _drawPolygon(canvas, size, paint, stroke, sides: 5);
        break;
      case PainterShape.cube:
        _drawCube(canvas, size, paint, stroke);
        break;
      case PainterShape.box:
        _drawBox(canvas, size, paint, stroke);
        break;
      case PainterShape.cylinder:
        _drawCylinder(canvas, size, paint, stroke);
        break;
      case PainterShape.cone:
        _drawCone(canvas, size, paint, stroke);
        break;
      case PainterShape.sphere:
        _drawSphere(canvas, size, paint, stroke);
        break;
      case PainterShape.triangularPrism:
        _drawTriangularPrism(canvas, size, paint, stroke);
        break;
      case PainterShape.squarePyramid:
        _drawSquarePyramid(canvas, size, paint, stroke);
        break;
      case PainterShape.triangularPyramid:
        _drawTriangularPyramid(canvas, size, paint, stroke);
        break;
      case PainterShape.hemisphere:
        _drawHemisphere(canvas, size, paint, stroke);
        break;
    }
  }

  void _drawSquare(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final inset = size.width * 0.12;
    final rect = Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), stroke);
  }

  void _drawRectangle(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final inset = size.width * 0.08;
    final rect = Rect.fromLTWH(inset, size.height * 0.2, size.width - inset * 2, size.height * 0.6);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), stroke);
  }

  void _drawTriangle(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.06);
    path.lineTo(size.width * 0.92, size.height * 0.9);
    path.lineTo(size.width * 0.08, size.height * 0.9);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawCircle(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final inset = size.width * 0.08;
    final rect = Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2);
    canvas.drawOval(rect, paint);
    canvas.drawOval(rect, stroke);
  }

  void _drawTrapezoid(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.12);
    path.lineTo(size.width * 0.7, size.height * 0.12);
    path.lineTo(size.width * 0.9, size.height * 0.88);
    path.lineTo(size.width * 0.1, size.height * 0.88);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawParallelogram(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final path = Path();
    path.moveTo(size.width * 0.25, size.height * 0.15);
    path.lineTo(size.width * 0.85, size.height * 0.15);
    path.lineTo(size.width * 0.6, size.height * 0.85);
    path.lineTo(size.width * 0.0, size.height * 0.85);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawRhombus(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.04);
    path.lineTo(size.width * 0.88, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.96);
    path.lineTo(size.width * 0.12, size.height * 0.5);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawKite(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.04);
    path.lineTo(size.width * 0.86, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.96);
    path.lineTo(size.width * 0.22, size.height * 0.4);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  void _drawPolygon(
      Canvas canvas, Size size, Paint paint, Paint stroke, {required int sides}) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;
    final path = Path();
    for (int i = 0; i <= sides; i++) {
      final angle = -math.pi / 2 + (2 * math.pi / sides) * i;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  /// Kubus: dua persegi bergeser dengan garis penghubung (ilustrasi 3D).
  void _drawCube(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final s = math.min(size.width, size.height) * 0.55;
    final offset = s * 0.42;
    final left = (size.width - s - offset) / 2;
    final top = (size.height - s - offset) / 2;
    final front = Rect.fromLTWH(left, top + offset, s, s);
    final back = Rect.fromLTWH(left + offset, top, s, s);
    // Sisi belakang
    final backPaint = Paint()..color = color.withOpacity(0.45)..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(back, const Radius.circular(10)), backPaint);
    // Penghubung sudut
    for (final p in <Offset>[
      Offset(front.left, front.top),
      Offset(front.right, front.top),
      Offset(front.right, front.bottom),
      Offset(front.left, front.bottom),
    ]) {
      canvas.drawLine(p, p + Offset(offset, -offset), stroke);
    }
    // Sisi depan
    canvas.drawRRect(RRect.fromRectAndRadius(front, const Radius.circular(10)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(front, const Radius.circular(10)), stroke);
    canvas.drawRRect(RRect.fromRectAndRadius(back, const Radius.circular(10)), stroke);
  }

  /// Balok: mirip kubus namun memanjang.
  void _drawBox(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = math.min(size.width, size.height) * 0.7;
    final h = w * 0.5;
    final offset = h * 0.8;
    final left = (size.width - w - offset) / 2;
    final top = (size.height - h - offset) / 2;
    final front = Rect.fromLTWH(left, top + offset, w, h);
    final back = Rect.fromLTWH(left + offset, top, w, h);
    final backPaint = Paint()..color = color.withOpacity(0.45)..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(back, const Radius.circular(10)), backPaint);
    for (final p in <Offset>[
      Offset(front.left, front.top),
      Offset(front.right, front.top),
      Offset(front.right, front.bottom),
      Offset(front.left, front.bottom),
    ]) {
      canvas.drawLine(p, p + Offset(offset, -offset), stroke);
    }
    canvas.drawRRect(RRect.fromRectAndRadius(front, const Radius.circular(10)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(front, const Radius.circular(10)), stroke);
    canvas.drawRRect(RRect.fromRectAndRadius(back, const Radius.circular(10)), stroke);
  }

  /// Tabung: dua elips + dua garis vertikal.
  void _drawCylinder(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.7;
    final h = size.height * 0.72;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    final ovalW = w * 0.35;
    final ovalH = h * 0.14;
    // Selimut (isi)
    final body = Rect.fromLTWH(left, top, w, h);
    canvas.drawRRect(RRect.fromRectAndRadius(body, Radius.circular(ovalW / 2)), paint);
    // Garis selimut
    canvas.drawLine(Offset(left, top + ovalH / 2), Offset(left, top + h - ovalH / 2), stroke);
    canvas.drawLine(Offset(left + w, top + ovalH / 2), Offset(left + w, top + h - ovalH / 2), stroke);
    // Tutup atas
    canvas.drawOval(Rect.fromLTWH(left, top, ovalW, ovalH), paint);
    canvas.drawOval(Rect.fromLTWH(left, top, ovalW, ovalH), stroke);
    // Alas bawah
    canvas.drawArc(Rect.fromLTWH(left, top + h - ovalH, ovalW, ovalH), 0, math.pi, false, stroke);
  }

  /// Kerucut: segitiga + elips alas.
  void _drawCone(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.68;
    final h = size.height * 0.78;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    final ovalW = w * 0.72;
    final ovalH = h * 0.16;
    final apex = Offset(size.width / 2, top);
    final path = Path();
    path.moveTo(apex.dx, apex.dy);
    path.lineTo(left + w, top + h - ovalH / 2);
    path.arcTo(Rect.fromLTWH(left, top + h - ovalH, ovalW, ovalH), 0, math.pi, false);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
    canvas.drawOval(Rect.fromLTWH(left, top + h - ovalH, ovalW, ovalH), stroke);
  }

  /// Bola: lingkaran + busur garis lintang.
  void _drawSphere(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final inset = size.width * 0.07;
    final rect = Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2);
    canvas.drawOval(rect, paint);
    canvas.drawOval(rect, stroke);
    // Garis ekuator (elips horizontal)
    final eqW = rect.width * 0.92;
    final eqH = rect.height * 0.28;
    final eqRect = Rect.fromCenter(
        center: rect.center, width: eqW, height: eqH);
    final arcPaint = Paint()
      ..color = Colors.white.withOpacity(0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(2.0, size.width * 0.02)
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(eqRect, math.pi, math.pi, false, arcPaint);
  }

  /// Prisma segitiga: segitiga depan-belakang dengan garis penghubung.
  void _drawTriangularPrism(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.6;
    final h = size.height * 0.62;
    final offset = w * 0.45;
    final left = (size.width - w - offset) / 2;
    final top = (size.height - h - offset * 0.5) / 2;
    Path triangle(double dx, double dy) {
      final path = Path();
      path.moveTo(dx + w * 0.5, dy);
      path.lineTo(dx + w, dy + h);
      path.lineTo(dx, dy + h);
      path.close();
      return path;
    }
    final backPaint = Paint()..color = color.withOpacity(0.45)..style = PaintingStyle.fill;
    canvas.drawPath(triangle(left + offset, top), backPaint);
    canvas.drawPath(triangle(left + offset, top), stroke);
    for (final p in <Offset>[
      Offset(left + w * 0.5, top),
      Offset(left + w, top + h),
      Offset(left, top + h),
    ]) {
      canvas.drawLine(p, p + Offset(offset, -offset * 0.5), stroke);
    }
    canvas.drawPath(triangle(left, top + offset * 0.5), paint);
    canvas.drawPath(triangle(left, top + offset * 0.5), stroke);
  }

  /// Limas segiempat: segitiga + garis belakang.
  void _drawSquarePyramid(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.66;
    final h = size.height * 0.72;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    final apex = Offset(size.width / 2, top + h * 0.1);
    final path = Path();
    path.moveTo(apex.dx, apex.dy);
    path.lineTo(left + w, top + h);
    path.lineTo(left, top + h);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
    final backPaint = Paint()
      ..color = color.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke.strokeWidth;
    canvas.drawLine(apex, Offset(left + w, top + h * 0.42), backPaint);
    canvas.drawLine(Offset(left + w, top + h * 0.42), Offset(left + w, top + h), backPaint);
  }

  /// Limas segitiga: segitiga besar + garis dalam.
  void _drawTriangularPyramid(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.7;
    final h = size.height * 0.74;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    final apex = Offset(left + w * 0.55, top + h * 0.12);
    final path = Path();
    path.moveTo(apex.dx, apex.dy);
    path.lineTo(left + w, top + h);
    path.lineTo(left, top + h * 0.85);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
    final backPaint = Paint()
      ..color = color.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke.strokeWidth;
    canvas.drawLine(apex, Offset(left, top + h * 0.85), backPaint);
    canvas.drawLine(Offset(left, top + h * 0.85), Offset(left + w, top + h), backPaint);
  }

  /// Setengah bola: setengah lingkaran + elips alas.
  void _drawHemisphere(Canvas canvas, Size size, Paint paint, Paint stroke) {
    final w = size.width * 0.72;
    final h = size.height * 0.68;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    final path = Path();
    path.addArc(Rect.fromLTWH(left, top, w, h * 2), math.pi, math.pi);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
    final ovalW = w * 0.95;
    final ovalH = h * 0.3;
    canvas.drawOval(Rect.fromCenter(
        center: Offset(size.width / 2, top + h * 2 - ovalH / 2),
        width: ovalW,
        height: ovalH), stroke);
  }

  @override
  bool shouldRepaint(covariant _ShapePainterDelegate oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.color != color;
}

/// Peta bentuk ke PainterShape per id bangun.
PainterShape painterShapeFor(String shapeId) {
  return switch (shapeId) {
    'persegi' => PainterShape.square,
    'persegi_panjang' => PainterShape.rectangle,
    'segitiga' => PainterShape.triangle,
    'lingkaran' => PainterShape.circle,
    'trapesium' => PainterShape.trapezoid,
    'jajar_genjang' => PainterShape.parallelogram,
    'belah_ketupat' => PainterShape.rhombus,
    'layang_layang' => PainterShape.kite,
    'hexagon' => PainterShape.hexagon,
    'pentagon' => PainterShape.pentagon,
    'kubus' => PainterShape.cube,
    'balok' => PainterShape.box,
    'tabung' => PainterShape.cylinder,
    'kerucut' => PainterShape.cone,
    'bola' => PainterShape.sphere,
    'prisma_segitiga' => PainterShape.triangularPrism,
    'limas_segiempat' => PainterShape.squarePyramid,
    'limas_segitiga' => PainterShape.triangularPyramid,
    'hemisphere' => PainterShape.hemisphere,
    _ => PainterShape.circle,
  };
}
