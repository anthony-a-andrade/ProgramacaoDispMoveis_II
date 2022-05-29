import 'package:flutter/material.dart';

class RadioText extends StatefulWidget {
  final String text;
  final int value;
  final int group;
  final void Function(int?) modify;
  const RadioText(this.text, this.value, this.group, this.modify, { Key? key }) : super(key: key);

  @override
  State<RadioText> createState() => _RadioTextState();
}

class _RadioTextState extends State<RadioText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: widget.value, 
          groupValue: widget.group, 
          onChanged: widget.modify
        ),
        Text(widget.text)
      ],
    );
  }
}