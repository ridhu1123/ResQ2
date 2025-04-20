import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/user/view/user_login.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';


class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
 
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserLoginController>().userSignOut().then((value) {
            if (value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));
              context.read<UserHomeController>().bottomIndex=0;
            }
          },);
          // authController.signOut().whenComplete(
          //   () {
          //      Get.toNamed('/signin');
          //   },
          // );
         
        },
        backgroundColor: const Color(0xff0C3B2E),
        child: const Icon(
          Icons.logout_outlined,
          color: Color(0xffFFBA00),
        ),
      ),
      backgroundColor: const Color(0xffF9FBFA),
      body: Consumer<UserHomeController>(
        builder: (context,controller,_) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'A bit about yourself',
                    style: AppTextStyles.headlineMediumBlack,
                  ),
                  SizedBox(
                    height: res.width(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                         CustomTextField(hintText: 'What should we call you',controller: controller.nameController,),
                        SizedBox(
                          height: res.width(0.03),
                        ),
                        Text(
                          'Phone',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                         CustomTextField(hintText: '10 digit Phone number',controller: controller.phoneController,),
                        SizedBox(
                          height: res.width(0.03),
                        ),
                        Text(
                          'Blood Group',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                         CustomTextField(hintText: 'B+',controller: controller.bloodGroupController,),
                        SizedBox(
                          height: res.width(0.03),
                        ),
                        Text(
                          'Gender',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                         CustomTextField(hintText: 'male',controller: controller.genderController,),
                        SizedBox(
                          height: res.width(0.03),
                        ),
                        Text(
                          'Age',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                         CustomTextField(hintText: 'Age in years',controller: controller.ageController,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: res.width(0.1),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.updateUserDetails();
                      // final user = UserModel(
                      //   id: DateTime.now().millisecondsSinceEpoch.toString(),
                      //   name: nameController.text,
                      //   phone: phoneController.text,
                      //   bloodGroup: bloodGroupController.text,
                      //   gender: genderController.text,
                      //   age: int.tryParse(ageController.text) ?? 0,
                      // );
                      // await SupabaseService.saveUserDetails(user);
                    },
                    child: Container(
                      width: res.width(0.4),
                      height: res.width(0.12),
                      decoration: BoxDecoration(
                          color: const Color(0xffFFBA00),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
