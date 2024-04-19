import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.smallSized = true,
  });

  final bool smallSized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: smallSized ? 20 : 40,
          height: smallSized ? 20 : 40,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
