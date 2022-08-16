import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.inputFormatter,
    this.hint,
    this.icon,
    this.keyboardType,
    this.isPassword = false,
    this.controller,
  }) : super(key: key);
  final List<TextInputFormatter>? inputFormatter;
  final String? hint;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          icon: Icon(widget.icon),
          border: InputBorder.none,
          hintText: widget.hint,
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatter,
      ),
    );
  }
}
