import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scanner/src/rust/frb_generated.dart';
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app.dart';

Future<void> main() async {
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    maximumSize: Size(1280, 720),
    minimumSize: Size(1280, 720),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
  );

  await windowManager.setMaximizable(false);
  await windowManager.setMinimizable(false);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}
