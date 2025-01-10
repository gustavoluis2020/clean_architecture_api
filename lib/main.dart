import 'package:clean_architecture_api/core/routes/app_pages.dart';
import 'package:clean_architecture_api/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clean Architecture Api',
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.users,
    );
  }
}
