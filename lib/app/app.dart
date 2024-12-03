import 'package:scanner/app/project_view/project_view_screen.dart';
import 'package:scanner/app/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'duplicate_finder/scanner_screen.dart';
import 'hybrid_search/hybrid_search_screen.dart';
import 'sidebar/sidebar_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _Inner(),
        ),
      ),
    );
  }
}

class _Inner extends ConsumerWidget {
  const _Inner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      children: [
        Row(
          children: [
            Sidebar(),
            Expanded(
                child: PageView(
              controller: ref.read(sidebarProvider.notifier).pageController,
              children: [
                ScannerScreen(),
                ProjectViewScreen(),
                HybridSearchScreen()
              ],
            ))
          ],
        ),
        Positioned(
          top: 0,
          left: ref.watch(sidebarProvider).width,
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeLeftRight,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                ref
                    .read(sidebarProvider.notifier)
                    .changeWidth(details.delta.dx);
              },
              child: Container(
                color: Colors.transparent,
                width: 10,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
