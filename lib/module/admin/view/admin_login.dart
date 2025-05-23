import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/admin_login_controller.dart';
import 'package:resq_application/module/admin/view/admin_home.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/user_login.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';


class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.toNamed('/adminLogin');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLogin()));
        },
        backgroundColor: const Color(0xff0C3B2E),
        child: Tooltip(
          message: 'UserLogin',
          child: const Icon(
            Icons.subdirectory_arrow_left_rounded,
            color: Color(0xffFFBA00),
          ),
        ),
      ),
      backgroundColor: Color(0xff0C3B2E),
      body: Consumer<UserLoginController>(
        builder: (context,controller,_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: res.width(0.45),
                child: Image.asset('assets/logo.png'),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffF9FBFA),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your authorised credentials for Admin Login',
                          style: AppTextStyles.headlineLargeBlack,
                        ),
                        SizedBox(
                          height: res.width(0.05),
                        ),
                        Text(
                          'Email',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                        CustomTextField(
                          hintText: 'email',
                          controller: controller.emailController,
                        ),
                        SizedBox(
                          height: res.width(0.05),
                        ),
                        Text(
                          'Password',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                        CustomTextField(
                          hintText: 'password',
                          controller: controller.passWordController,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: res.width(0.05),
                        ),
                       
                          // return 
                          controller.isLoading
                              ? SizedBox(
                                width: res.screenWidth,
                                child: Center(child: const CircularProgressIndicator()))
                              : 
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 110, right: 110),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<UserLoginController>().userSignIn(userType: 1).then(
                                        (value) {
                                          if (value) {
                                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminHomePage()),(route) => false);
                                            
                                          }
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xffFFBA00),
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.only(
                                            left: 50, right: 50),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Text("Log In"),
                                  ),
                                ),
                       
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 100, right: 100),
                        //   child: Container(
                        //     width: res.width(0.4),
                        //     height: res.width(0.12),
                        //     decoration: BoxDecoration(
                        //         color: const Color(0xffFFBA00),
                        //         borderRadius: BorderRadius.circular(12)),
                        //     child: Center(
                        //       child: Text(
                        //         'Log In',
                        //         style: AppTextStyles.bodyLargeBlack,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
