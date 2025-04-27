import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_textfeild.dart';

class EmergencyDialog extends StatelessWidget {

  const EmergencyDialog({super.key,});

  @override
  Widget build(BuildContext context) {
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
  }
}
