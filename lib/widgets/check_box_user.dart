import 'package:fire_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:fire_chat/block/user_chat_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;
  const CheckboxWidget({Key? key, required this.callback}) : super(key: key);
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    _checkbox = context.read<DataCubitChat>().getRememberMe;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: _checkbox,
            onChanged: (value) {
              widget.callback(value!);
              context.read<DataCubitChat>().setRememberMe(!_checkbox);
              setState(() => _checkbox = !_checkbox);
            }),
        Text(
          'Remember me',
          style: txt30,
        )
      ],
    );
  }
}
