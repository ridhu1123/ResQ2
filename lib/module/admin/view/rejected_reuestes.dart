import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/rejected_resq_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RejectedRequest extends StatefulWidget {

  const RejectedRequest({super.key});

  @override
  State<RejectedRequest> createState() => _RejectedRequestState();
}

class _RejectedRequestState extends State<RejectedRequest> {
  @override
  void initState() {
    context.read<RejectedReqController>().fetchAllCompletedResq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),
     
      appBar: AppBar(title: Text("Rejected ResQ"),
      actions: [
         IconButton(onPressed: () {
          // controller.fetchAllUsers();
        }, icon:
         LottieBuilder.asset('assets/Animation - 1743885710865.json',repeat: context.read<RejectedReqController>().isLoading,)
        )
      
     
      ],
      ),
      body:Consumer<RejectedReqController>(builder: (context, controller, _) {
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
                                Text("Location : ${user['location'] ??''}",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),
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
                           Container(
                            width: 80,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // color: Colors.green,
                             color: user['status']==null?Colors.transparent : _getStatusColor(user['status']),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                user['status']??'',
                                style: TextStyle(color: Colors.white),
                                
                              ),
                            ),
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