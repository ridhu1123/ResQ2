import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/constants/app_constants.dart';
import 'package:resq_application/module/admin/controller/admin_login_controller.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/user_login.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginController()),
        ChangeNotifierProvider(create: (_) => UserHomeController()),
        ChangeNotifierProvider(create: (_) => AdminLoginController()),
        // Add other providers here   
      ],
      child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: AppConstants().rootScaffoldMessengerKey,
debugShowCheckedModeBanner: false,     
      home: UserLogin()
    );
  }
}

