import 'package:flutter/material.dart';

class ConfirmDriver extends StatefulWidget {
  const ConfirmDriver({Key? key}) : super(key: key);

  @override
  State<ConfirmDriver> createState() => _ConfirmDriverState();
}

class _ConfirmDriverState extends State<ConfirmDriver> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Text('Konfirmasi Driver'),
      ),
    );
  }
}
