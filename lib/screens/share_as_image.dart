import 'package:flutter/material.dart';

class ShareAsImagePage extends StatelessWidget {
  const ShareAsImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Text(
          'Share as Image',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
