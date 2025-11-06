// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("MedHub"),
    "appleSignIn" : MessageLookupByLibrary.simpleMessage("Sign in with Apple"),
    "createNewAccount" : MessageLookupByLibrary.simpleMessage("Create New Account"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "emailInUse" : MessageLookupByLibrary.simpleMessage("The account already exists for that email."),
    "emailRequired" : MessageLookupByLibrary.simpleMessage("* Email is required."),
    "emailVerificationError" : MessageLookupByLibrary.simpleMessage("Email verification error"),
    "enterEmail" : MessageLookupByLibrary.simpleMessage("Enter Your Email"),
    "enterFullName" : MessageLookupByLibrary.simpleMessage("Enter Your Full Name"),
    "enterPassword" : MessageLookupByLibrary.simpleMessage("Enter Your Password"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "fullName" : MessageLookupByLibrary.simpleMessage("Full Name"),
    "googleSignIn" : MessageLookupByLibrary.simpleMessage("Sign in with Google"),
    "haveAccount" : MessageLookupByLibrary.simpleMessage("Do You Have An Account? "),
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("The email address is badly formatted. Ex: example@gmail.com"),
    "noAccount" : MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRequired" : MessageLookupByLibrary.simpleMessage("* Password is required."),
    "passwordTooWeak" : MessageLookupByLibrary.simpleMessage("The password provided is too weak."),
    "passwordUserNameEmailRequired" : MessageLookupByLibrary.simpleMessage("Password, username, and email are required."),
    "registerAsDoctor" : MessageLookupByLibrary.simpleMessage("Register as a doctor"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInButton" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "signUp" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "termsAndPrivacy" : MessageLookupByLibrary.simpleMessage("By signing in, you are agreeing to our Terms and Privacy Policy."),
    "userNameRequired" : MessageLookupByLibrary.simpleMessage("* UserName is required."),
    "verifyAccount" : MessageLookupByLibrary.simpleMessage("Verify your account."),
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Welcome"),
    "yourRoleIsDoctor" : MessageLookupByLibrary.simpleMessage("Your role is a doctor")
  };
}
