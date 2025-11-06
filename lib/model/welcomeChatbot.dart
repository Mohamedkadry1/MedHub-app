import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../screens/APiScreen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 5,
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const FadyScreen()));
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
              builder: (context, animatorState, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FadyScreen()));
                  },
                  child: Text(
                    'Let\'s Start',
                    style: TextStyle(
                        color: white, fontSize: animatorState.value * 1),
                  ))),
        ),
      ),
    ]);
  }
}
