import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.align = Alignment.center,
    this.color = Colors.white,
  });
  final AlignmentGeometry align;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: SpinKitThreeBounce(
        color: color,
      ),
    );
  }
}
