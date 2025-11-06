// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get_it/get_it.dart';
// import 'package:grad_app/screens/HomeScreen.dart';
//
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'appLang/app_languages.dart';
// import 'appLang/locales.dart';
// import 'auth/SignInScreen.dart';
// import 'generated/l10n.dart';
// final GetIt getIt = GetIt.instance;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//     apiKey: 'AIzaSyDI8cejkWboll6_ZRdErf_8Ur1Pq7jIjt8',
//     appId: '1:924583426059:android:91bba6a4a998ecf0802f0e',
//     messagingSenderId: '924583426059',
//     projectId: 'grad-app-v1',
//     storageBucket: 'grad-app-v1.appspot.com',
//   ));
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerSingleton<SharedPreferences>(sharedPreferences);
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
//     ],
//     child: const MyApp(),
//   ));
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   static void setLocale(BuildContext context, Locale newLocale) {
//     _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
//     state.setState(() {
//       state._locale = newLocale;
//     });
//   }
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Locale _locale = const Locale('en', '');
//
//   void _changeLocale(Locale newLocale) {
//     setState(() {
//       _locale = newLocale;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }
//
//   Widget build(BuildContext context) {
//     final appLan = Provider.of<AppLanguage>(context);
//     appLan.fetchLocale(context);
//     return MaterialApp(
//       themeMode: ThemeMode.system,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       // theme: ThemeClass
//       //     .lightTheme,
//       // darkTheme: ThemeClass.darkTheme,
//       localizationsDelegates: const [
//         S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: S.delegate.supportedLocales,
//       locale: const Locale('en', 'US'),
//
//       // localizationsDelegates: const [
//       //   AppLocalizations.delegate,
//       //   GlobalMaterialLocalizations.delegate,
//       //   GlobalWidgetsLocalizations.delegate,
//       //   GlobalCupertinoLocalizations.delegate,
//       //   DefaultCupertinoLocalizations.delegate
//       // ],
//       //
//       // supportedLocales: const [
//       //   Locale('en', 'US'),
//       //   Locale('ar', ''),
//       // ],
//       // locale: Locale(appLan.appLang.name),
//
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: (FirebaseAuth.instance.currentUser != null &&
//               FirebaseAuth.instance.currentUser!.emailVerified)
//           ? const Home()
//           : const SigninScreen(),
//       // locale: Locale('en'),
//       // localizationsDelegates: AppLocalizations.localizationsDelegates,
//       // supportedLocales: AppLocalizations.supportedLocales,
//     );
//   }
// }
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// // import 'package:get_it/get_it.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'Theme/theme.dart';
// // import 'appLang/app_languages.dart';
// // import 'appLang/locales.dart';
// // import 'auth/SignInScreen.dart';
// // import 'generated/l10n.dart';
// // import 'screens/HomeScreen.dart';
// //
// // final GetIt getIt = GetIt.instance;
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //       options: const FirebaseOptions(
// //         apiKey: 'AIzaSyDI8cejkWboll6_ZRdErf_8Ur1Pq7jIjt8',
// //         appId: '1:924583426059:android:91bba6a4a998ecf0802f0e',
// //         messagingSenderId: '924583426059',
// //         projectId: 'grad-app-v1',
// //         storageBucket: 'grad-app-v1.appspot.com',
// //       ));
// //
// //   final sharedPreferences = await SharedPreferences.getInstance();
// //   getIt.registerSingleton<SharedPreferences>(sharedPreferences);
// //
// //   runApp(
// //     MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
// //       ],
// //       child: const MyApp(),
// //     ),
// //   );
// // }
// //
// // class MyApp extends StatefulWidget {
// //   const MyApp({super.key});
// //
// //   static void setLocale(BuildContext context, Locale newLocale) {
// //     _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
// //     state.setState(() {
// //       state._locale = newLocale;
// //     });
// //   }
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   Locale _locale = const Locale('en', '');
// //
// //   void _changeLocale(Locale newLocale) {
// //     setState(() {
// //       _locale = newLocale;
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     FirebaseAuth.instance.authStateChanges().listen((User? user) {
// //       if (user == null) {
// //         print('User is currently signed out!');
// //       } else {
// //         print('User is signed in!');
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final appLan = Provider.of<AppLanguage>(context);
// //     appLan.fetchLocale(context);
// //
// //     return MaterialApp(
// //       themeMode: ThemeMode.system,
// //       theme: ThemeData.light(),
// //       darkTheme: ThemeData.dark(),
// //       localizationsDelegates: const [
// //         AppLocalizations.delegate,
// //         GlobalMaterialLocalizations.delegate,
// //         GlobalWidgetsLocalizations.delegate,
// //         GlobalCupertinoLocalizations.delegate,
// //         DefaultCupertinoLocalizations.delegate
// //       ],
// //       supportedLocales: const [
// //         Locale('en', 'US'),
// //         Locale('ar', ''),
// //       ],
// //       locale: Locale(appLan.appLang.name),
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       home: (FirebaseAuth.instance.currentUser != null &&
// //           FirebaseAuth.instance.currentUser!.emailVerified)
// //           ? const Home()
// //           : const SigninScreen(),
// //     );
// //   }
// // }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:grad_app/auth/SignInScreen.dart';
import 'package:grad_app/splash/splashPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'appLang/app_languages.dart';
import 'screens/HomeScreen.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDI8cejkWboll6_ZRdErf_8Ur1Pq7jIjt8',
        appId: '1:924583426059:android:91bba6a4a998ecf0802f0e',
        messagingSenderId: '924583426059',
        projectId: 'grad-app-v1',
        storageBucket: 'grad-app-v1.appspot.com',
      ));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    appLan.fetchLocale(context);
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: appLan.appLocale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Home()
          :  OnBoardingPage(),
    );
  }
}
