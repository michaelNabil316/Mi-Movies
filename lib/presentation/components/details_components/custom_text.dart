import 'package:flutter/material.dart';

import '../../../shared/styels.dart';

class DetailsText extends StatelessWidget {
  final String txt;
  const DetailsText({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: detailsStyle,
    );
  }
}
