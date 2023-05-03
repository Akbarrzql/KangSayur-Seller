import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/color_value.dart';

class otpForm extends StatefulWidget {
  const otpForm({Key? key}) : super(key: key);

  @override
  State<otpForm> createState() => _otpFormState();
}

class _otpFormState extends State<otpForm> {

  final int _duration = 30; // durasi countdown dalam detik
  late Timer _timer; // timer untuk menghitung mundur waktu
  int _remainingTime = 0; // waktu yang tersisa dalam detik
  bool _isCountdownActive = false; // menunjukkan apakah countdown sedang berjalan

  @override
  void initState() {
    super.initState();
    _remainingTime = _duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isCountdownActive = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime == 0) {
        _timer.cancel();
        _isCountdownActive = false;
      }
    });
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(30));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(30));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 63,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e1e1e).withOpacity(0.75)),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 63,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } if (value.length == 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e1e1e).withOpacity(0.75)),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 63,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } if (value.length == 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e1e1e).withOpacity(0.75)),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 63,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e1e1e).withOpacity(0.75)),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 38,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum menerima kode?",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff1e1e1e).withOpacity(0.75),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 5,),
            _isCountdownActive
                ? Text(
              '${_formatDuration(_remainingTime)}',
              style: TextStyle(
                  fontSize: 16,
                  color: ColorValue.primaryColor.withOpacity(0.75),
                  fontWeight: FontWeight.w400),
            )
                : TextButton(
              onPressed: () {
                _remainingTime = _duration;
                _startTimer();
              },
              child: Text('Kirim Ulang Kode',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ColorValue.primaryColor,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}