import 'package:flutter/material.dart';

import '../const.dart';
import '../model/dr card.dart';

class ClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Your Clients',
          style: TextStyle(
            color: primary,
            fontSize: 24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                4,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: 380,
                    height: 160,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.1),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      )
                    ], color: light, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 25),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Transform.scale(scale: 1.3,child: Image.asset('images/Ellipse 18.png',)),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohamed Ahmed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                            Text(
                              'Age: 22',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                            Text(
                              'Gender: Male',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                            Text(
                              "22 Jan 2024  17:30",
                              style: TextStyle(
                                color: gray,
                                fontSize: 14,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
