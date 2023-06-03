import 'package:flutter/material.dart';

class DisiapkanPage extends StatefulWidget {
  const DisiapkanPage({Key? key}) : super(key: key);

  @override
  State<DisiapkanPage> createState() => _DisiapkanPageState();
}

class _DisiapkanPageState extends State<DisiapkanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Text('Disiapkan'),
      ),
    );
  }
}
