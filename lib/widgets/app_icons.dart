import 'package:flutter/material.dart';

class AppIcons {
  // Custom painted Bolt Icon
  static Widget bolt({double size = 20, Color color = Colors.white}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BoltPainter(color: color),
      ),
    );
  }

  // Custom painted Facebook Icon
  static Widget facebook({double size = 22, Color color = const Color(0xFF1877F2)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _FacebookPainter(color: color),
      ),
    );
  }

  // Custom painted GitHub Icon
  static Widget gitHub({double size = 22, Color color = const Color(0xFF24292F)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GitHubPainter(color: color),
      ),
    );
  }

  // Custom painted Back Arrow Icon
  static Widget back({double size = 20, Color color = const Color(0xFF0F172A)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BackPainter(color: color),
      ),
    );
  }

  // Custom painted Close (X) Icon
  static Widget close({double size = 20, Color color = const Color(0xFF0F172A)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ClosePainter(color: color),
      ),
    );
  }

  // Custom painted Vector App Logo
  static Widget logo({double size = 54}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LogoPainter(),
      ),
    );
  }

  // Custom painted Info Icon (ⓘ)
  static Widget info({double size = 22, Color color = const Color(0xFF64748B)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _InfoPainter(color: color),
      ),
    );
  }

  // Custom painted Pie Chart Icon
  static Widget pieChart({double size = 16, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PieChartPainter(color: color),
      ),
    );
  }

  // Custom painted Assessment / Bar Chart Icon
  static Widget chart({double size = 16, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChartPainter(color: color),
      ),
    );
  }

  // Custom painted Add (+) Icon
  static Widget add({double size = 16, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AddPainter(color: color),
      ),
    );
  }

  // Custom painted Remove (-) Icon
  static Widget remove({double size = 16, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RemovePainter(color: color),
      ),
    );
  }

  // Custom painted Chevron Down Icon
  static Widget chevronDown({double size = 18, Color color = const Color(0xFF64748B)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChevronPainter(direction: _ChevronDirection.down, color: color),
      ),
    );
  }

  // Custom painted Chevron Up Icon
  static Widget chevronUp({double size = 18, Color color = const Color(0xFF64748B)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChevronPainter(direction: _ChevronDirection.up, color: color),
      ),
    );
  }

  // Custom painted Chevron Right Icon
  static Widget chevronRight({double size = 18, Color color = const Color(0xFF64748B)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChevronPainter(direction: _ChevronDirection.right, color: color),
      ),
    );
  }

  // Custom painted Copy Icon
  static Widget copy({double size = 16, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CopyPainter(color: color),
      ),
    );
  }

  // Custom painted Privacy Shield Icon
  static Widget privacy({double size = 22, Color color = const Color(0xFF2563EB)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PrivacyPainter(color: color),
      ),
    );
  }

  // Custom painted Instagram Camera Icon
  static Widget instagram({double size = 22, Color color = const Color(0xFFE1306C)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _InstagramPainter(color: color),
      ),
    );
  }

  // Custom painted LinkedIn Business Icon
  static Widget linkedIn({double size = 22, Color color = const Color(0xFF0A66C2)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LinkedInPainter(color: color),
      ),
    );
  }

  // Custom painted Phone Icon
  static Widget phone({double size = 22, Color color = const Color(0xFF10B981)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PhonePainter(color: color),
      ),
    );
  }

  // Custom painted Refresh Icon
  static Widget refresh({double size = 16, Color color = const Color(0xFF64748B)}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RefreshPainter(color: color),
      ),
    );
  }
}

class _BoltPainter extends CustomPainter {
  final Color color;
  _BoltPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.55, 0);
    path.lineTo(w * 0.15, h * 0.55);
    path.lineTo(w * 0.45, h * 0.55);
    path.lineTo(w * 0.35, h * 1.0);
    path.lineTo(w * 0.85, h * 0.42);
    path.lineTo(w * 0.55, h * 0.42);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BoltPainter oldDelegate) => oldDelegate.color != color;
}

class _InfoPainter extends CustomPainter {
  final Color color;
  _InfoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 2) / 2;

    canvas.drawCircle(center, radius, paint);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Dot on top
    canvas.drawCircle(Offset(size.width / 2, size.height * 0.3), 1.5, fillPaint);

    // Vertical line
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width / 2, size.height * 0.45),
      Offset(size.width / 2, size.height * 0.72),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _InfoPainter oldDelegate) => oldDelegate.color != color;
}

class _PieChartPainter extends CustomPainter {
  final Color color;
  _PieChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    canvas.drawArc(rect, 0, 6.28, false, paint);

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(center, Offset(size.width / 2, 1), linePaint);
    canvas.drawLine(center, Offset(size.width - 1, size.height / 2), linePaint);
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) => oldDelegate.color != color;
}

class _ChartPainter extends CustomPainter {
  final Color color;
  _ChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // 3 bars
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.05, h * 0.45, w * 0.22, h * 0.55), const Radius.circular(2)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.38, h * 0.15, w * 0.22, h * 0.85), const Radius.circular(2)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.71, h * 0.30, w * 0.22, h * 0.70), const Radius.circular(2)), paint);
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) => oldDelegate.color != color;
}

class _AddPainter extends CustomPainter {
  final Color color;
  _AddPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final midX = size.width / 2;
    final midY = size.height / 2;
    final pad = size.width * 0.2;

    canvas.drawLine(Offset(pad, midY), Offset(size.width - pad, midY), paint);
    canvas.drawLine(Offset(midX, pad), Offset(midX, size.height - pad), paint);
  }

  @override
  bool shouldRepaint(covariant _AddPainter oldDelegate) => oldDelegate.color != color;
}

class _RemovePainter extends CustomPainter {
  final Color color;
  _RemovePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final midY = size.height / 2;
    final pad = size.width * 0.2;

    canvas.drawLine(Offset(pad, midY), Offset(size.width - pad, midY), paint);
  }

  @override
  bool shouldRepaint(covariant _RemovePainter oldDelegate) => oldDelegate.color != color;
}

enum _ChevronDirection { up, down, right }

class _ChevronPainter extends CustomPainter {
  final _ChevronDirection direction;
  final Color color;
  _ChevronPainter({required this.direction, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    if (direction == _ChevronDirection.down) {
      path.moveTo(w * 0.2, h * 0.35);
      path.lineTo(w * 0.5, h * 0.65);
      path.lineTo(w * 0.8, h * 0.35);
    } else if (direction == _ChevronDirection.up) {
      path.moveTo(w * 0.2, h * 0.65);
      path.lineTo(w * 0.5, h * 0.35);
      path.lineTo(w * 0.8, h * 0.65);
    } else {
      path.moveTo(w * 0.35, h * 0.2);
      path.lineTo(w * 0.65, h * 0.5);
      path.lineTo(w * 0.35, h * 0.8);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChevronPainter oldDelegate) => oldDelegate.color != color || oldDelegate.direction != direction;
}

class _CopyPainter extends CustomPainter {
  final Color color;
  _CopyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final w = size.width;
    final h = size.height;

    // Back card
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.25, w * 0.05, w * 0.65, h * 0.65), const Radius.circular(3)), paint);
    // Front card
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.05, w * 0.25, w * 0.65, h * 0.65), const Radius.circular(3)), paint);
  }

  @override
  bool shouldRepaint(covariant _CopyPainter oldDelegate) => oldDelegate.color != color;
}

class _PrivacyPainter extends CustomPainter {
  final Color color;
  _PrivacyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.5, h * 0.08);
    path.lineTo(w * 0.88, h * 0.22);
    path.lineTo(w * 0.88, h * 0.55);
    path.cubicTo(w * 0.88, h * 0.82, w * 0.5, h * 0.95, w * 0.5, h * 0.95);
    path.cubicTo(w * 0.5, h * 0.95, w * 0.12, h * 0.82, w * 0.12, h * 0.55);
    path.lineTo(w * 0.12, h * 0.22);
    path.close();

    canvas.drawPath(path, paint);

    // Checkmark inside shield
    final checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final checkPath = Path();
    checkPath.moveTo(w * 0.35, h * 0.5);
    checkPath.lineTo(w * 0.48, h * 0.62);
    checkPath.lineTo(w * 0.68, h * 0.38);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _PrivacyPainter oldDelegate) => oldDelegate.color != color;
}

class _InstagramPainter extends CustomPainter {
  final Color color;
  _InstagramPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.25)), bgPaint);

    final whiteStroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.085;

    final bodyRect = Rect.fromLTWH(w * 0.20, h * 0.20, w * 0.60, h * 0.60);
    canvas.drawRRect(RRect.fromRectAndRadius(bodyRect, Radius.circular(w * 0.16)), whiteStroke);

    canvas.drawCircle(Offset(w * 0.50, h * 0.50), w * 0.16, whiteStroke);

    final whiteFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.64, h * 0.34), w * 0.045, whiteFill);
  }

  @override
  bool shouldRepaint(covariant _InstagramPainter oldDelegate) => oldDelegate.color != color;
}

class _LinkedInPainter extends CustomPainter {
  final Color color;
  _LinkedInPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.2)), bgPaint);

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.30, h * 0.30), w * 0.07, whitePaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.23, h * 0.42, w * 0.14, h * 0.34), Radius.circular(w * 0.03)), whitePaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.44, h * 0.42, w * 0.14, h * 0.34), Radius.circular(w * 0.03)), whitePaint);

    final nPath = Path();
    nPath.moveTo(w * 0.50, h * 0.52);
    nPath.cubicTo(w * 0.50, h * 0.40, w * 0.76, h * 0.40, w * 0.76, h * 0.54);
    nPath.lineTo(w * 0.76, h * 0.76);
    nPath.lineTo(w * 0.63, h * 0.76);
    nPath.lineTo(w * 0.63, h * 0.56);
    nPath.cubicTo(w * 0.63, h * 0.49, w * 0.56, h * 0.49, w * 0.56, h * 0.56);
    nPath.close();

    canvas.drawPath(nPath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant _LinkedInPainter oldDelegate) => oldDelegate.color != color;
}

class _PhonePainter extends CustomPainter {
  final Color color;
  _PhonePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.25)), bgPaint);

    final phonePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(w * 0.28, h * 0.22);
    path.lineTo(w * 0.44, h * 0.22);
    path.lineTo(w * 0.50, h * 0.40);
    path.lineTo(w * 0.40, h * 0.48);
    path.cubicTo(w * 0.46, h * 0.62, w * 0.58, h * 0.74, w * 0.72, h * 0.80);
    path.lineTo(w * 0.80, h * 0.70);
    path.lineTo(w * 0.98, h * 0.76);
    path.lineTo(w * 0.98, h * 0.92);
    path.cubicTo(w * 0.48, h * 0.98, w * 0.20, h * 0.70, w * 0.20, h * 0.28);
    path.close();

    canvas.drawPath(path, phonePaint);
  }

  @override
  bool shouldRepaint(covariant _PhonePainter oldDelegate) => oldDelegate.color != color;
}

class _BackPainter extends CustomPainter {
  final Color color;
  _BackPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.45, h * 0.2);
    path.lineTo(w * 0.15, h * 0.5);
    path.lineTo(w * 0.45, h * 0.8);

    canvas.drawPath(path, paint);
    canvas.drawLine(Offset(w * 0.15, h * 0.5), Offset(w * 0.85, h * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant _BackPainter oldDelegate) => oldDelegate.color != color;
}

class _ClosePainter extends CustomPainter {
  final Color color;
  _ClosePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final pad = w * 0.15;

    canvas.drawLine(Offset(pad, pad), Offset(w - pad, h - pad), paint);
    canvas.drawLine(Offset(w - pad, pad), Offset(pad, h - pad), paint);
  }

  @override
  bool shouldRepaint(covariant _ClosePainter oldDelegate) => oldDelegate.color != color;
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background rounded container with vibrant Blue fill
    final bgPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.22)), bgPaint);

    // Inner border
    final borderPaint = Paint()
      ..color = const Color(0xFF60A5FA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04;

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.22)), borderPaint);

    // Calc screen top right
    final screenPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;
    final screenOutline = Paint()
      ..color = const Color(0xFF38BDF8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.02;

    final screenRect = Rect.fromLTWH(w * 0.28, h * 0.20, w * 0.44, h * 0.12);
    canvas.drawRRect(RRect.fromRectAndRadius(screenRect, Radius.circular(w * 0.04)), screenPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(screenRect, Radius.circular(w * 0.04)), screenOutline);

    // Green indicator
    final greenPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.58, h * 0.23, w * 0.10, h * 0.06), Radius.circular(w * 0.01)), greenPaint);

    // Bolt
    final boltPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..style = PaintingStyle.fill;

    final boltPath = Path();
    boltPath.moveTo(w * 0.53, h * 0.27);
    boltPath.lineTo(w * 0.34, h * 0.56);
    boltPath.lineTo(w * 0.50, h * 0.56);
    boltPath.lineTo(w * 0.41, h * 0.83);
    boltPath.lineTo(w * 0.65, h * 0.50);
    boltPath.lineTo(w * 0.51, h * 0.50);
    boltPath.close();

    canvas.drawPath(boltPath, boltPaint);
  }

  @override
  bool shouldRepaint(covariant _LogoPainter oldDelegate) => false;
}

class _FacebookPainter extends CustomPainter {
  final Color color;
  _FacebookPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w / 2, h / 2), w / 2, bgPaint);

    final fPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final fPath = Path();
    fPath.moveTo(w * 0.62, h * 0.95);
    fPath.lineTo(w * 0.47, h * 0.95);
    fPath.lineTo(w * 0.47, h * 0.55);
    fPath.lineTo(w * 0.36, h * 0.55);
    fPath.lineTo(w * 0.36, h * 0.42);
    fPath.lineTo(w * 0.47, h * 0.42);
    fPath.lineTo(w * 0.47, h * 0.32);
    fPath.cubicTo(w * 0.47, h * 0.16, w * 0.56, h * 0.10, w * 0.70, h * 0.10);
    fPath.lineTo(w * 0.78, h * 0.10);
    fPath.lineTo(w * 0.78, h * 0.25);
    fPath.lineTo(w * 0.71, h * 0.25);
    fPath.cubicTo(w * 0.64, h * 0.25, w * 0.62, h * 0.28, w * 0.62, h * 0.34);
    fPath.lineTo(w * 0.62, h * 0.42);
    fPath.lineTo(w * 0.77, h * 0.42);
    fPath.lineTo(w * 0.75, h * 0.55);
    fPath.lineTo(w * 0.62, h * 0.55);
    fPath.close();

    canvas.drawPath(fPath, fPaint);
  }

  @override
  bool shouldRepaint(covariant _FacebookPainter oldDelegate) => oldDelegate.color != color;
}

class _GitHubPainter extends CustomPainter {
  final Color color;
  _GitHubPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // GitHub Octocat silhouette approximation
    canvas.drawCircle(Offset(w / 2, h / 2), w / 2, paint);

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Ear shapes
    final path = Path();
    path.moveTo(w * 0.30, h * 0.30);
    path.lineTo(w * 0.38, h * 0.45);
    path.lineTo(w * 0.62, h * 0.45);
    path.lineTo(w * 0.70, h * 0.30);
    path.close();

    canvas.drawPath(path, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _GitHubPainter oldDelegate) => oldDelegate.color != color;
}

class _RefreshPainter extends CustomPainter {
  final Color color;
  _RefreshPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w * 0.35;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, 0.4, 4.8, false, paint);

    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    arrowPath.moveTo(w * 0.70, h * 0.18);
    arrowPath.lineTo(w * 0.95, h * 0.35);
    arrowPath.lineTo(w * 0.70, h * 0.48);
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant _RefreshPainter oldDelegate) => oldDelegate.color != color;
}
