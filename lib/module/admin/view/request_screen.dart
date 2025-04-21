import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/admin_home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AdminHomeController>().fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),

      appBar: AppBar(
        title: Text("ResQ Requests"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AdminHomeController>().fetchAllUsers();
            },
            icon: LottieBuilder.asset(
              'assets/Animation - 1743885710865.json',
              repeat: context.read<AdminHomeController>().isLoading,
            ),
          ),
        ],
      ),
      body: Consumer<AdminHomeController>(
        builder: (context, controller, _) {
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
                    // height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  // child: Text(user['name'].toString(),style: TextStyle(fontWeight:FontWeight.w800),),
                                  child: Text(
                                    user['name']?.toString() ?? 'No Name',
                                    style: TextStyle(fontWeight: FontWeight.w800),
                                    maxLines: 1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (user['latlong'] != null &&
                                        user['latlong'].toString().contains(
                                          ',',
                                        )) {
                                      openGoogleMaps(user['latlong']);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Location not available'),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on),
                                      Expanded(
                                        child: Text(
                                          "Location : ${user['location'] ?? ''}",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Tooltip(
                            richMessage: TextSpan(
                              text: user['note']?.toString() ?? 'No Note',
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Note : ',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: user['note']?.toString() ?? '',
                                    style: TextStyle(
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                                  
                                  // Tooltip(
                                  //   message: user['note'],
                                  //   child: RichText(
                                  //     text: TextSpan(
                                  //       children: [
                                  //         TextSpan(
                                  //           text: 'Note : ',
                                  //           style: TextStyle(
                                  //             color: Colors.grey[700],
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         ),
                                  //         TextSpan(
                                  //           text:
                                  //               user['note']?.toString() ??
                                  //               'No note',
                                  //           style: TextStyle(color: Colors.black),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
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
                                          text:
                                              user['status']?.toString() ??
                                              'Unknown',
                                          style: TextStyle(
                                            color: _getStatusColor(
                                              user['status']?.toString(),
                                            ),
                                          ),
                                        ),
                                        // TextSpan(
                                        //   text: user['status'],
                                        //   style: TextStyle(
                                        //     color: _getStatusColor(
                                        //       user['status'],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller
                                          .accpectResQ(selectedData: user)
                                          .whenComplete(() {
                                            controller.fetchAllUsers();
                                          });
                                    },
                                    child: Container(
                                      width: 80,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        // color: _getStatusColor(),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '''Accept''',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller
                                          .rejectedResQ(selectedData: user)
                                          .whenComplete(() {
                                            controller.fetchAllUsers();
                                          });
                                    },
                                    child: Container(
                                      width: 80,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        // color: _getStatusColor(),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '''Reject''',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  ListTile(

                    //   title: Padding(
                    //     padding: const EdgeInsets.only(left: 5.0),
                    //     child: Text('''No Name'''),
                    //   ),
                    //   subtitle: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    // InkWell(
                    //   onTap: () {
                    //     log('''latlong is {user['latlong']}''');
                    //     // openGoogleMaps(user['latlong']);
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.location_on,),
                    //       Text("Location: "),
                    //     ],
                    //   ),
                    // ),
                    //       Padding(
                    //            padding: const EdgeInsets.only(left: 5.0),
                    //         child: Text("Note: No Note"),
                    //       ),
                    //     ],
                    //   ),

                    // trailing: Column(

                    //   children: [
                    //      Expanded(
                    //        child: Container(
                    //         padding: EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //           color: Colors.black,
                    //           // color: _getStatusColor(),
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         child: Text(
                    //           ''' Unknown''',
                    //           style: TextStyle(color: Colors.white),

                    //         ),
                    //                              ),
                    //      ),
                    //      SizedBox(height: 5,),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //           color: Colors.black,
                    //           // color: _getStatusColor(),
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         child: Text(
                    //           ''' Unknown''',
                    //           style: TextStyle(color: Colors.white),

                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ),
                  ),
                ),
              );
            },
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
      final Uri googleMapUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );

      if (await canLaunchUrl(googleMapUrl)) {
        await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}
