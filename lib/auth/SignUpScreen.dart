// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:grad_app/auth/SignInScreen.dart';
// import 'package:grad_app/model/cutsom_text_filed.dart';
// import 'package:grad_app/model/user.dart';
// import 'package:sign_in_button/sign_in_button.dart';
// import 'package:grad_app/services/firestore_service.dart';
//
// import '../const.dart';
// import '../screens/HomeScreen.dart';
// import '../widgets/loadingCircle.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   @override
//   bool _isDoctor = false;
//   Widget build(BuildContext context) {
//     TextEditingController userName = TextEditingController();
//     TextEditingController email = TextEditingController();
//     TextEditingController password = TextEditingController();
//     GlobalKey<FormState> key = GlobalKey<FormState>();
//     final FirestoreService firestore = FirestoreService();
//     Future signInWithGoogle() async {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return;
//
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const Home(),
//         ),
//       );
//     }
//
//     // Future<void> signUpWithEmailAndPassword() async {
//     //   if (key.currentState!.validate()) {
//     //     try {
//     //       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     //         email: email.text,
//     //         password: password.text,
//     //       );
//     //       final user = credential.user;
//     //
//     //       if (user != null) {
//     //         await firestore.addUser(
//     //           user.uid,
//     //           email.text,
//     //           userName.text,
//     //           password.text,
//     //           'default_profile_image_url', // Replace with actual profile image URL if available
//     //           '', // Specialty can be added later if user is a doctor
//     //           'client', // Or 'doctor' depending on the user's role
//     //         );
//     //
//     //         user.sendEmailVerification();
//     //
//     //         AwesomeDialog(
//     //           context: context,
//     //           dialogType: DialogType.warning,
//     //           animType: AnimType.rightSlide,
//     //           title: 'Warning',
//     //           desc: 'Verify your account.',
//     //           btnCancelOnPress: () {},
//     //           btnOkOnPress: () {
//     //             Navigator.pushReplacement(
//     //               context,
//     //               MaterialPageRoute(builder: (_) => SigninScreen()),
//     //             );
//     //           },
//     //         ).show();
//     //       }
//     //     } on FirebaseAuthException catch (e) {
//     //       if (e.code == 'weak-password') {
//     //         AwesomeDialog(
//     //           context: context,
//     //           dialogType: DialogType.error,
//     //           animType: AnimType.rightSlide,
//     //           title: 'Error',
//     //           desc: 'The password provided is too weak.',
//     //           btnCancelOnPress: () {},
//     //           btnOkOnPress: () {},
//     //         ).show();
//     //       } else if (e.code == 'email-already-in-use') {
//     //         AwesomeDialog(
//     //           context: context,
//     //           dialogType: DialogType.error,
//     //           animType: AnimType.rightSlide,
//     //           title: 'Error',
//     //           desc: 'The account already exists for that email.',
//     //           btnCancelOnPress: () {},
//     //           btnOkOnPress: () {},
//     //         ).show();
//     //       }
//     //     } catch (e) {
//     //       print(e);
//     //     }
//     //   } else {
//     //     AwesomeDialog(
//     //       context: context,
//     //       dialogType: DialogType.error,
//     //       animType: AnimType.rightSlide,
//     //       title: 'Error',
//     //       desc: 'Password, username, and email are required.',
//     //       btnCancelOnPress: () {},
//     //       btnOkOnPress: () {},
//     //     ).show();
//     //   }
//     // }
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Create New Account',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: primary,
//             fontSize: 26,
//             fontFamily: 'Open Sans',
//             fontWeight: FontWeight.w700,
//             height: 0.04,
//             letterSpacing: -0.52,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Form(
//           key: key,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               SwitchListTile(
//                 title: _isDoctor
//                     ? const Text('Your role is a doctor')
//                     : const Text('Register as a doctor'),
//                 value: _isDoctor,
//                 onChanged: (val) {
//                   setState(() {
//                     _isDoctor = val;
//                   });
//                 },
//                 secondary: _isDoctor
//                     ? Image.asset('images/doctor2.png')
//                     : Image.asset('images/boy.png'),
//                 activeColor: primary,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CutsomTextFiled(
//                 obscureText: false,
//                 isPassword: false,
//                 hintText: 'Enter Your Full Name',
//                 labelText: "Full Name",
//                 controller: userName,
//                 validator: (val) {
//                   if (val == '') return '* UserName is required.';
//                   return null;
//                 },
//               ),
//               CutsomTextFiled(
//                 obscureText: false,
//                 isPassword: false,
//                 hintText: 'Enter Your Email',
//                 labelText: "Email",
//                 controller: email,
//                 validator: (val) {
//                   if (val == '') return '* Email is required.';
//                   return null;
//                 },
//               ),
//               CutsomTextFiled(
//                   isPassword: true,
//                   obscureText: true,
//                   hintText: 'Enter Your Password',
//                   labelText: "Password",
//                   controller: password,
//                   validator: (val) {
//                     if (val == '') return '* Password is required.';
//                     return null;
//                   }),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                   height: 55,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: primary),
//                     onPressed: () async {
//                       if (key.currentState!.validate()) {
//                         try {
//                           final credential = await FirebaseAuth.instance
//                               .createUserWithEmailAndPassword(
//                             email: email.text,
//                             password: password.text,
//                           );
//                           final user = credential.user;
//                           if (user != null) {
//                             UserModel newUser = UserModel(
//                                 uid: user.uid,
//                                 username: userName.text,
//                                 email: email.text,
//                                 password: password.text,
//                                 profileImageUrl:
//                                     'default_profile_image_url', // Replace with actual profile image URL if available
//                                 specialty: '',
//                                 isDoctor: _isDoctor);
//                             await firestore.addUser(newUser);
//                           }
//                           FirebaseAuth.instance.currentUser!
//                               .sendEmailVerification(); //send sendEmailVerification
//                           AwesomeDialog(
//                             context: context,
//                             dialogType: DialogType.warning,
//                             animType: AnimType.rightSlide,
//                             title: 'warning',
//                             desc: 'Verify your account.',
//                             btnOkOnPress: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => const SigninScreen()),
//                               );
//                             },
//                           ).show();
//                           await Future.delayed(const Duration(seconds: 40));
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const SigninScreen()),
//                           );
//                         } on FirebaseAuthException catch (e) {
//                           String errorMsg = '';
//                           if (e.code == 'weak-password') {
//                             errorMsg = 'The password provided is too weak.';
//                             // AwesomeDialog(
//                             //   context: context,
//                             //   dialogType: DialogType.error,
//                             //   animType: AnimType.rightSlide,
//                             //   title: 'Error',
//                             //   desc: 'The password provided is too weak.',
//                             //   btnCancelOnPress: () {},
//                             //   btnOkOnPress: () {},
//                             // ).show();
//                           } else if (e.code == 'email-already-in-use') {
//                             errorMsg =
//                                 'The account already exists for that email.';
//                             // AwesomeDialog(
//                             //   context: context,
//                             //   dialogType: DialogType.error,
//                             //   animType: AnimType.rightSlide,
//                             //   title: 'Error',
//                             //   desc:
//                             //       'The account already exists for that email.',
//                             //   btnCancelOnPress: () {},
//                             //   btnOkOnPress: () {},
//                             // ).show();
//                           } else if (e.code == 'invalid-email') {
//                             errorMsg =
//                                 'The email address is badly formatted. Ex: example@gmail.com';
//                           }
//                           AwesomeDialog(
//                             context: context,
//                             dialogType: DialogType.error,
//                             animType: AnimType.rightSlide,
//                             title: 'Error',
//                             desc: errorMsg,
//                             btnCancelOnPress: () {},
//                             btnOkOnPress: () {},
//                           ).show();
//                         } catch (e) {
//                           print(e);
//                         }
//                       } else {
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.error,
//                           animType: AnimType.rightSlide,
//                           title: 'Error',
//                           desc: 'Password,user name and email are required.',
//                           btnCancelOnPress: () {},
//                           btnOkOnPress: () {},
//                         ).show();
//                       }
//                     },
//                     child: const Text(
//                       'Sign Up',
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
//                   )),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SignInButton(Buttons.google, elevation: 5, onPressed: () {
//                     signInWithGoogle();
//                   }),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   SignInButton(
//                     mini: true,
//                     elevation: 5,
//                     Buttons.apple,
//                     onPressed: () async {
//                       // await signOut();
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (_) => const SigninScreen()));
//                 },
//                 child: const Text.rich(
//                   TextSpan(children: [
//                     TextSpan(
//                       text: "Do You Have An Account? ",
//                     ),
//                     TextSpan(
//                       text: "Sign In",
//                       style: TextStyle(
//                         color: primary,
//                         fontSize: 16,
//                         fontFamily: 'Open Sans',
//                         fontWeight: FontWeight.w600,
//                       ),
//                     )
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad_app/auth/SignInScreen.dart';
import 'package:grad_app/model/cutsom_text_filed.dart';
import 'package:grad_app/model/user.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:grad_app/services/firestore_service.dart';
import '../appLang/locales.dart';
import '../const.dart';
import '../generated/l10n.dart';
import '../screens/HomeScreen.dart';
import '../widgets/loadingCircle.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  bool _isDoctor = false;
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> key = GlobalKey<FormState>();
    final FirestoreService firestore = FirestoreService();
    Future signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

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

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context)!.createNewAccount,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: _isDoctor
                    ? Text(S.of(context)!.yourRoleIsDoctor)
                    : Text(S.of(context)!.registerAsDoctor),
                value: _isDoctor,
                onChanged: (val) {
                  setState(() {
                    _isDoctor = val;
                  });
                },
                secondary: _isDoctor
                    ? Image.asset('images/doctor2.png')
                    : Image.asset('images/boy.png'),
                activeColor: primary,
              ),
              const SizedBox(
                height: 20,
              ),
              CutsomTextFiled(
                obscureText: false,
                isPassword: false,
                hintText: S.of(context)!.enterFullName,
                labelText: S.of(context)!.fullName,
                controller: userName,
                validator: (val) {
                  if (val == '') return S.of(context)!.userNameRequired;
                  return null;
                },
              ),
              CutsomTextFiled(
                obscureText: false,
                isPassword: false,
                hintText: S.of(context)!.enterEmail,
                labelText: S.of(context)!.email,
                controller: email,
                validator: (val) {
                  if (val == '') return S.of(context)!.emailRequired;
                  return null;
                },
              ),
              CutsomTextFiled(
                  isPassword: true,
                  obscureText: true,
                  hintText: S.of(context)!.enterPassword,
                  labelText: S.of(context)!.password,
                  controller: password,
                  validator: (val) {
                    if (val == '') return S.of(context)!.passwordRequired;
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: primary),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          final user = credential.user;
                          if (user != null) {
                            UserModel newUser = UserModel(
                                price: '0',
                                uid: user.uid,
                                username: userName.text,
                                email: email.text,
                                password: password.text,
                                profileImageUrl:
                                    'default_profile_image_url', // Replace with actual profile image URL if available
                                specialty: '',
                                isDoctor: _isDoctor);
                            await firestore.addUser(newUser);
                          }
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification(); //send sendEmailVerification
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: S.of(context)!.verifyAccount,
                            desc: S.of(context)!.verifyAccount,
                            btnOkOnPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SigninScreen()),
                              );
                            },
                          ).show();
                          await Future.delayed(const Duration(seconds: 40));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SigninScreen()),
                          );
                        } on FirebaseAuthException catch (e) {
                          String errorMsg = '';
                          if (e.code == 'weak-password') {
                            errorMsg = S.of(context)!.passwordTooWeak;
                          } else if (e.code == 'email-already-in-use') {
                            errorMsg = S.of(context)!.emailInUse;
                          } else if (e.code == 'invalid-email') {
                            errorMsg = S.of(context)!.invalidEmail;
                          }
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: errorMsg,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: S.of(context)!.passwordUserNameEmailRequired,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    child: Text(
                      S.of(context)!.signUp,
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
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(Buttons.google, elevation: 5, onPressed: () {
                    signInWithGoogle();
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  SignInButton(
                    mini: true,
                    elevation: 5,
                    Buttons.apple,
                    onPressed: () async {
                      // await signOut();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const SigninScreen()));
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: S.of(context)!.haveAccount,
                    ),
                    TextSpan(
                      text: S.of(context)!.signIn,
                      style: const TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
