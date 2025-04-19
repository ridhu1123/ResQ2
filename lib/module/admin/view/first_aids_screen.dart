import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/theme/theme.dart';



class FirstAids extends StatelessWidget {
  // final FirstAidController controller = Get.put(FirstAidController());

   const FirstAids({super.key});

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
        Consumer<UserHomeController>(
          builder: (context,controller,_) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                // final item = controller.items[index];
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
                          controller.firstAidImage[index] ,
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
