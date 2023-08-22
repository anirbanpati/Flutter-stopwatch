import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stopwatch? stopwatch;
  Timer? t;

  void handleStartStop() {
    if (stopwatch!.isRunning) {
      stopwatch!.stop();
    } else {
      stopwatch!.start();
    }
  }

  String returnFormattedText() {
    var milli = stopwatch!.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    String hours = ((milli ~/ 1000) ~/ 3600).toString().padLeft(2, "0");
    return "$hours:$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        backgroundColor: Colors.blueAccent[400],
        title: const Text(
          'Stopwatch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 70.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            onPressed: () {
              handleStartStop();
            },
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff0395eb), width: 4)),
              child: Text(
                returnFormattedText(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          IconButton(
              onPressed: () {
                stopwatch!.reset();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.redAccent,
                size: 40,
              ))
        ],
      ))),
    );
  }
}
