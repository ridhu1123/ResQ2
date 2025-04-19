import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/admin_home_controller.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/theme/theme.dart';



class FirstAidOrders extends StatelessWidget {
  // final FirstAidController controller = Get.put(FirstAidController());

   const FirstAidOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),
      appBar: AppBar(
        title: Text(
          "First Aids",
          style: AppTextStyles.headlineLargeBlack,
        ),
      ),
      body: 
        Consumer<AdminHomeController>(
          builder: (context,controller,_) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemCount: controller.fistAidsList.length,
              itemBuilder: (context, index) {
                final item = controller.fistAidsList[index];
                // final isSelected =
                //     controller.selectedItems.contains(item['id'].toString());
            
                return GestureDetector(
                  onTap: () {
                    // controller.toggleSelection(['id'].toString());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color:
                          //  isSelected ? Colors.green :
                            Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                          item['image_url'] ,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // print("Error loading image: ${item['image_url']}");
                              return Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      
                      icon: Icon(Icons.remove),
                      onPressed: () {
                      //  controller.addFirstAid(controller.firstAidImage[index], '20');
                      },
                    ),
                    Text(
                      '${item['count']??''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                       padding: EdgeInsets.zero,
                      icon: Icon(Icons.add),
                      onPressed: () {
                       
                      },
                    ),
                  ],
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
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("Floating action button pressed, saving selection...");
          // controller.saveSelection();
        },
        child: Tooltip(
          message: 'Add First Aids',
          child: Icon(Icons.add)),
      ),
    );
  }
}
