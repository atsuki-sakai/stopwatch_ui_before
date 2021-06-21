import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_flutter/ui/stopwatch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXME - 時間、バッテリー残量の色を変える, SystemUIの色を変更
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Center(
          // FIXME - AspectRatio ウィジェットの子のウィジェットのアスペクト比を保つ。
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: AspectRatio(
              // 1.0:正方形, 0.0: 縦長, 1.0: 横長
              aspectRatio: 0.85,
              child: Stopwatch(),
            ),
          ),
        ),
      ),
    );
  }
}
