import 'package:flutter/material.dart';

class BrandMark extends StatelessWidget {
  final double width;
  const BrandMark({super.key, this.width = 105});
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Farmafolio',
    image: true,
    child: ExcludeSemantics(
      child: Image.asset(
        'assets/brand/farmafolio-logo.png',
        width: width,
        height: 64,
        fit: BoxFit.contain,
      ),
    ),
  );
}
