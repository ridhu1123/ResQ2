import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/user_login.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';

class UserRegister extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthController authController = Get.find();
  UserRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff0C3B2E),
        title: Center(
          child: Text('Sign Up', style: AppTextStyles.bodyLargeWhite),
        ),
      ),
      body: Consumer<UserLoginController>(
        builder: (context,controller,_) {
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.isLoading?
               Center(
                child: CircularProgressIndicator(),
               )
              : Container(
                color: const Color(0xffF9FBFA),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Register with ResQ',
                            style: AppTextStyles.headlineLargeBlack,
                          ),
                           Tooltip(
                            message: 'Switch user SignUp',
                             child: SizedBox(
                              
                                             child: AnimatedToggleSwitch<bool>.dual(
                                               current: controller.positive,
                                               first: false,
                                               second: true,
                                              //  height: ,
                                               spacing: 0.0,
                                               // textBuilder: (value) {
                                               //   return Text(value?'Voulenteer':'User');
                                               // },
                                               
                                               iconBuilder: (value) {
                                                 return Icon(value? Icons.support_agent:Icons.person,color: Color(0xffFFBA00),size: 20,);
                                               },
                                               styleBuilder: (value) {
                                                 return ToggleStyle(

                                                  
                                                   indicatorColor: const Color(0xff0C3B2E),


                                                   // backgroundColor: const Color(0xff0C3B2E)
                                                 );
                                               },
                                               style: const ToggleStyle(
                                                  
                                                 borderColor: Colors.transparent,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Color.fromARGB(66, 95, 95, 95),
                                                     spreadRadius: 1,
                                                     blurRadius: 2,
                                                     offset: Offset(0, 1.5),
                                                   ),
                                                 ],
                                               ),
                             
                                               borderWidth: 5.0,
                                               
                                               // height: 55,
                                               onChanged: (b) {
                                        controller.userChange(b);
                                               }),
                                              
                                             ),
                           ),
              

//  AdvancedSwitch(
//                         activeChild: Text('Vouelnteer'),
//                             width: 100,
//                             inactiveChild: Text('User'),

//                   controller: controller.controller1,
//                   thumb: ValueListenableBuilder<bool>(

//                     valueListenable: controller.controller1,

//                     builder: (_, value, __) {
//                       return Container(
//                         // height: 10,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white
//                         )
//                          );
//                     },
//                   ),
                // ),
                        ],
                      ),
                      SizedBox(height: res.width(0.05)),
                      Text('Email', style: AppTextStyles.bodyLargeBlack),
                      CustomTextField(
                        hintText: 'email',
                        controller: controller.emailController,
                      ),
                      SizedBox(height: res.width(0.05)),
                      Text('Password', style: AppTextStyles.bodyLargeBlack),
                      CustomTextField(
                        hintText: 'password',
                        controller: controller.passWordController,
                      ),
                      SizedBox(height: res.width(0.05)),
                      Text(
                        'Confirm Password',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                      const CustomTextField(hintText: 'password'),
                      SizedBox(height: res.width(0.05)),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          
                          decoration: InputDecoration(
                            hintText: 'Select District',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          items: district.map((String? value) {
                          return  DropdownMenuItem(
                              value:value ,
                              child:Text(value??'') ,);
                          },).toList(),
                          onChanged: (value) {
                            if (value==null) {
                              return;
                            }
                            controller.districtController.text=value;
                          },
                        ),
                      ),
                      SizedBox(height: res.width(0.05)),
                      // return
                      //  authController.isLoading.value
                      //     ? const Align(
                      //         alignment: Alignment.center,
                      //       child: CircularProgressIndicator())
                      //     :
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.userSignUp();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFBA00),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Sign Up"),
                        ),
                      ),
                      SizedBox(height: res.width(0.05)),
                      Row(
                        children: [
                          SizedBox(width: res.width(0.18)),
                          Text(
                            "Already have account? ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: res.width(0.03)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserLogin(),
                                ),
                              );
                            },
                            child: Text(
                              'SignIn',
                              style: AppTextStyles.bodyLargeBlack,
                            ),
                          ),
                        ],
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
                      //         'Sign Up',
                      //         style: AppTextStyles.bodyLargeBlack,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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

List<String> district = [
  'Thiruvananthapuram', 'Kollam', 'Pathanamthitta', 'Alappuzha', 'Kottayam', 'Idukki', 'Ernakulam', 'Thrissur', 'Palakkad', 'Malappuram', 'Kozhikode', 'Wayanad', 'Kannur', 'Kasaragod',
];
