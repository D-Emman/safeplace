import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/core/firebase_options.dart';
import 'app.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
// register adapters if using Hive models
  runApp(const MyApp());