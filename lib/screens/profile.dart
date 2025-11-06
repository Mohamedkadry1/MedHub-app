import 'dart:io';
import 'dart:io';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/auth/SignInScreen.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'package:grad_app/screens/patientScreen.dart';
import 'package:grad_app/screens/updateProfile.dart';
import 'package:grad_app/services/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

import '../const.dart';
import 'ClientsScreen.dart';
import 'ReservationScreen.dart';

class ProfileScreen extends StatefulWidget {
  String? userName;
  var imagePath;
  bool isNull;

  ProfileScreen(
      {required this.userName, required this.imagePath, required this.isNull});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  var imageFile = imageProfile;
  late String imageUrl;
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myData = [
      {
        'name': 'Update Profile',
        'icon': Icons.person_pin,
        'route': () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => Updateprofile()))
      },
      {
        'name': 'Your Reservations',
        'icon': Icons.note,
        'route': () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ReservationScreen()))
      },
      {
        'name': 'Your Clients',
        'icon': Icons.people_alt_outlined,
        'route': () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => DoctorReservationsScreen()))
      },
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: primary,
            fontSize: 24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                child: InkWell(
                  onTap: () async {
                    bool flag = await pickImageFromGallery();
                    if (flag) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Home()));
                    }
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60,
                          child: ClipOval(
                            child: Image.file(
                              File(widget.imagePath!),
                              fit: BoxFit.fitWidth,
                              height: 150,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () async {
                              bool flag = await pickImageFromGallery();
                              if (flag) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Home()));
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Center(
              child: Text(
                widget.userName!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                  letterSpacing: 0.44,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...List.generate(myData.length, (index) {
              bool _flage = true;
              if (isDoctor && myData[index]['name'] == 'Your Reservations') {
                _flage = false;
              }
              if (!isDoctor && myData[index]['name'] == 'Your Clients') {
                _flage = false;
              }

              final data = myData[index];
              return _flage
                  ? Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          data['icon'],
                          size: 30,
                          color: primary, // Adjust color as needed
                        ),
                        title: Text(
                          data['name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),
                          onPressed: data['route'],
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SigninScreen()));
                      },
                      icon: Icon(
                        Icons.exit_to_app_outlined,
                        size: 30,
                        color: primary,
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Logout',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    FirestoreService userInfo = await FirestoreService();

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      await userInfo.updateUserInfo(
          userId: currentId, imagUrl: imageFile?.path);

      setState(() {});
      return true;
    } else {
      return false;
    }
  }
}
