import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  // final AdminHomeController controller = Get.put(AdminHomeController());

  // final AdminAuthController authcontroller = Get.put(AdminAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // authcontroller.signOut();
        },
        child: Icon(Icons.logout_outlined),
      ),
      appBar: AppBar(title: Text("Admin Dashboard"),
      actions: [
        // Obx(() {
          //  return 
            IconButton(onPressed: () {
          // controller.fetchAllUsers();
        }, icon:
         LottieBuilder.asset('assets/Animation - 1743885710865.json',)
        )
        // },)
     
      ],
      ),
      body:
        // if (controller.isLoading.value) {
        //   return Center(child: CircularProgressIndicator());
        // }

        // if (controller.allUsers.isEmpty) {
        //   return Center(child: Text("No user data found."));
        // }

         GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            // final item = controller.items[index];
            // final isSelected =
            //     controller.selectedItems.contains(item['id'].toString());

            return GestureDetector(
              onTap: () {
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
                      child: Image.network(
                        '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // print("Error loading image: ${item['image_url']}");
                          return Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '',
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Safe':
        return Colors.green;
      case 'Mild':
        return Colors.orange;
      case 'Severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
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