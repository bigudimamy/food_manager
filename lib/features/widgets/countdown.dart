import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CountdownPage extends StatefulWidget {

  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 0);
  Timer? timer;

  bool isTimerRunning = false;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadSound() async {
    await audioPlayer.setVolume(1);
    await audioPlayer.play(AssetSource('sounds/alarm.mp3'));
  }

  void addTime() {
    const addSeconds = -1;

    if (mounted) {
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
        if (isTimerRunning) {
          loadSound();
          isTimerRunning = false;
        }
      }
      else {
        duration = Duration(seconds: seconds);
      }
    });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    isTimerRunning = true;
  }

  void pauseTimer() {
    if (timer != null) {
      setState(() {
        timer?.cancel();
        timer = null;
      });
    }
  }

  void stopTimer() {
    setState(() {
      isTimerRunning = false;
      timer?.cancel();
      timer = null;
      duration = const Duration(hours: 0, minutes: 0, seconds: 0);
    });
  }

 @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              'Таймер',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            if (isTimerRunning) buildTime() else selectTime(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            buildButtons(),
          ],
        )
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(179, 255, 0, 1),
        borderRadius: BorderRadius.circular(35)
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.16),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: startTimer,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), // Делает кнопку круглой
              padding: const EdgeInsets.all(20), // Увеличивает размер кнопки
            ),
            child: Icon(
              Icons.play_arrow_rounded, 
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          ElevatedButton(
            onPressed: pauseTimer,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), // Делает кнопку круглой
              padding: const EdgeInsets.all(20), // Увеличивает размер кнопки
            ),
            child: Icon(Icons.pause_rounded, color: Theme.of(context).iconTheme.color,),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          ElevatedButton(
            onPressed: stopTimer,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), // Делает кнопку круглой
              padding: const EdgeInsets.all(20), // Увеличивает размер кнопки
            ),
            child: Icon(Icons.stop_rounded, color: Theme.of(context).iconTheme.color,),
          ),
        ],
      ),
    );
  }

  Widget selectTime(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.13,
      child: CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hms,
        initialTimerDuration: duration,
        onTimerDurationChanged: (Duration newDuration) {
          setState(() {
            duration = newDuration;
          });
        },
      ),
    );
  }
}