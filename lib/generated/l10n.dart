// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S? current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current!;
    });
  } 

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MedHub`
  String get appTitle {
    return Intl.message(
      'MedHub',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get appleSignIn {
    return Intl.message(
      'Sign in with Apple',
      name: 'appleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailInUse',
      desc: '',
      args: [],
    );
  }

  /// `* Email is required.`
  String get emailRequired {
    return Intl.message(
      '* Email is required.',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email verification error`
  String get emailVerificationError {
    return Intl.message(
      'Email verification error',
      name: 'emailVerificationError',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enterEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Full Name`
  String get enterFullName {
    return Intl.message(
      'Enter Your Full Name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get enterPassword {
    return Intl.message(
      'Enter Your Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get googleSignIn {
    return Intl.message(
      'Sign in with Google',
      name: 'googleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Do You Have An Account? `
  String get haveAccount {
    return Intl.message(
      'Do You Have An Account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `The email address is badly formatted. Ex: example@gmail.com`
  String get invalidEmail {
    return Intl.message(
      'The email address is badly formatted. Ex: example@gmail.com',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `* Password is required.`
  String get passwordRequired {
    return Intl.message(
      '* Password is required.',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get passwordTooWeak {
    return Intl.message(
      'The password provided is too weak.',
      name: 'passwordTooWeak',
      desc: '',
      args: [],
    );
  }

  /// `Password, username, and email are required.`
  String get passwordUserNameEmailRequired {
    return Intl.message(
      'Password, username, and email are required.',
      name: 'passwordUserNameEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Register as a doctor`
  String get registerAsDoctor {
    return Intl.message(
      'Register as a doctor',
      name: 'registerAsDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message(
      'Sign In',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `By signing in, you are agreeing to our Terms and Privacy Policy.`
  String get termsAndPrivacy {
    return Intl.message(
      'By signing in, you are agreeing to our Terms and Privacy Policy.',
      name: 'termsAndPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `* UserName is required.`
  String get userNameRequired {
    return Intl.message(
      '* UserName is required.',
      name: 'userNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account.`
  String get verifyAccount {
    return Intl.message(
      'Verify your account.',
      name: 'verifyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcomeMessage {
    return Intl.message(
      'Welcome',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your role is a doctor`
  String get yourRoleIsDoctor {
    return Intl.message(
      'Your role is a doctor',
      name: 'yourRoleIsDoctor',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}