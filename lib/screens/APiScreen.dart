import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'package:grad_app/screens/chat%20bot%20screen.dart';

import '../const.dart';
import '../model/cutsom_text_filed.dart';
import '../screens/neww.dart';

class FadyScreen extends StatefulWidget {
  const FadyScreen({Key? key}) : super(key: key);

  @override
  _FadyScreenState createState() => _FadyScreenState();
}

class _FadyScreenState extends State<FadyScreen> {
  TextEditingController api = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
        foregroundColor: white,
        backgroundColor: primary,
        shadowColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'API Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CutsomTextFiled(
                obscureText: false,
                isPassword: false,
                labelText: "API",
                hintText: 'Enter Your api',
                controller: api,
                validator: (val) {
                  if (val == '') return '* API is required.';
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: primary),
                onPressed: () {
                  if (api.text.isNotEmpty) {
                    print(api.text);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChatbotScreen(
                    //               fadyApi: api.text,
                    //               title: 'ChatBot',
                    //             )));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewChatbotPage(userId: currentId, title: 'Chatbot', url: api.text,)));
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'API is required.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  }
                },
                child: const Text(
                  'Send',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
