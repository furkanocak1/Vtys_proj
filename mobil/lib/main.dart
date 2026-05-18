import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'screens/arac_list_screen.dart';

void main() {
  runApp(const OtogaleriApp());
}

class OtogaleriApp extends StatelessWidget {
  const OtogaleriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otogaleri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AracListScreen(),
      builder: (context, child) {
        if (!AppConfig.useMock) return child!;
        return Banner(
          message: 'MOCK',
          location: BannerLocation.topEnd,
          color: Colors.orange,
          child: child,
        );
      },
    );
  }
}
