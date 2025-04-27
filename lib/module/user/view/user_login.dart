import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/view/admin_login.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/bottom_navigation.dart';
import 'package:resq_application/module/user/view/user_register.dart';
import 'package:resq_application/module/voulnteer/view/voulnteer_login.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';


class UserLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthController authController = Get.find();
  UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
     context.read<UserHomeController>().fetchCurrentLocation();
    final res = ResponsiveHelper(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
            onPressed: () {
              // Get.toNamed('/adminLogin');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
            },
            backgroundColor: const Color(0xff0C3B2E),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Color(0xffFFBA00),
            ),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {
              // Get.toNamed('/adminLogin');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VoulnteerLogin()));
            },
            backgroundColor: const Color(0xff0C3B2E),
            child: const Icon(
              Icons.support_agent,
              color: Color(0xffFFBA00),
            ),
          ),
        ],
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
                          'Get Started with                     ResQ',
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
                    
                          
                            controller.isLoading  ? SizedBox(
                              width: res.screenWidth,
                              child: const Center(child: CircularProgressIndicator()))
                              : 
                              SizedBox(
                                width: res.screenWidth,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                    showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) {
    return Consumer<UserHomeController>(
      builder: (context,controller,_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Are you facing an Emergency?',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                    ),
                    onChanged: (value) {
                      controller.note = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Name',
                    controller: controller.nameController,
                    onChanged: (p0) {
                      controller.name = p0;
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPickerScreen()));
                    },
                    child: CustomTextField(
                      hintText: 'Location',
                      controller: controller.locationController,
                      prefixIcon: Icons.location_on,
                      onChanged: (p0) {
                        controller.location = p0;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  controller.isLoading
                      ? SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.saveResqDetails();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFBA00),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Ask for help!',
                                style: AppTextStyles.headlineMediumBlack,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }
    );
  },
);

                                      // authController.signIn(
                                      //   emailController.text,
                                      //   passwordController.text,
                                      // );
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
                              ),
                               SizedBox(
                                width: res.screenWidth,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.userSignIn(userType: 0).then((value) {
                                        if (value) {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavPage()));
                                        }
                                      },);
                                      // authController.signIn(
                                      //   emailController.text,
                                      //   passwordController.text,
                                      // );
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
                                    child: const Text("Ask for help"),
                                  ),
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
                        SizedBox(
                          height: res.width(0.05),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: res.width(0.18),
                            ),
                            const Text(
                              "Don't have an account?",
                            ),
                            SizedBox(
                              width: res.width(0.03),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRegister()));
                              },
                              child: Text(
                                'SignUp',
                                style: AppTextStyles.bodyLargeBlack,
                              ),
                            )
                          ],
                        )
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
