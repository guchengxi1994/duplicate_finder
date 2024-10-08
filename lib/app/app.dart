import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'scanner_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ScannerScreen(),
        ),
      ),
    );
  }
}
