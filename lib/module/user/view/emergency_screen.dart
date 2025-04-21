import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:resq_application/widget/custom_snackbar.dart';

class EmergencyPage extends StatelessWidget {
  // final UserDetailsController controller = Get.find<UserDetailsController>();

  EmergencyPage({super.key}); // Function to show dialog
  void showSafetyDialog(
      BuildContext context, String disaster, String precautions) {
    CustomSnackBar.error(
    precautions,
      // content: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(precautions, textAlign: TextAlign.center),
      // ),
      // confirm: ElevatedButton(
      //   onPressed: () => Get.back(), // Close the dialog
      //   child: const Text("OK"),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      body: Center(
        child: Consumer<UserHomeController>(
          builder: (context,controller,_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Text(
                    "Don't panic! Follow these    instructions to stay safe",
                    style: AppTextStyles.headlineMediumBlack,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSafetyDialog(
                      context,
                      "Flood",
                      "1. Move to higher ground.\n2. Avoid walking in floodwaters.\n3. Turn off electricity and gas.",
                    );
                  },
                  child: Text(
                    "Flood Safety",
                    style: AppTextStyles.bodyLargeBlack,
                  ),
                ),
                SizedBox(
                  height: res.width(0.04),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSafetyDialog(
                      context,
                      "Wildfire",
                      "1. Evacuate if told to do so.\n2. Close all doors and windows.\n3. Wear protective clothing.",
                    );
                  },
                  child: Text(
                    "Wildfire Safety",
                    style: AppTextStyles.bodyLargeBlack,
                  ),
                ),
                SizedBox(
                  height: res.width(0.04),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSafetyDialog(
                      context,
                      "Cyclone",
                      "1. Secure loose objects.\n2. Stay indoors and avoid windows.\n3. Listen to weather updates.",
                    );
                  },
                  child: Text(
                    "Cyclone Safety",
                    style: AppTextStyles.bodyLargeBlack,
                  ),
                ),
                SizedBox(
                  height: res.width(0.04),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSafetyDialog(
                      context,
                      "Earthquake",
                      "1. Drop, cover, and hold on.\n2. Stay away from windows.\n3. If outside, move to an open area.",
                    );
                  },
                  child: Text(
                    "Earthquake Safety",
                    style: AppTextStyles.bodyLargeBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Text(
                        'Update your current status ->',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                      SizedBox(
                        width: res.width(0.06),
                      ),
                    
                         ElevatedButton(
                          onPressed: () {
                            controller.changeStatus();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.status == 'Safe'
                                ? Colors.green
                                : controller.status == 'Mild'
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                          child: Text(
                           controller.status,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 20),
              controller.isLoading?
              SizedBox(
               width: res.width(0.4),
                    height: res.width(0.12),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
              )
              :  InkWell(
                  onTap: () {
                    controller.saveResqDetails();

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
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
