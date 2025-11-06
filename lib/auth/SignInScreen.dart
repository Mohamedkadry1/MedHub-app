// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:grad_app/auth/SignUpScreen.dart';
// import 'package:grad_app/model/cutsom_text_filed.dart';
// import 'package:sign_in_button/sign_in_button.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import '../const.dart';
// import '../main.dart';
// import '../screens/HomeScreen.dart';
//
// class SigninScreen extends StatefulWidget {
//   const SigninScreen({super.key});
//
//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }
//
// class _SigninScreenState extends State<SigninScreen> {
//
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   GlobalKey<FormState> key = GlobalKey<FormState>();
//   @override
//   Future signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return;
//
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const Home(),
//       ),
//     );
//   }
//
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: white,
//       appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             'Welcome',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: primary,
//               fontSize: 26,
//               fontFamily: 'Open Sans',
//               fontWeight: FontWeight.w700,
//               height: 0.04,
//               letterSpacing: -0.52,
//             ),
//           )),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Form(
//             key: key,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // CircleAvatar(
//                 //   backgroundColor: Colors.amberAccent,
//                 //   radius: 45,
//                 //   child: Image.asset('images/Medinova.png')
//                 // ),
//
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
//                   child: Text(
//                     'Sign In',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 26,
//                       fontFamily: 'Open Sans',
//                       fontWeight: FontWeight.w700,
//                       height: 0.04,
//                       letterSpacing: -0.52,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 CutsomTextFiled(
//                   obscureText: false,
//                   isPassword: false,
//                     labelText: 'Email',
//                     hintText: 'Enter Your Email',
//                     controller: email,
//                     validator: (val) {
//                       if (val == '') return '* Email is required.';
//                     }
//                   // validator: (value) {
//                   //   if (value!.length <= 7 ||
//                   //       !RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{6,}$')
//                   //           .hasMatch(value)) {
//                   //     return 'your password must contain Capital and small letters \n and be at least 8 character';
//                   //   }
//                   //   return null;
//                   // },
//                   ),
//                 CutsomTextFiled(
//                   isPassword: true,
//                     obscureText: true,
//                     labelText:'Password' ,
//                     hintText: 'Enter Your Password',
//                     controller: password,
//                     validator: (val) {
//                       if (val == '') return '* Password is required.';
//                     }),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     if (email.text == '') {
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.error,
//                         animType: AnimType.rightSlide,
//                         title: 'Error',
//                         desc: 'Email is required.',
//                         btnCancelOnPress: () {},
//                         btnOkOnPress: () {},
//                       ).show();
//                     }
//                     try {
//                       await FirebaseAuth.instance
//                           .sendPasswordResetEmail(email: email.text);
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.info,
//                         animType: AnimType.rightSlide,
//                         title: 'info',
//                         desc: 'Check your email to rest the password.',
//                         btnCancelOnPress: () {},
//                         btnOkOnPress: () {},
//                       ).show();
//                     } catch (e) {
//                       if (email != '') {
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.error,
//                           animType: AnimType.rightSlide,
//                           title: 'Error',
//                           desc: 'This email not exist.',
//                           btnCancelOnPress: () {},
//                           btnOkOnPress: () {},
//                         ).show();
//                       }
//                     }
//                   },
//                   child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       alignment: Alignment.topRight,
//                       child: const Text(
//                         'Forget Password',
//                         style: TextStyle(
//                           color: black,
//                           fontSize: 16,
//                           fontFamily: 'Open Sans',
//                           fontWeight: FontWeight.w600,
//                           height: 0.06,
//                           letterSpacing: -0.36,
//                         ),
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: 55,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         backgroundColor: primary),
//                     onPressed: () async {
//                       if (key.currentState!.validate()) {
//                         try {
//                           await FirebaseAuth.instance
//                               .signInWithEmailAndPassword(
//                                   email: email.text, password: password.text);
//                           if (FirebaseAuth
//                               .instance.currentUser!.emailVerified) {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const Home()));
//                           } else {
//                             FirebaseAuth.instance.currentUser!
//                                 .sendEmailVerification();
//                             AwesomeDialog(
//                               context: context,
//                               dialogType: DialogType.warning,
//                               animType: AnimType.rightSlide,
//                               title: 'Warning',
//                               desc: 'Verify your account on Gmail .',
//                               btnCancelOnPress: () {},
//                               btnOkOnPress: () {},
//                             ).show();
//                           }
//                         } on FirebaseAuthException catch (e) {
//                           String errorMessage;
//                           if (e.code == 'user-not-found') {
//                             errorMessage = 'No user found for that email.';
//                           } else if (e.code == 'wrong-password') {
//                             errorMessage =
//                                 'Wrong password provided for that user.';
//                           } else {
//                             errorMessage = 'check your email or password.';
//                           }
//                           AwesomeDialog(
//                             context: context,
//                             dialogType: DialogType.error,
//                             animType: AnimType.rightSlide,
//                             title: 'Error',
//                             desc: errorMessage,
//                             btnOkOnPress: () {},
//                           ).show();
//                         }
//                       } else {
//                         print('adssssss');
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.error,
//                           animType: AnimType.rightSlide,
//                           title: 'Error',
//                           desc: 'Email and password are required.',
//                           btnCancelOnPress: () {},
//                           btnOkOnPress: () {},
//                         ).show();
//                       }
//                     },
//                     child: const Text(
//                       'Sign In',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: 'Open Sans',
//                         fontWeight: FontWeight.w700,
//                         height: 0.05,
//                         letterSpacing: -0.44,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         //color: Color(0xffEBF0FF),
//                         color: primary,
//                         height: 2,
//                       ),
//                     ),
//                     const Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         child: Text(
//                           'OR',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: gray,
//                             fontSize: 18,
//                             fontFamily: 'Averia Sans Libre',
//                             fontWeight: FontWeight.w700,
//                             height: 0.05,
//                             letterSpacing: -0.44,
//                           ),
//                         )),
//                     Expanded(
//                       child: Container(
//                         //color: Color(0xffEBF0FF),
//                         color: primary,
//                         width: double.infinity,
//                         height: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SignInButton(Buttons.google, elevation: 5, onPressed: () {
//                       signInWithGoogle();
//                     }),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     SignInButton(
//                       mini: true,
//                       elevation: 5,
//                       Buttons.apple,
//                       onPressed: () async {
//                         // await signOut();
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const SignupScreen()));
//                     },
//                     child: const Text.rich(
//                       TextSpan(children: [
//                         TextSpan(
//                             text: "Don't Have An Account? ",
//                             style: TextStyle(
//                               color: gray,
//                               fontSize: 16,
//                               fontFamily: 'Open Sans',
//                               fontWeight: FontWeight.w600,
//                             )),
//                         TextSpan(
//                           text: "Sign Up",
//                           style: TextStyle(
//                             color: primary,
//                             fontSize: 16,
//                             fontFamily: 'Open Sans',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Text(
//                     'By signing in you are agreeing to our ',
//                     style: TextStyle(color: Colors.grey[800]),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Center(
//                   child: Text(
//                     '  Terms and privacy policy ',
//                     style: TextStyle(color: Colors.grey[800]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:grad_app/model/cutsom_text_filed.dart';
// import 'package:provider/provider.dart';
// import '../appLang/app_languages.dart';
// import '../const.dart';
// import '../screens/HomeScreen.dart';
// import '../../generated/l10n.dart';
//
//
// class SigninScreen extends StatefulWidget {
//   const SigninScreen({super.key});
//
//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }
//
// class _SigninScreenState extends State<SigninScreen> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   GlobalKey<FormState> key = GlobalKey<FormState>();
//
//   @override
//   Future signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return;
//
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const Home(),
//       ),
//     );
//   }
//   bool loading =false;
//   // Future changeLanguage(BuildContext context) async {
//   //   final appLan = Provider.of<AppLanguage>(context, listen: false);
//   //   setState(() {
//   //     loading = true;
//   //   });
//   //   if (appLan.appLang == Languages.en) {
//   //     await appLan.changeLanguage(language: Languages.ar);
//   //     await Future.delayed(const Duration(milliseconds: 30));
//   //     setState(() {});
//   //   } else if (appLan.appLang == Languages.ar) {
//   //     await appLan.changeLanguage(language: Languages.en);
//   //     await Future.delayed(const Duration(milliseconds: 30));
//   //   }
//   //   setState(() {
//   //     loading = false;
//   //   });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: white,
//       appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             S.of(context)!.welcomeMessage,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: primary,
//               fontSize: 26,
//               fontFamily: 'Open Sans',
//               fontWeight: FontWeight.w700,
//               height: 0.04,
//               letterSpacing: -0.52,
//             ),
//           )),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Form(
//             key: key,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
//                   // child: Text(
//                   //   Strings.saturday.tr,
//                   //   textAlign: TextAlign.center,
//                   //   style: const TextStyle(
//                   //     color: Colors.black,
//                   //     fontSize: 26,
//                   //     fontFamily: 'Open Sans',
//                   //     fontWeight: FontWeight.w700,
//                   //     height: 0.04,
//                   //     letterSpacing: -0.52,
//                   //   ),
//                   // ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 CutsomTextFiled(
//                   obscureText: false,
//                   isPassword: false,
//                   labelText: S.of(context)!.email,
//                   hintText: S.of(context)!.email,
//                   controller: email,
//                   validator: (val) {
//                     if (val == '') return '* ${S.of(context)!.email} ${S.of(context)!.emailRequired}.';
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final appLanguage = Provider.of<AppLanguage>(context, listen: false);
//                     if (appLanguage.appLocale.languageCode == 'en') {
//                       appLanguage.changeLanguage(const Locale('ar'));
//                     } else {
//                       appLanguage.changeLanguage(const Locale('en'));
//                     }
//                   },
//                   child: Text('Change Language'),
//                 ),
//                 // TextButton(onPressed: ()=>changeLanguage(context), child: Text("TRANSLATE",style: TextStyle(fontSize: 20),))
//               //   CutsomTextFiled(
//               //     isPassword: true,
//               //     obscureText: true,
//               //     labelText: S.of(context).password,
//               //     hintText: S.of(context).enterYourPassword,
//               //     controller: password,
//               //     validator: (val) {
//               //       if (val == '') return '* ${S.of(context).password} ${S.of(context).required}.';
//               //     },
//               //   ),
//               //   const SizedBox(
//               //     height: 10,
//               //   ),
//               //   InkWell(
//               //     onTap: () async {
//               //       if (email.text == '') {
//               //         AwesomeDialog(
//               //           context: context,
//               //           dialogType: DialogType.error,
//               //           animType: AnimType.rightSlide,
//               //           title: 'Error',
//               //           desc: '${S.of(context).email} ${S.of(context).required}.',
//               //           btnCancelOnPress: () {},
//               //           btnOkOnPress: () {},
//               //         ).show();
//               //       }
//               //       try {
//               //         await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
//               //         AwesomeDialog(
//               //           context: context,
//               //           dialogType: DialogType.info,
//               //           animType: AnimType.rightSlide,
//               //           title: 'Info',
//               //           desc: S.of(context).checkYourEmail,
//               //           btnCancelOnPress: () {},
//               //           btnOkOnPress: () {},
//               //         ).show();
//               //       } catch (e) {
//               //         if (email.text != '') {
//               //           AwesomeDialog(
//               //             context: context,
//               //             dialogType: DialogType.error,
//               //             animType: AnimType.rightSlide,
//               //             title: 'Error',
//               //             desc: S.of(context).emailDoesNotExist,
//               //             btnCancelOnPress: () {},
//               //             btnOkOnPress: () {},
//               //           ).show();
//               //         }
//               //       }
//               //     },
//               //     child: Container(
//               //         padding: const EdgeInsets.symmetric(vertical: 15),
//               //         alignment: Alignment.topRight,
//               //         child: Text(
//               //           S.of(context).forgotPassword,
//               //           style: const TextStyle(
//               //             color: black,
//               //             fontSize: 16,
//               //             fontFamily: 'Open Sans',
//               //             fontWeight: FontWeight.w600,
//               //             height: 0.06,
//               //             letterSpacing: -0.36,
//               //           ),
//               //         )),
//               //   ),
//               //   const SizedBox(
//               //     height: 20,
//               //   ),
//               //   SizedBox(
//               //     height: 55,
//               //     width: double.infinity,
//               //     child: ElevatedButton(
//               //       style: ElevatedButton.styleFrom(
//               //           shape: RoundedRectangleBorder(
//               //             borderRadius: BorderRadius.circular(10),
//               //           ),
//               //           backgroundColor: primary),
//               //       onPressed: () async {
//               //         if (key.currentState!.validate()) {
//               //           try {
//               //             await FirebaseAuth.instance
//               //                 .signInWithEmailAndPassword(
//               //                 email: email.text, password: password.text);
//               //             if (FirebaseAuth
//               //                 .instance.currentUser!.emailVerified) {
//               //               Navigator.pushReplacement(
//               //                   context,
//               //                   MaterialPageRoute(
//               //                       builder: (context) => const Home()));
//               //             } else {
//               //               AwesomeDialog(
//               //                 context: context,
//               //                 dialogType: DialogType.error,
//               //                 animType: AnimType.rightSlide,
//               //                 title: 'Error',
//               //                 desc: S.of(context).emailVerificationError,
//               //                 btnCancelOnPress: () {},
//               //                 btnOkOnPress: () {},
//               //               ).show();
//               //             }
//               //           } on FirebaseAuthException catch (e) {
//               //             AwesomeDialog(
//               //               context: context,
//               //               dialogType: DialogType.error,
//               //               animType: AnimType.rightSlide,
//               //               title: 'Error',
//               //               desc: e.message,
//               //               btnCancelOnPress: () {},
//               //               btnOkOnPress: () {},
//               //             ).show();
//               //           }
//               //         }
//               //       },
//               //       child: Text(
//               //         S.of(context).signInButton,
//               //         style: const TextStyle(
//               //           color: white,
//               //           fontSize: 18,
//               //           fontFamily: 'Open Sans',
//               //           fontWeight: FontWeight.w700,
//               //           height: 0.03,
//               //           letterSpacing: -0.36,
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               //   const SizedBox(
//               //     height: 10,
//               //   ),
//               //   Center(
//               //       child: Text(
//               //         S.of(context).or,
//               //         style: const TextStyle(
//               //           color: black,
//               //           fontSize: 16,
//               //           fontFamily: 'Open Sans',
//               //           fontWeight: FontWeight.w700,
//               //           height: 0.03,
//               //           letterSpacing: -0.36,
//               //         ),
//               //       )),
//               //   const SizedBox(
//               //     height: 10,
//               //   ),
//               //   Center(
//               //     child: SignInButton(
//               //       Buttons.Google,
//               //       text: S.of(context).signInWithGoogle,
//               //       onPressed: () async {
//               //         await signInWithGoogle();
//               //       },
//               //     ),
//               //   ),
//               //   const SizedBox(
//               //     height: 20,
//               //   ),
//               //   Center(
//               //       child: Text(
//               //         S.of(context).dontHaveAccount,
//               //         style: const TextStyle(
//               //           color: Colors.black,
//               //           fontSize: 16,
//               //           fontFamily: 'Open Sans',
//               //           fontWeight: FontWeight.w700,
//               //           height: 0.03,
//               //           letterSpacing: -0.36,
//               //         ),
//               //       )),
//               //   Center(
//               //       child: InkWell(
//               //         onTap: () {
//               //           Navigator.pushReplacement(
//               //             context,
//               //             MaterialPageRoute(
//               //                 builder: (context) => const SignUpScreen()),
//               //           );
//               //         },
//               //         child: Text(
//               //           S.of(context).signUp,
//               //           style: const TextStyle(
//               //             color: primary,
//               //             fontSize: 16,
//               //             fontFamily: 'Open Sans',
//               //             fontWeight: FontWeight.w700,
//               //             height: 0.03,
//               //             letterSpacing: -0.36,
//               //           ),
//               //         ),
//               //       )),
//               //   const SizedBox(
//               //     height: 10,
//               //   ),
//               //   Padding(
//               //     padding: const EdgeInsets.only(top: 30),
//               //     child: Center(
//               //       child: Text(
//               //         S.of(context)?.termsPrivacy,
//               //         textAlign: TextAlign.center,
//               //         style: const TextStyle(
//               //           color: Colors.black,
//               //           fontSize: 12,
//               //           fontFamily: 'Open Sans',
//               //           fontWeight: FontWeight.w400,
//               //           height: 0.06,
//               //           letterSpacing: -0.24,
//               //         ),
//               //       ),
//               //     ),
//               //   // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//
// }
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../appLang/app_languages.dart';
import '../const.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../model/cutsom_text_filed.dart';
import '../screens/HomeScreen.dart';
import 'SignUpScreen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }
bool _isEnglish=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          S.of(context)!.welcomeMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: primary,
            fontSize: 26,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            height: 0.04,
            letterSpacing: -0.52,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                  child: Text(
                    S.of(context)!.signIn,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      height: 0.04,
                      letterSpacing: -0.52,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CutsomTextFiled(
                  obscureText: false,
                  isPassword: false,
                  labelText: S.of(context)!.email,
                  hintText: S.of(context)!.email,
                  controller: email,
                  validator: (val) {
                    if (val == '') return '* ${S.of(context)!.emailRequired}';
                  },
                ),
                CutsomTextFiled(
                  isPassword: true,
                  obscureText: true,
                  labelText: S.of(context)!.password,
                  hintText: S.of(context)!.password,
                  controller: password,
                  validator: (val) {
                    if (val == '') return '* ${S.of(context)!.passwordRequired}';
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    if (email.text == '') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: S.of(context)!.emailVerificationError,
                        desc: S.of(context)!.emailRequired,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    }
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'info',
                        desc: 'Check your email to reset the password.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    } catch (e) {
                      if (email != '') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'This email does not exist.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.topRight,
                    child: Text(
                      S.of(context)!.forgotPassword,
                      style: const TextStyle(
                        color: black,
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                        letterSpacing: -0.36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: primary,
                    ),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                          if (FirebaseAuth.instance.currentUser!.emailVerified) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                            );
                          } else {
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Warning',
                              desc: 'Verify your account on Gmail.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          String errorMessage;
                          if (e.code == 'user-not-found') {
                            errorMessage = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            errorMessage = 'Wrong password provided for that user.';
                          } else {
                            errorMessage = 'Check your email or password.';
                          }
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: errorMessage,
                            btnOkOnPress: () {},
                          ).show();
                        }
                      } else {
                        print('adssssss');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: '${S.of(context)!.emailRequired} and ${S.of(context)!.passwordRequired}.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    child: Text(
                      S.of(context)!.signIn,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        height: 0.05,
                        letterSpacing: -0.44,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: primary,
                        height: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: gray,
                          fontSize: 18,
                          fontFamily: 'Averia Sans Libre',
                          fontWeight: FontWeight.w700,
                          height: 0.05,
                          letterSpacing: -0.44,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: primary,
                        width: double.infinity,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(Buttons.google, elevation: 5, onPressed: signInWithGoogle),
                    const SizedBox(width: 20),
                    // SignInButton(
                    //   mini: true,
                    //   elevation: 5,
                    //   buttons: Buttons.apple,
                    //   onPressed: () async {
                    //     // await signOut();
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: S.of(context)!.noAccount,
                          style: const TextStyle(
                            color: gray,
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " ${S.of(context)!.signUp}",
                          style: const TextStyle(
                            color: primary,
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '${S.of(context)!.termsAndPrivacy} ',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 5),
                // ElevatedButton(
                //   onPressed: () {
                //     final appLanguage = Provider.of<AppLanguage>(context, listen: false);
                //     if (appLanguage.appLocale.languageCode == 'en') {
                //       appLanguage.changeLanguage(const Locale('ar'));
                //     } else {
                //       appLanguage.changeLanguage(const Locale('en'));
                //     }
                //   },
                //   child: Text('Change Language'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
