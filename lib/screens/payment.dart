import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:grad_app/screens/hs.dart';
import '../const.dart';
import 'HomeScreen.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          foregroundColor: white,
          backgroundColor: primary,
          shadowColor: white,
          centerTitle: true,
          title: Text(
            'Payment',
            style: TextStyle(
              color: white,
              fontSize: 24,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              height: 0.05,
              letterSpacing: 0.44,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 150,
              child: Center(
                child: Text(
                  '\$120.00',
                  style: TextStyle(
                    color: white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Open Sans',
                    height: 0.05,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Doctor Chanaling Payment Method',
                        style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Open Sans',
                          height: 0.05,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Card Payment',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Open Sans',
                                  height: 0.05,
                                  letterSpacing: 1.1,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Cash Payment',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Open Sans',
                                  height: 0.05,
                                  letterSpacing: 1.1,
                                ),
                              )),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        'Card Number',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          height: 0.05,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          '1234 8896 1145 0896',
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            height: 0.05,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Expiry Date',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans',
                            height: 0.05,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          'CVV',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans',
                            height: 0.05,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 150,
                          child: Center(
                            child: Text(
                              '10/02/2022',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Open Sans',
                                height: 0.05,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 150,
                          child: Center(
                            child: Text(
                              '204',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Open Sans',
                                height: 0.05,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                        height: 0.05,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Ravishka Sathsara',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            height: 0.05,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              descTextStyle: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans',
                                letterSpacing: 1.1,
                              ),
                              animType: AnimType.rightSlide,
                              title: 'Congratulations',
                              titleTextStyle: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Open Sans',
                                height: 0.05,
                                letterSpacing: 1.1,
                              ),
                              desc: 'Your Payment Is Successfully.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => Home()));
                              },

                            ).show();
                            // Future.delayed(Duration(seconds: 5),() =>    Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(builder: (_) => Home())));
                          },
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
                              color: white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open Sans',
                              height: 0.05,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
