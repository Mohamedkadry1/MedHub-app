import 'package:flutter/material.dart';
import 'package:grad_app/const.dart';

class CustomSwitchTile extends StatefulWidget {
  const CustomSwitchTile({super.key});

  @override
  State<CustomSwitchTile> createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  bool _isDoctor = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title:_isDoctor?Text('Your role is a doctor'): Text('Register as a doctor'),
      value: _isDoctor,
      onChanged: (val) {
        setState(() {
          _isDoctor = val;
        });
      },
      secondary: _isDoctor?Image.asset('images/doctor2.png'):Image.asset('images/boy.png'),
      activeColor: primary,
    );
  }
}
