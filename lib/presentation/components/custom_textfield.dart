import 'package:flutter/material.dart';
import '../../shared/constants.dart';
import '../../shared/styels.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String error;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final bool? isName;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    required this.error,
    this.isName,
    this.keyboardType,
    this.isPassword,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isObscure = widget.isPassword ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: (s) {
          if (s!.isEmpty) {
            return widget.error;
          }
          if (widget.isName ?? false) {
            if (!nameRegExp.hasMatch(widget.controller.text)) {
              return 'User Name is not valid';
            }
          }
          return null;
        },
        obscureText: isObscure,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.grey.shade200,
          prefixIcon: Icon(widget.prefixIcon, color: Colors.grey),
          suffixIcon: widget.isPassword ?? false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: isObscure ? Colors.grey : Colors.blue,
                  ))
              : null,
          hintText: widget.hint,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: primaryColor, width: 1.4),
          ),
        ),
      ),
    );
  }
}
