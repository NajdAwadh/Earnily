import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ProcessingWidget extends StatelessWidget {
  const ProcessingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: const Color(0xffd0d0d2),
        child: Image.asset(
          'assets/images/EarnilyLogo.png',
          height: 120,
        ));
  }
}
