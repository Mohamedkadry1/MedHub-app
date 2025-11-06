// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grad_app/const.dart';
// import 'package:grad_app/screens/profile.dart';
//
// import '../screens/HomeScreen.dart';
// import '../screens/MessangerScreen.dart';
// import '../screens/ReservationScreen.dart';
// import '../screens/patientScreen.dart';
//
// class CustomBar extends StatefulWidget {
//   @override
//   CustomBarState createState() => CustomBarState();
// }
//
// class CustomBarState extends State<CustomBar> {
//   var currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double displayWidth = MediaQuery.of(context).size.width;
//     return Container(
//       margin: EdgeInsets.only(top: 7, bottom: 3),
//       height: displayWidth * .155,
//       decoration: BoxDecoration(
//         color: white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.3),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(1),
//       ),
//       child: ListView.builder(
//         itemCount: 4,
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
//         itemBuilder: (context, index) => InkWell(
//           onTap: () {
//             setState(() {
//               currentIndex = index;
//               HapticFeedback.lightImpact();
//             });
//             // Navigation logic
//             if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChatWithDr()),
//               );
//             } else if (index == 2) {
//               print(isDoctor);
//               if (isDoctor) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DoctorReservationsScreen()));
//               } else {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ReservationScreen()));
//               }
//             } else if (index == 3) {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => ProfileScreen()),
//               // );
//             }
//           },
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           child: Stack(
//             children: [
//               AnimatedContainer(
//                 duration: Duration(seconds: 1),
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 width: index == currentIndex
//                     ? displayWidth * .32
//                     : displayWidth * .18,
//                 alignment: Alignment.center,
//                 child: AnimatedContainer(
//                   duration: Duration(seconds: 1),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   height: index == currentIndex ? displayWidth * .12 : 0,
//                   width: index == currentIndex ? displayWidth * .32 : 0,
//                   decoration: BoxDecoration(
//                     color: index == currentIndex
//                         ? Colors.blueAccent.withOpacity(.2)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: Duration(seconds: 1),
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 width: index == currentIndex
//                     ? displayWidth * .31
//                     : displayWidth * .18,
//                 alignment: Alignment.center,
//                 child: Stack(
//                   children: [
//                     Row(
//                       children: [
//                         AnimatedContainer(
//                           duration: Duration(seconds: 1),
//                           curve: Curves.fastLinearToSlowEaseIn,
//                           width: index == currentIndex ? displayWidth * .13 : 0,
//                         ),
//                         AnimatedOpacity(
//                           opacity: index == currentIndex ? 1 : 0,
//                           duration: Duration(seconds: 1),
//                           curve: Curves.fastLinearToSlowEaseIn,
//                           child: Text(
//                             index == currentIndex
//                                 ? '${listOfStrings[index]}'
//                                 : '',
//                             style: GoogleFonts.acme(
//                                 fontSize: 15,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         AnimatedContainer(
//                           duration: Duration(seconds: 1),
//                           curve: Curves.fastLinearToSlowEaseIn,
//                           width:
//                               index == currentIndex ? displayWidth * .03 : 20,
//                         ),
//                         Icon(
//                           listOfIcons[index],
//                           size: displayWidth * .09,
//                           color:
//                               index == currentIndex ? primary : Colors.black26,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.chat,
//     Icons.margin,
//     Icons.person_rounded,
//   ];
//
//   List<String> listOfStrings = [
//     'Home',
//     'Chat',
//     'Reserve',
//     'Account',
//   ];
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_app/const.dart';
import 'package:grad_app/screens/profile.dart';

import '../screens/HomeScreen.dart';
import '../screens/ReservationScreen.dart';
import '../screens/patientScreen.dart';

class CustomBar extends StatefulWidget {
  @override
  CustomBarState createState() => CustomBarState();
}

class CustomBarState extends State<CustomBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 7, bottom: 2),
      height: displayWidth * .155,
      decoration: BoxDecoration(
        color: primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(1),
      ),
      child: ListView.builder(
        itemCount: listOfStrings.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: displayWidth * .1),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
              HapticFeedback.lightImpact();
            });
            if (index == 1) {
              print(isDoctor);
              if (isDoctor) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorReservationsScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReservationScreen()));
              }
            } else if (index == 2) {
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
                            imagePath: isDoctor
                                ? 'images/doctor.png'
                                : imageProfile)));
              }
            }
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == currentIndex
                    ? displayWidth * .32
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == currentIndex ? displayWidth * .12 : 0,
                  width: index == currentIndex ? displayWidth * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? Colors.white.withOpacity(.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == currentIndex
                    ? displayWidth * .31
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex ? displayWidth * .13 : 0,
                        ),
                        AnimatedOpacity(
                          opacity: index == currentIndex ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Text(
                            index == currentIndex ? listOfStrings[index] : '',
                            style: GoogleFonts.cairo(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width:
                              index == currentIndex ? displayWidth * .03 : 20,
                        ),
                        Icon(
                          listOfIcons[index],
                          size: displayWidth * .09,
                          color: index == currentIndex ? white : Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.margin,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Reserve',
    'Account',
  ];
}
