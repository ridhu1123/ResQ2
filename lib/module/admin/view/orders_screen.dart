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
        title: Text("Orders", style: AppTextStyles.headlineLargeBlack),
      ),
      body: Consumer<AdminHomeController>(
        builder: (context, controller, _) {
          return ListView.builder(
            itemCount: controller.fistAidsList.length,
            itemBuilder: (context, index) {
              final item = controller.fistAidsList[index];
              return controller.buyLoad?
                SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):
                item['ordered_count']>0? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SizedBox(
                    // height: 80,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                item['image_url'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // print("Error loading image: ${item['image_url']}");
                                  return Icon(Icons.error, color: Colors.red);
                                },
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                    'Name     : ${item['name']??''}',
                    style: TextStyle(fontSize: 13),
                  ),
                             Text(
                    'Total       : ${item['count']??''}',
                    style: TextStyle(fontSize: 13),
                  ),
                    Text(
                    'Ordered  : ${item['ordered_count']??''}',
                    style: TextStyle(fontSize: 13),
                  ),
                          ],
                        ),
                        Spacer(),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: ElevatedButton(
                                                       //  padding: EdgeInsets.zero,
                                                       
                                                       style: ElevatedButton.styleFrom(backgroundColor:Color(0xff0C3B2E),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))  ),
                                                       child:Text('Accepect',style: TextStyle(color: Colors.white),) ,
                                                       onPressed: () {
                                                        final  count=item['count']-item['ordered_count'] as int;

                                                       controller.removeFirsAidCount(count:count ,id:item['id'] );
                                                       },
                                                     ),
                                 ),
                      ],
                    ),
                  ),
                ),
              ):SizedBox();
            },
          );
          //  GridView.builder(
          //   padding: EdgeInsets.all(10),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: 0.9,
          //   ),
          //   itemCount: controller.fistAidsList.length,
          //   itemBuilder: (context, index) {
          //     final item = controller.fistAidsList[index];
          //     // final isSelected =
          //     //     controller.selectedItems.contains(item['id'].toString());

          //     return
          //     item['ordered_count']>0?
          //     GestureDetector(
          //       onTap: () {
          //         // controller.toggleSelection(['id'].toString());
          //       },
          //       child: Card(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(
          //               color:
          //               //  isSelected ? Colors.green :
          //                 Colors.grey),
          //         ),
          //         child: Column(
          //           children: [
          //             Expanded(
          //               child: Image.asset(
          //               item['image_url'] ,
          //                 fit: BoxFit.cover,
          //                 errorBuilder: (context, error, stackTrace) {
          //                   // print("Error loading image: ${item['image_url']}");
          //                   return Icon(Icons.error, color: Colors.red);
          //                 },
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         IconButton(
          //           padding: EdgeInsets.zero,

          //           icon: Icon(Icons.remove),
          //           onPressed: () {
          //           //  controller.addFirstAid(controller.firstAidImage[index], '20');
          //           },
          //         ),
          //         Text(
          //           '${item['count']??''}',
          //           style: TextStyle(fontSize: 18),
          //         ),
                  // IconButton(
                  //    padding: EdgeInsets.zero,
                  //   icon: Icon(Icons.add),
                  //   onPressed: () {

                  //   },
                  // ),
          //       ],
          //     ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ):SizedBox();
          //   },
          // );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("Floating action button pressed, saving selection...");
          // controller.saveSelection();
        },
        child: Tooltip(message: 'Add First Aids', child: Icon(Icons.add)),
      ),
    );
  }
}
