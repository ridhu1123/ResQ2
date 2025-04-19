import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/constants/app_constants.dart';
import 'package:resq_application/module/admin/controller/admin_home_controller.dart';
import 'package:resq_application/module/admin/controller/admin_login_controller.dart';
import 'package:resq_application/module/admin/view/admin_home.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/bottom_navigation.dart';
import 'package:resq_application/module/user/view/user_home.dart';
import 'package:resq_application/module/user/view/user_login.dart';
import 'package:resq_application/module/voulnteer/view/voulnteer_login.dart';
import 'package:resq_application/theme/theme.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginController()),
        ChangeNotifierProvider(create: (_) => UserHomeController()),
        ChangeNotifierProvider(create: (_) => AdminLoginController()),
        ChangeNotifierProvider(create: (_) => AdminHomeController()),
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
      home: SplashScreen()
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future userCheck()async{
    final userData=await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser?.uid).get();
    final data=userData.data();
    final userType=data?['type'];
     switch (userType) {
       case 0:
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavPage()));
         break;
        case 1:
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));
       case 2:
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VoulnteerLogin()));

       default:
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));

     }
  }
    
  @override
  void initState() {
    super.initState();
    userCheck();
  }
  @override
  Widget build(BuildContext context) {
    final res= ResponsiveHelper(context);
    return Scaffold(
      body: Container(
        height: res.screenHeight,
        width: res.screenWidth,
        color: Color(0xff0C3B2E),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

