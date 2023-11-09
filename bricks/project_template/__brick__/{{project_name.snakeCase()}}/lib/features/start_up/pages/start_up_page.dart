import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/context_extension.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Text(
          'Hello World',
          style: context.bodyStyle,
        ),
      ),
    );
  }
}
