import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';


class UserHome extends StatelessWidget {
 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserHomeController>(
        builder: (context,controller,_) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Welcome, ${'User'}!",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text('No emergency alerts'),
                  const Text("Let's get you prepared just in case"),
                  SizedBox(
                    height: res.width(0.05),
                  ),
              
            // if (homecontroller.isLoadingLocation.value) {
            //   return SizedBox(
            //     height: res.width(0.35),
            //     width: res.width(0.9),
            //     child: const Center(child: CircularProgressIndicator()),
            //   );
            // }
          
             Container(
              height: res.width(0.35),
              width: res.width(0.9),
              decoration: BoxDecoration(
          color: const Color(0xff0C3B2E),
          borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('10% chance of', style: AppTextStyles.bodyLargeWhite),
              Text('ThunderStorm', style: AppTextStyles.bodyLargeWhite),
              SizedBox(height: res.width(0.05)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.location_city_outlined, color: Colors.white, size: 35),
                    SizedBox(width: res.width(0.02)),
                    Text(
                      // homecontroller.streetName.value.isNotEmpty
                      //     ? homecontroller.streetName.value
                      //     : 
                          "Fetching location...",
                      style: AppTextStyles.bodyLargeWhite,
                    ),
                  ],
                ),
              ),
            ],
          ),
              ),
            ),
          
          
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '    Are you facing an Emergency?',
                              style: AppTextStyles.bodyLargeBlack,
                            ),
                            SizedBox(
                              width: res.width(0.05),
                            ),
                            const Icon(Icons.arrow_forward)
                          ],
                        ),
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
                            controller.note=value;
                          },
                        ),
                        SizedBox(
                          height: res.width(0.04),
                        ),
                        CustomTextField(
                          hintText: 'Name',
                          controller: controller.nameController,
                          onChanged: (p0) {
                            controller.name=p0;
                          },
                        ),
                        SizedBox(
                          height: res.width(0.04),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPickerScreen()));
                          },
                          child: CustomTextField(
                            hintText: 'Location',
                            controller: controller.locationController,
                            prefixIcon: Icons.location_on,
                            onChanged: (p0) {
                              controller.location=p0;
                            },
                          ),
                        ),
                        SizedBox(
                          height: res.width(0.04),
                        ),
                        controller.isLoading?
                         SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )

                        :InkWell(
                          onTap: () {
                          controller.saveResqDetails();
                          },
                          child: Container(
                            height: res.width(0.1),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFBA00),
                                borderRadius: BorderRadius.circular(12)),
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
