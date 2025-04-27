import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/accepted_resq_controller.dart';
import 'package:resq_application/module/admin/controller/admin_login_controller.dart';
import 'package:resq_application/module/user/controller/user_login_controller.dart';
import 'package:resq_application/module/voulnteer/view/voulnteer_login.dart';
import 'package:url_launcher/url_launcher.dart';

class VoulnteerHome extends StatefulWidget {

  const VoulnteerHome({super.key});

  @override
  State<VoulnteerHome> createState() => _VoulnteerHomeState();
}

class _VoulnteerHomeState extends State<VoulnteerHome> {
  @override
  void initState() {
    context.read<AcceptedResqController>().fetchAllAccpectedResq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         await context.read<UserLoginController>().userSignOut().whenComplete(
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => VoulnteerLogin()),
                  );
                },
                
              );
      },
      child: Icon(Icons.logout_outlined),
      ),
      backgroundColor: Color(0xff0C3B2E),
     
      appBar: AppBar(title: Text("Volunteer Dashboard"),
      actions: [
         IconButton(onPressed: () {
          context.read<AcceptedResqController>().fetchAllAccpectedResq();
        }, icon:
         LottieBuilder.asset('assets/Animation - 1743885710865.json',repeat: context.watch<AcceptedResqController>().isLoading,)
        )
      
     
      ],
      ),
      body:Consumer<AcceptedResqController>(builder: (context, controller, _) {
          if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.allData.isEmpty) {
          return Center(child: Text("No user data found."));
        }

        return ListView.builder(
          itemCount: controller.allData.length,
          itemBuilder: (context, index) {
            final user = controller.allData[index];
            final delivaryStatus=user['deliver_status'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                
                child: SizedBox(
                  // height: 80,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(user['name']??'',style: TextStyle(fontWeight:FontWeight.w800),),
                                            ),
                        InkWell(
                            onTap: () {
                              // log('''latlong is {user['latlong']}''');
                              openGoogleMaps(user['latlong']);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.location_on,),
                                SizedBox(
                                  width: 200,
                                  child: Text("Location : ${user['location'] ??''}",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),
                              ],
                            ),
                          ),
                             Padding(
                               padding: const EdgeInsets.only(left: 5.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Note : ',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                                )
                                  ),
                                    TextSpan(
                                      text: user['note']??'',
                                style: TextStyle(
                                  color: Colors.black
                                )
                                  ),
                                ],
                              
                              ),
                            ),
                          ),
                        Padding(
                               padding: const EdgeInsets.only(left: 5.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Status : ',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                                )
                                  ),
                                    TextSpan(
                                      text: user['status']??'',
                                style: TextStyle(
                                  color: user['status']==null?Colors.transparent : _getStatusColor(user['status']),
                                )
                                  ),
                                ],
                              
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           ChoiceChip(label: Text('Help deliverd'), selected: delivaryStatus==3?true:false,
                           color:WidgetStatePropertyAll(delivaryStatus==3? Colors.green:Colors.grey),
                           onSelected: (value) {
                             controller.statusUpdate(status:3 ,id: user['id']).whenComplete(() {
                               controller.fetchAllAccpectedResq();
                             },);
                           },
                           ),
                                                  ChoiceChip(label: Text('On the way'), selected: delivaryStatus==2?true:false,autofocus: true,
                                                  color:WidgetStatePropertyAll(delivaryStatus==2? Colors.green:Colors.grey),
                                                  onSelected: (value) {
                                                    controller.statusUpdate(status:2 ,id: user['id']).whenComplete(() {
                                                      controller.fetchAllAccpectedResq();
                                                    },);
                                                  },
                                                  ),
                         
                        ],
                      ),
                   ),
                    ],
                  )
                ),
              ),
            );
          },
        );
      },)
     
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