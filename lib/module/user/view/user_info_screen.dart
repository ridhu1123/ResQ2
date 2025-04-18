import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Center(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: Text(
                        'Name',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                    const CustomTextField(hintText: 'What should we call you'),
                    SizedBox(
                      height: res.width(0.03),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: Text(
                        'Phone',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                    const CustomTextField(hintText: '10 digit Phone number'),
                    SizedBox(
                      height: res.width(0.03),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text(
                        'Blood Group',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                    const CustomTextField(hintText: 'B+'),
                    SizedBox(
                      height: res.width(0.03),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 290),
                      child: Text(
                        'Gender',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                    const CustomTextField(hintText: 'male'),
                    SizedBox(
                      height: res.width(0.03),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 310),
                      child: Text(
                        'Age',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                    const CustomTextField(hintText: 'Age in years'),
                  ],
                ),
              ),
              SizedBox(
                height: res.width(0.1),
              ),
              InkWell(
                onTap: () async {
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
      ),
    );
  }
}
