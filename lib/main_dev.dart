import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_template/config/environment.dart';
import 'package:flutter_bloc_template/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // …then your existing initApp() or runApp() call
  initApp(
    env: AppEnvironment.dev,
    enableLog: true,
  );
}
