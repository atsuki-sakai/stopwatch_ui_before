import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';

class StopwatchTickerUI extends StatefulWidget {
  const StopwatchTickerUI({Key? key, required this.radius}) : super(key: key);
  final double radius;
  @override
  StopwatchTickerUIState createState() => StopwatchTickerUIState();
}

// Global Keyを保持する場合_を消す
class StopwatchTickerUIState extends State<StopwatchTickerUI>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _currentlyElapsed + _previouslyElapsed;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = this.createTicker((elapsed) {
      _currentlyElapsed = elapsed;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ticker.dispose();
  }

  void toggleRunning(bool isRunning) {
    setState(() {
      if (isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  void reset() {
    _ticker.stop();
    setState(() {
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: widget.radius,
          left: widget.radius,
          child: ClockHand(
            handLength: widget.radius,
            handThickness: widget.radius - 12.0,
            rotateZAngle: pi + (2 * pi / 60000) * _elapsed.inMilliseconds,
            color: Colors.orange,
          ),
        ),
        Positioned(
          top: widget.radius * 1.3,
          left: 0,
          right: 0,
          child: ElapsedTimeText(
            elapsed: _elapsed,
          ),
        )
      ],
    );
  }
}
