import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PdfLoadingDialog extends StatelessWidget {
  final String animationPath;

  const PdfLoadingDialog({
    super.key,
    required this.animationPath,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Lottie.asset(
        animationPath,
        width: 500,
        height: 500,
        fit: BoxFit.contain,
      ),
    );
  }
}
