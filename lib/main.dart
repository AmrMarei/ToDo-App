import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/home/tasks/edit_task_screen.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/list_provider.dart';
import 'dart:io';
import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'my_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDDza4k3CLIQCPxH2taEFPJ0j5Dq0a8kfo',
              appId: 'com.example.todo_app',
              messagingSenderId: '117832709684',
              projectId: 'todo-e9ece'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppConfigProvider()),
    ChangeNotifierProvider(create: (context) => ListProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.RoutName,
      routes: {
        HomeScreen.routName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
        RegisterScreen.RoutName: (context) => RegisterScreen(),
        LoginScreen.RoutName: (context) => LoginScreen(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
}