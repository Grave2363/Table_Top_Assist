import 'package:flutter/material.dart';


class calc_btn extends StatelessWidget {
  const calc_btn({Key key, this.text, this.callback, this.fillColor, this.textSize}) : super(key: key);
  final String text;
  final double textSize;
  final int fillColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: SizedBox(
        width: 70,
        height: 70,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Text(text, style: TextStyle(fontSize: textSize),),
          onPressed: () => callback(text),
          color: Color(fillColor),
          textColor: Colors.red,
        ),
      ),
    );
  }
}
