import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'offset_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef PositionListener(Offset offset);

class SpiderChartLabelDrawer extends CustomPainter {
  final int nbSides, sideIndex;
  final double roundSize;
  final String? label;
  final Color lineColor, activeLabelColor;
  final PositionListener? positionListener;
  Offset? labelCenter;

  SpiderChartLabelDrawer(
      {this.label,
      required this.nbSides,
      required this.sideIndex,
      required this.roundSize,
      required this.lineColor,
      required this.activeLabelColor,
      this.positionListener});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    var linePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.pinkAccent
      ..strokeWidth = 2
      ..isAntiAlias = true;
    var paneSize = size.width / 2 - 32;
    var center = Offset(size.width / 2, size.height / 2);
    labelCenter = center.rotate(paneSize, nbSides, sideIndex);
    //canvas.drawCircle(labelCenter!, roundSize, linePainter);

    final String rawSvg =
        '''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M7.91652 2.5C6.54324 2.5 5.41652 3.62672 5.41652 5C5.41652 6.37328 6.54324 7.5 7.91652 7.5H14.1665C15.5398 7.5 16.6665 6.37328 16.6665 5C16.6665 3.62672 15.5398 2.5 14.1665 2.5H7.91652ZM7.91652 3.75H10.4165V6.25H7.91652C7.21896 6.25 6.66652 5.69756 6.66652 5C6.66652 4.30244 7.21896 3.75 7.91652 3.75ZM11.6665 3.75H14.1665C14.8641 3.75 15.4165 4.30244 15.4165 5C15.4165 5.69756 14.8641 6.25 14.1665 6.25H11.6665V3.75ZM17.3387 8.75814C16.872 8.76218 16.4287 8.9472 16.035 9.23991C15.6124 9.55385 14.3409 10.5034 13.2404 11.3249C13.0018 10.5631 12.294 10 11.4582 10H9.62794C8.4566 10 7.91049 9.90509 7.44126 9.8055C6.97203 9.70591 6.51934 9.58333 5.76076 9.58333C4.1421 9.58333 2.92166 10.6221 2.12225 11.5796C1.32284 12.5371 0.889338 13.4937 0.889338 13.4937C0.855277 13.5684 0.836266 13.649 0.833391 13.7311C0.830516 13.8131 0.843834 13.895 0.872583 13.9719C0.901332 14.0488 0.944949 14.1193 1.00094 14.1793C1.05694 14.2394 1.12421 14.2878 1.19893 14.3218C1.27364 14.3559 1.35433 14.3749 1.43638 14.3777C1.51844 14.3806 1.60025 14.3672 1.67715 14.3385C1.75405 14.3097 1.82453 14.2661 1.88456 14.2101C1.9446 14.1541 1.99301 14.0868 2.02703 14.012C2.02703 14.012 2.40165 13.1958 3.08172 12.3812C3.76179 11.5666 4.6915 10.8333 5.76076 10.8333C6.39467 10.8333 6.66932 10.9191 7.18166 11.0278C7.69399 11.1366 8.3847 11.25 9.62794 11.25H11.4582C11.8109 11.25 12.0832 11.5223 12.0832 11.875C12.0832 12.0706 11.9974 12.2393 11.8626 12.3527C11.8625 12.3528 11.8456 12.3657 11.8456 12.3657C11.8335 12.3751 11.8219 12.3848 11.8106 12.395C11.8103 12.3953 11.81 12.3956 11.8097 12.3958C11.7104 12.4619 11.59 12.5 11.4582 12.5H8.54152C8.4587 12.4988 8.37647 12.5141 8.29962 12.545C8.22276 12.5759 8.15281 12.6217 8.09383 12.6799C8.03485 12.7381 7.98801 12.8073 7.95605 12.8838C7.92408 12.9602 7.90762 13.0422 7.90762 13.125C7.90762 13.2078 7.92408 13.2898 7.95605 13.3662C7.98801 13.4427 8.03485 13.5119 8.09383 13.5701C8.15281 13.6283 8.22276 13.6741 8.29962 13.705C8.37647 13.7359 8.4587 13.7512 8.54152 13.75H11.4582C11.8501 13.75 12.2146 13.6256 12.5169 13.4163C12.5174 13.416 12.5181 13.4159 12.5186 13.4155C12.5446 13.4013 12.5697 13.3853 12.5934 13.3675C12.5934 13.3675 16.1565 10.7068 16.7805 10.2433C16.7805 10.2431 16.7805 10.2428 16.7805 10.2425C17.0155 10.0677 17.2123 10.0093 17.3501 10.0081C17.4879 10.0069 17.5908 10.0404 17.7334 10.1831C17.9794 10.4289 17.9779 10.8063 17.7383 11.0555C15.507 12.9317 14.1034 14.182 13.1761 14.9146C12.2373 15.6562 11.8436 15.8333 11.4582 15.8333C9.93647 15.8333 8.25013 15.4167 6.45819 15.4167C5.41652 15.4167 4.68434 15.9765 4.29184 16.4998C3.89934 17.0232 3.76857 17.557 3.76857 17.557C3.74651 17.6373 3.74073 17.7212 3.75158 17.8038C3.76242 17.8864 3.78967 17.966 3.83172 18.038C3.87377 18.1099 3.92977 18.1727 3.99644 18.2226C4.0631 18.2726 4.13908 18.3087 4.21991 18.3289C4.30074 18.3491 4.38479 18.3529 4.46712 18.3402C4.54945 18.3274 4.62839 18.2983 4.69931 18.2546C4.77023 18.2109 4.8317 18.1534 4.88009 18.0856C4.92849 18.0178 4.96285 17.941 4.98113 17.8597C4.98113 17.8597 5.05869 17.5602 5.29119 17.2502C5.52369 16.9402 5.83319 16.6667 6.45819 16.6667C8.04457 16.6667 9.72323 17.0833 11.4582 17.0833C12.2507 17.0833 12.9519 16.6852 13.9509 15.896C14.9373 15.1168 16.3229 13.8791 18.5407 12.0142C18.5679 11.9951 18.5934 11.9738 18.6172 11.9507C18.6201 11.9478 18.6209 11.9438 18.6237 11.9409L18.6253 11.9425L18.6473 11.9198C18.7083 11.8562 18.7552 11.7805 18.7848 11.6976C19.3042 10.9674 19.2702 9.95178 18.6172 9.29932C18.2719 8.95371 17.8055 8.75412 17.3387 8.75814Z" fill="#00B4D8"/>
</svg>''';
    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);

    final Picture picture = svgRoot.toPicture();

    svgRoot.draw(canvas, Rect.zero);

    if (this.positionListener != null) {
      this.positionListener!(labelCenter!);
    }
    if (label != null) {
      var labelPainterCenter = center.rotate(paneSize + 4, nbSides, sideIndex);
      var textStyle = TextStyle(color: this.activeLabelColor);
      var textSpan = TextSpan(
        text: label,
        style: textStyle,
      );
      var textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainter.layout();
      if (sin(sideIndex * 2 * pi / nbSides) > 0) {
        textPainter.paint(
            canvas,
            Offset(labelPainterCenter.dx - textPainter.width / 2,
                labelPainterCenter.dy + 16));
      } else {
        textPainter.paint(
            canvas,
            Offset(labelPainterCenter.dx - textPainter.width / 2,
                labelPainterCenter.dy - 32));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    if (labelCenter == null) return false;
    var distance = (position - labelCenter!).distanceSquared;
    if (distance <= 256) {
      return true;
    }
    return false;
  }
}
