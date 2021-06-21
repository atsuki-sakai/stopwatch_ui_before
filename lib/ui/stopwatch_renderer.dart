import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';

import 'clock_hand.dart';
import 'clock_markers.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer(
      {Key? key, required this.elapsed, required this.radius})
      : super(key: key);

  final Duration elapsed;
  final double radius;
  // 1秒で一周する秒針のアングル
  double get rotationZAngle => pi + (2 * pi / 60000) * elapsed.inMilliseconds;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 60; i++) ...{
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsTickMarker(
              seconds: i,
              radius: radius,
            ),
          ),
        },
        for (var i = 5; i <= 60; i += 5) ...{
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              radius: radius,
              maxValue: 60,
              value: i,
            ),
          )
        },
        Positioned(
          top: radius,
          left: radius,
          child: ClockHand(
            handLength: radius - 12,
            handThickness: 2,
            rotateZAngle: rotationZAngle,
            color: Colors.orange,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
        Positioned(
          left: radius - 10 / 2,
          top: radius - 10 / 2,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
