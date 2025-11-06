import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_app/const.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/SignUpScreen.dart';
import '../screens/HomeScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => SignupScreen()),
    );
  }
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'MedHub',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 150),
            ),
          ],

          totalRepeatCount: 4,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        )
        // const Text(
        //   'MedHub',
        //   style: TextStyle(
        //     color: black,
        //     fontSize: 24,
        //     fontFamily: 'Open Sans',
        //     fontWeight: FontWeight.bold,
        //     height: 0.05,
        //     letterSpacing: 0.44,
        //   ),
        // ),
      ),      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        infiniteAutoScroll: true,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 0),
              child: _buildImage('images/bot.png', 100),
            ),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(
                  color: black, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignupScreen()));
            },
          ),
        ),
        pages: [
          PageViewModel(
            title: "Medical Image Analysis",
            body:
                "Upload images like CT, MRI, or X-ray and get detailed descriptions.",
            image: Center(
              child: SvgPicture.asset(
                'images/undraw_upload_image_re_svxx.svg',
                height: 200.0, // Set the desired height
                width: 200.0, // Set the desired width
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Ask Medical Questions",
            body:
                "Consult our chatbot for medical advice and answers to your questions.",
            image: Center(
              child: SvgPicture.asset(
                'images/undraw_chat_re_re1u.svg',
                height: 200.0, // Set the desired height
                width: 200.0, // Set the desired width
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Book Appointments",
            body: "Easily make reservations with our experienced doctors.",
            image: Center(
              child: SvgPicture.asset(
                'images/undraw_doctor_kw-5-l.svg',
                height: 200.0, // Set the desired height
                width: 200.0, // Set the desired width
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Download Report as PDF",
            body: "Generate and download detailed medical reports in PDF format.",
            image: Center(
              child: SvgPicture.asset(
                'images/undraw_next_tasks_re_5eyy.svg',
                height: 200.0, // Set the desired height
                width: 200.0, // Set the desired width
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Create an Account",
            body: "Sign up to access all features and manage your health data.",
            image: Center(
              child: SvgPicture.asset(
                'images/undraw_mobile_login_re_9ntv.svg',
                height: 200.0, // Set the desired height
                width: 200.0, // Set the desired width
              ),
            ),
            footer: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignupScreen()));

                  introKey.currentState?.animateScroll(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Sign Up Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 6,
              imageFlex: 6,
              safeArea: 80,
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SignupScreen()),
          );
        }, // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip',
            style: TextStyle(color: white, fontWeight: FontWeight.w600)),
        next: const Icon(
          Icons.arrow_forward,
          color: white,
        ),
        done: const Text('Done',
            style: TextStyle(color: white, fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
