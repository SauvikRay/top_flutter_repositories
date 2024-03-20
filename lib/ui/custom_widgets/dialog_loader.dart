import 'package:flutter/material.dart';

import 'circular_loader.dart';

showLoaderDialog(BuildContext context) {
  showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Material(color: Colors.transparent, child: CircularLoader());
      });
}
