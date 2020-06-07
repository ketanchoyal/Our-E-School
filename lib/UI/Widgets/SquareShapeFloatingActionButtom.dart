import 'package:flutter/material.dart';

class SquareNotchedShape implements NotchedShape {
  const SquareNotchedShape();

  Path getFloatingButtomPath(Rect rect) {
    return Path()
      ..moveTo(rect.left + rect.width, rect.top)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  Path getOuterPath(Rect host, Rect guest) {
    var diamondPath = getFloatingButtomPath(guest);
    var hostPath = Path()
      ..moveTo(host.left, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return Path.combine(PathOperation.difference, hostPath, diamondPath);
  }
}