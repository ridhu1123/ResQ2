import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_application/module/admin/model/userlist_model.dart';
import 'package:resq_application/module/admin/service/service_notifcation.dart';
import 'package:resq_application/module/user/view/user_register.dart';






class SoundAlertScreen extends StatefulWidget {
  const SoundAlertScreen({super.key});

  @override
  State<SoundAlertScreen> createState() => _SoundAlertScreenState();
}

class _SoundAlertScreenState extends State<SoundAlertScreen> {
  late Future<List<UserModel>> _usersFuture;
  late List<UserModel> _allUsers; // Store all users
  final Set<String> _selectedUserEmails =
      {}; // We'll use email as unique identifier
  String? _selectedDistrict; // Store selected district
// List of districts
  bool _selectAll = false; // To track select all status
bool _isSending = false;


void _sendAlertNotification() async {
  setState(() {
    _isSending = true;
  });

  final selectedUsers = _selectedUsers;
  final fcmTokens = selectedUsers
      .map((user) => user.fcmToken)
      .where((token) => token != null && token.isNotEmpty)
      .cast<String>()
      .toList();

  if (fcmTokens.isEmpty) {
log('fcm is empty');
  } else {
    final notificationService = SendNotificationService();
    await notificationService.sendNotificationToUsers(
      fcmTokens: fcmTokens,
      title: '🚨 Emergency Alert',
      body: 'Help on the way please stay safe!',
      type: 'alert'
    );
  }

  setState(() {
    _isSending = false;
  });
}


  @override
  void initState() {
    super.initState();
    _selectedDistrict = null;
    _usersFuture = getUsers();
  }

  Future<List<UserModel>> getUsers({String? district}) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection('users')
          .where('type', isEqualTo: 0);

      if (district != null && district.trim().isNotEmpty) {
        query = query.where('district', isEqualTo: district.trim());
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
 
      throw Exception("Failed to fetch users");
    }
  }

  void _toggleSelection(UserModel user) {
    setState(() {
      if (_selectedUserEmails.contains(user.email)) {
        _selectedUserEmails.remove(user.email);
      } else {
        _selectedUserEmails.add(user.email);
      }
    });
  }

  void _selectAllUsers() {
    setState(() {
      if (_selectAll) {
        _selectedUserEmails.clear(); // Deselect all users
      } else {
        _selectedUserEmails.addAll(
          _allUsers.map((user) => user.email),
        ); // Select all users
      }
      _selectAll = !_selectAll; // Toggle select all status
    });
  }

  List<UserModel> get _selectedUsers =>
      _allUsers
          .where((user) => _selectedUserEmails.contains(user.email))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Alert Users'),
        actions: [
          IconButton(
            icon: Icon(
              _selectAll ? Icons.check_box : Icons.check_box_outline_blank,
              color: _selectAll ? Colors.blueAccent : Colors.black,
            ),
            onPressed: _selectAllUsers, // Trigger select/deselect all
          ),
        ],
      ),
      body: Column(
        children: [
          // District Dropdown
          _selectedDistrict == null
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: _selectedDistrict,
                    decoration: const InputDecoration(
                      hintText: 'Select District',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    items:
                        district.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDistrict = value;
                        _usersFuture = getUsers(
                          district: value,
                        ); // Update the list based on selected district
                      });
                    },
                  ),
                ),
              )
              : ListTile(
                title: Text(_selectedDistrict ?? 'Select District'),
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _selectedDistrict = null; // Clear selection
                      _usersFuture = getUsers(); // Reset to all users
                    });
                  },
                ),
              ),

          // FutureBuilder for user list
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                _allUsers = snapshot.data ?? [];

                if (_allUsers.isEmpty) {
                  return const Center(child: Text("No users found."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 70,
                  ), // So button won't overlap
                  itemCount: _allUsers.length,
                  itemBuilder: (context, index) {
                    final user = _allUsers[index];
                    final isSelected = _selectedUserEmails.contains(user.email);
                    return ListTile(
                      leading: Checkbox(
                        value: isSelected,
                        onChanged: (_) => _toggleSelection(user),
                      ),
                      title: Text(
                        user.name?.isNotEmpty == true
                            ? user.name!
                            : "Unnamed User",
                      ),
                      subtitle: Text(user.email),
                      trailing: Text(user.district ?? "No District"),
                      onTap:
                          () => _toggleSelection(
                            user,
                          ), // Tap tile to toggle selection
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      bottomSheet:
          _selectedUserEmails.isNotEmpty
              ? _isSending ? CircularProgressIndicator(): CupertinoButton(
                onPressed: () async {
                  
                  _sendAlertNotification();

                    // CustomAlertPopUp.showPersistentDialog(message: 'Thuder s');
                },
                minSize: 0,
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sent Alert to ${_selectedUserEmails.length} users',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.campaign, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : null,
    );
  }
}





// class SoundAlertScreen extends StatefulWidget {
//   const SoundAlertScreen({super.key});

//   @override
//   State<SoundAlertScreen> createState() => _SoundAlertScreenState();
// }

// class _SoundAlertScreenState extends State<SoundAlertScreen> {
//   late Future<List<UserModel>> _usersFuture;
//   final Set<String> _selectedUserEmails = {}; // We'll use email as unique identifier
//   List<UserModel> _allUsers = [];

//   @override
//   void initState() {
//     super.initState();
//     _usersFuture = getUsers();
//   }

//   Future<List<UserModel>> getUsers({String? district}) async {
//     try {
//       Query query = FirebaseFirestore.instance
//           .collection('users')
//           .where('type', isEqualTo: 0);

//       if (district != null && district.trim().isNotEmpty) {
//         query = query.where('district', isEqualTo: district.trim());
//       }

//       final querySnapshot = await query.get();

//       return querySnapshot.docs
//           .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//     } catch (e) {
//       print("❌ Error fetching users: $e");
//       throw Exception("Failed to fetch users");
//     }
//   }

//   void _toggleSelection(UserModel user) {
//     setState(() {
//       if (_selectedUserEmails.contains(user.email)) {
//         _selectedUserEmails.remove(user.email);
//       } else {
//         _selectedUserEmails.add(user.email);
//       }
//     });
//   }

//   List<UserModel> get _selectedUsers => _allUsers
//       .where((user) => _selectedUserEmails.contains(user.email))
//       .toList();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Alert Users')),
//       body: FutureBuilder<List<UserModel>>(
//         future: _usersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           _allUsers = snapshot.data ?? [];

//           if (_allUsers.isEmpty) {
//             return const Center(child: Text("No users found."));
//           }

//           return Stack(
//             children: [
//               ListView.builder(
//                 padding: const EdgeInsets.only(bottom: 70), // So button won't overlap
//                 itemCount: _allUsers.length,
//                 itemBuilder: (context, index) {
//                   final user = _allUsers[index];
//                   final isSelected = _selectedUserEmails.contains(user.email);
//                   return ListTile(
//                     leading: Checkbox(
//                       value: isSelected,
//                       onChanged: (_) => _toggleSelection(user),
//                     ),
//                     title: Text(user.name?.isNotEmpty == true ? user.name! : "Unnamed User"),
//                     subtitle: Text(user.email),
//                     trailing: Text(user.district ?? "No District"),
//                     onTap: () => _toggleSelection(user), // tap whole tile to toggle
//                   );
//                 },
//               ),
//               if (_selectedUserEmails.isNotEmpty)
//                 Positioned(
//                   bottom: 10,
//                   left: 16,
//                   right: 16,
//                   child: ElevatedButton(
//                     onPressed: () {
                      // final selected = _selectedUsers;
                      // print("📦 Selected Users:");
                      // for (var u in selected) {
                      //   print("${u.name ?? "Unnamed"} (${u.email})");
                      // }

//                       // Do something with `selected`
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('${selected.length} users selected!')),
//                       );
//                     },
//                     child: Text("Send Alert to ${_selectedUserEmails.length} user(s)"),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
