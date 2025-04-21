import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/admin_home_controller.dart';
import 'package:resq_application/module/admin/controller/admin_login_controller.dart';
import 'package:resq_application/module/admin/view/admin_login.dart';
import 'package:resq_application/module/admin/view/accepected_request_screen.dart';
import 'package:resq_application/module/admin/view/first_aids_screen.dart';
import 'package:resq_application/module/admin/view/orders_screen.dart';
import 'package:resq_application/module/admin/view/rejected_reuestes.dart';
import 'package:resq_application/module/admin/view/request_screen.dart';
import 'package:resq_application/module/admin/view/sound_alert_screen.dart';
import 'package:resq_application/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomePage extends StatefulWidget {

  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    // controller. fetchAllUsers();
  }
  List<Widget> screens=[
  RequestScreen(),
  AccepectedRequests(),
  RejectedRequest(),
  FirstAids(),
  FirstAidOrders()
  ];
  // final AdminHomeController controller = Get.put(AdminHomeController());

  // final AdminAuthController authcontroller = Get.put(AdminAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()async {
      //        await context.read<AdminLoginController>().signOut().whenComplete(() {
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                      
      //               },);
      //     // authcontroller.signOut();
      //   },
      //   child: Icon(Icons.logout_outlined),
      // ),
      appBar: AppBar(title: Text("Admin Dashboard",),
      actions: [
        IconButton(onPressed: ()async {
          await context.read<AdminLoginController>().signOut().whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                
                },);
        }, icon: Icon(Icons.logout_outlined))
      ],
      
      ),
      body: 
        // if (controller.isLoading.value) {
        //   return Center(child: CircularProgressIndicator());
        // }

        // if (controller.allUsers.isEmpty) {
        //   return Center(child: Text("No user data found."));
        // }

         Consumer<AdminHomeController>(
           builder: (context,controller,_) {
             return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                
              ),
              itemCount: controller.adminHomeImage.length,
              itemBuilder: (context, index) {
                // final item = controller.items[index];
                // final isSelected =
                //     controller.selectedItems.contains(item['id'].toString());
             
                return
                 GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>screens[index]));
                    // print("Tapped on item: ${item['name']} (ID: ${item['id']})");
                    // controller.toggleSelection(item['id'].toString());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          // color: isSelected ? Colors.green : Colors.grey
                          ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(

borderRadius: BorderRadius.circular(10) ,
                            child: Image.asset(
                              controller.adminHomeImage[index],
                              fit: BoxFit.cover,
                              
                              errorBuilder: (context, error, stackTrace) {
                                // print("Error loading image: ${item['image_url']}");
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            controller.adminHomeImageText[index],
                            style: AppTextStyles.bodyLargeBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
                     );
           }
         ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundAlertScreen()));
      },
     child: Icon(Icons.campaign_outlined),
      ),
    );
  }

 

Future<void> openGoogleMaps(String latLong) async {
    final parts = latLong.split(',');

    if (parts.length == 2) {
      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());
  final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
  
  if (await canLaunchUrl(googleMapUrl)) {
    await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open the map.';
  }
}

}
}