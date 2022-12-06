import 'package:flutter/material.dart';

class HightSizedBox extends StatelessWidget {
  final double height;
  const HightSizedBox({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }
}
