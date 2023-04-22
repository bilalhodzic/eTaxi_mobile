import 'package:etaxi_mobile/providers/auth_provider.dart';
import 'package:etaxi_mobile/screens/login.dart';
import 'package:etaxi_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.instance),
      ],
      child: MaterialApp(
        title: 'eTaxi',
        theme:
            ThemeData(primarySwatch: colorSwatch, primaryColor: primaryColor),
        home: LoginScreen(),
      ),
    );
  }
}
