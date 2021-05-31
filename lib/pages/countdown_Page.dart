import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tataclassedgeassignment/route/routes.dart';
import 'package:timer_controller/timer_controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          child: const Center(child: _Countdowns()),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.deepPurple,
              Colors.purple,
              Colors.redAccent,
            ],
          )),
        ),
      ),
    );
  }
}

//  child: const Expanded(child: _Countdowns())
class _Countdowns extends StatefulWidget {
  const _Countdowns({
    Key? key,
  }) : super(key: key);

  @override
  __CountdownsState createState() => __CountdownsState();
}

class __CountdownsState extends State<_Countdowns> {
  late final TimerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TimerController.seconds(3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.start();
    return TimerControllerListener(
      controller: _controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        // ignore: avoid_print
        print("Timer finished ${timerValue.status}");
        Navigator.pushNamed(context, MyRoutes.homeRoute);
      },
      child: TimerControllerBuilder(
        controller: _controller,
        builder: (context, timerValue, _) {
          Color? timerColor;
          switch (timerValue.status) {
            case TimerStatus.running:
              timerColor = Colors.green;
              break;
            default:
          }
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 40,
            runSpacing: 40,
            children: <Widget>[
              CircularCountdown(
                diameter: 200,
                countdownTotal: _controller.initialValue.remaining,
                countdownRemaining: timerValue.remaining,
                countdownCurrentColor: timerColor,
                strokeWidth: 5,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: Text(widget.title),
    );
  }
}

class _StatusSnackBar extends SnackBar {
  _StatusSnackBar(
    String title,
  ) : super(
          content: Text(title),
          duration: const Duration(seconds: 1),
        );
}
