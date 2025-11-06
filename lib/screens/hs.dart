// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:grad_app/auth/SignInScreen.dart';
// import 'dart:io';
//
// import 'package:grad_app/model/custom_bar.dart';
// import 'package:grad_app/screens/report_screen.dart';
//
// import 'chat bot screen.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: CustomBar(),
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   GoogleSignIn googleSignIn = GoogleSignIn();
//                   googleSignIn.disconnect();
//                   await FirebaseAuth.instance.signOut();
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (_) => SigninScreen()),
//                       (route) => false);
//                 },
//                 icon: Icon(Icons.exit_to_app))
//           ],
//           title: Text(
//             'HomeScreen',
//             style: GoogleFonts.sacramento(
//                 fontSize: 40, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: FirebaseAuth.instance.currentUser!.emailVerified
//             ? Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => ChatbotScreen( title:'ChatBot')),
//                       ),
//                       child: Card(
//                         elevation: 10,
//                         child: ListTile(
//                           title: Image.asset(
//                             'images/chat_bot.png',
//                             height: 150,
//                           ),
//                           subtitle: Center(
//                             child: Text(
//                               'Chat bot',
//                               style: GoogleFonts.acme(fontSize: 20),
//                             ),
//                             heightFactor: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         // Navigator.push(context,
//                         //     MaterialPageRoute(builder: (_) => ReportScreen()));
//                       },
//                       child: Card(
//                         elevation: 10,
//                         child: ListTile(
//                           title: Image.asset(
//                             'images/report.jpg',
//                             height: 150,
//                           ),
//                           subtitle: Center(
//                             child: Text(
//                               'AI doctor',
//                               style: GoogleFonts.acme(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             heightFactor: 2,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             : Text('Please verify your email '));
//   }
// }
