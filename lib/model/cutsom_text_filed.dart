import 'package:flutter/material.dart';
import 'package:grad_app/const.dart';

class CutsomTextFiled extends StatefulWidget {
  String labelText;
  String hintText;
  bool obscureText;
  bool isPassword;
  TextEditingController controller;
  String? Function(String?)? validator;
  CutsomTextFiled(
      {required this.obscureText,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.isPassword});

  @override
  State<CutsomTextFiled> createState() => _CutsomTextFiledState();
}

class _CutsomTextFiledState extends State<CutsomTextFiled> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              height: 0.05,
              letterSpacing: -0.44,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            obscureText:widget.isPassword? hidePassword:false,
            enabled: true,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: hidePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility))
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: primary, width: 2.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                hintText: widget.hintText,
                // labelText: labelText,
                hintStyle: const TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 18,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  height: 0.06,
                  letterSpacing: -0.36,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ],
    );
  }
}
