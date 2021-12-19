import 'package:aplicacion_petbia/domain/controller/authentication_controller.dart';
import 'package:aplicacion_petbia/domain/controller/chat_controller.dart';
import 'package:aplicacion_petbia/domain/controller/firestore_controller.dart';
import 'package:aplicacion_petbia/domain/controller/theme_management.dart';
import 'package:aplicacion_petbia/domain/controller/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplicacion_petbia/ui/theme/theme.dart';

import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petbia',
      theme: MyTheme.ligthTheme,
      // Establecemos el tema oscuro
      darkTheme: MyTheme.darkTheme,
      // Por defecto tomara la seleccion del sistema
      themeMode: ThemeMode.system,
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error ${snapshot.error}");
            return Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // Dependency Injection
            UIController uiController = Get.put(UIController());
            uiController.themeManager = ThemeManager();
            Get.put(FirebaseController());
            Get.put(AuthenticationController());
            Get.put(ChatController());
            return FirebaseCentral();
          }

          return Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something went wrong")),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Loading")),
    );
  }
}
