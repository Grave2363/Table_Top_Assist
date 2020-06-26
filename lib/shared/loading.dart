import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: SpinKitHourGlass(
          color: Colors.red,
          size: 60.0,
        ),
      ),
    );
  }
}
