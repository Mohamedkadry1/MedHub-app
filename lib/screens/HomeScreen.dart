import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad_app/model/dr%20card.dart';
import 'package:grad_app/model/user.dart';
import 'package:grad_app/screens/APiScreen.dart';
import 'package:grad_app/screens/doctorsScreen.dart';
import 'package:grad_app/screens/profile.dart';
import 'package:grad_app/services/auth.dart';
import 'package:grad_app/services/firestore_service.dart';
import 'package:provider/provider.dart';

import '../appLang/app_languages.dart';
import '../auth/SignInScreen.dart';
import '../const.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';

import '../model/custom_bar.dart';
import 'AppointmentScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

bool isDoctor = false;
late String currentId;
String userName = '';
var imageProfile;

class _HomeState extends State<Home> {

  final AuthService auth = AuthService();
  final FirestoreService firestore = FirestoreService();
  bool isLoading = false;
  List<UserModel> doctors = [];
  bool _isEnglish = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchDoctors();
  }

  Future<void> _getCurrentUser() async {
    User? user = await auth.getCurrentUser();
    if (user != null) {
      print(user.uid);
      Map<String, dynamic>? userInfo = await firestore.getUserInfo(user.uid);
      setState(() {
        currentId = user.uid;
        userName = userInfo!['name'];
        imageProfile = userInfo!['profileImageUrl'];
        print(imageProfile);
        if (userInfo['isDoctor'] == true) {
          isDoctor = true;
        } else {
          isDoctor = false;
          isLoading = true;
        }
      });
    }
  }

  Future<void> _fetchDoctors() async {
    List<UserModel> fetchDoctors = await firestore.getAllDoctors();
    setState(() {
      doctors = fetchDoctors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBar(),
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(.3),
        elevation: 3,
        surfaceTintColor: white,
        leading: InkWell(
          onTap: () {
            print(userName.toString());
            if (imageProfile == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                          isNull: true,
                          userName: userName,
                          imagePath: isDoctor
                              ? 'images/doctor.png'
                              : 'images/Ellipse 18.png')));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                          isNull: false,
                          userName: userName,
                          imagePath: imageProfile)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: primary,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipOval(
                  child: imageProfile == null
                      ? Image.asset('images/Ellipse 18.png')
                      : Image.file(
                          File(imageProfile),
                          fit: BoxFit.contain,
                          width: 100,
                          height: 100,
                        ),
                  // child: isDoctor
                  //     ? Image.asset('images/doctor.png')
                  //     : Image.asset('images/Ellipse 18.png'),
                ),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, Welcome Back,',
              style: TextStyle(
                color: gray,
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                height: 0.08,
                letterSpacing: 0.40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              userName ?? 'asd.dart',
              style: const TextStyle(
                color: black,
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                height: 0.07,
                letterSpacing: 0.10,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                final appLanguage =
                    Provider.of<AppLanguage>(context, listen: false);
                if (appLanguage.appLocale.languageCode == 'en') {
                  appLanguage.changeLanguage(const Locale('ar'));
                  _isEnglish = false;
                  setState(() {});
                } else {
                  appLanguage.changeLanguage(const Locale('en'));
                  _isEnglish = true;
                  setState(() {});
                }
              },
              child: Row(
                children: [
                  _isEnglish ? Text('EN') : Text('AR'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _isEnglish
                        ? Image.asset(
                            'images/united-kingdom.png',
                            width: 30,
                            height: 30,
                          )
                        : Image.asset(
                            'images/arabic.png',
                            width: 30,
                            height: 30,
                          ),
                  ),
                ],
              ))
        ],
      ),
      body: FirebaseAuth.instance.currentUser!.emailVerified
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FadyScreen()));
                    },
                    child: Image.asset(
                      'images/Chat bot-pana.png',
                      height: 300,
                      width: double.infinity,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      child: Animator<double>(
                          duration: const Duration(milliseconds: 1500),
                          cycles: 0,
                          repeats: 3,
                          curve: Curves.easeOutCubic,
                          tween: Tween<double>(begin: 15.0, end: 25.0),
                          builder: (context, animatorState, child) =>
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primary),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const FadyScreen()));
                                  },
                                  child: Text(
                                    'Let\'s Chat',
                                    style: TextStyle(
                                        color: white,
                                        fontSize: animatorState.value * 1),
                                  ))),
                    ),
                  ),
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'All Doctors',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 20,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w500,
                                  height: 0.05,
                                  letterSpacing: -0.44,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DoctorsScreen(
                                                doctors: doctors,
                                              )));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      color: gray,
                                      fontSize: 20,
                                      fontFamily: 'Open Sans',
                                      height: 0.05,
                                      letterSpacing: -0.44,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(''),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AppointmentScreen(
                                    specialty: doctors[0].specialty,
                                    doctorId: doctors[0].uid,
                                    doctorName: doctors[0].username,
                                  )));
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading
                            ? CardWidget(
                                imagePath: doctors[0].profileImageUrl,
                                doctorId: doctors[0].uid,
                                name: doctors[0].username,
                                specialty: doctors[0].specialty)
                            : Text('')),
                  ),
                ],
              ),
            )
          : const Text('Please verify your email '),
    );
  }
}
