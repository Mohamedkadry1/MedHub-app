import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:grad_app/model/reservation.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'package:grad_app/screens/payment.dart';
import 'package:grad_app/services/firestore_service.dart';
import '../const.dart';
import '../model/user.dart';
import 'doctorChatScreen.dart';

class AppointmentScreen extends StatefulWidget {
  late String doctorId;
  String doctorName;
  String specialty;
  AppointmentScreen(
      {required this.specialty,
      required this.doctorName,
      required this.doctorId});
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _reservationDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loremIpsum =
        'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis.';
    List<String> workingHours = [
      "10 AM",
      "11 AM",
      "12 PM",
      "1 PM",
      "2 PM",
      "3 PM",
      "4 PM",
      "5 PM",
      "6 PM",
      "7 PM",
      "8 PM",
      "9 PM",
      "10 PM",
    ];
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = currentDate;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Appointment',
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 380,
                height: 160,
                decoration: BoxDecoration(
                    color: light, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/doctor.png',
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              ' Dr. ${widget.doctorName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'info',
                                  desc:
                                      'You cannot chat with the doctor before booking.',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                ).show();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => ChatScreen(userId:currentId , doctorId:widget.doctorId,)));
                              },
                              icon: const Icon(
                                Icons.chat,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.specialty,
                          style: TextStyle(
                            color: primary,
                            fontSize: 18,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            height: 0.05,
                            letterSpacing: 0.44,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Payment',
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w700,
                                height: 0.05,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '\$ 120.00',
                              style: TextStyle(
                                color: primary,
                                fontSize: 20,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                height: 0.05,
                                letterSpacing: 0.44,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                  letterSpacing: 0.44,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  loremIpsum,
                  maxLines: 40,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: gray),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Available Time Slot',
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.05,
                    letterSpacing: -0.44,
                  ),
                ),
              ),
              SizedBox(
                height: 55,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workingHours.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        child: Text(
                          workingHours[index],
                          style: const TextStyle(
                            color: black,
                            fontSize: 18,
                            fontFamily: 'Open Sans',
                            height: 0.05,
                          ),
                        ),
                      );
                    }),
              ),
              EasyDateTimeLine(
                headerProps: const EasyHeaderProps(
                  monthPickerType: MonthPickerType.switcher,
                  monthStyle: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    height: 0.05,
                  ),
                  dateFormatter: DateFormatter.fullDateDMY(),
                ),
                initialDate: DateTime.now(),
                onDateChange: (_selectedDate) {
                  print(_selectedDate);
                  selectedDate = _selectedDate;
                },
                activeColor: primary,
                dayProps: const EasyDayProps(
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    borderColor: gray,
                    height: 80,
                    width: 55),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () async {
                    if (currentDate.isAfter(selectedDate) &&
                        currentDate.toString().substring(0, 11) !=
                            selectedDate.toString().substring(0, 11)) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        descTextStyle: const TextStyle(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Open Sans',
                          letterSpacing: 1.1,
                        ),
                        animType: AnimType.rightSlide,
                        title: 'Invalid date',
                        titleTextStyle: const TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          letterSpacing: 1.1,
                        ),
                        desc: '',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    } else {
                      // DateTime reservationDate =
                      //     DateTime.parse(_reservationDateController.text);

                      print(currentId);
                      try {
                        ReservationModel reserve = ReservationModel(
                            reservationId: '',
                            doctorId: widget.doctorId,
                            userId: currentId,
                            status: 'Paid');
                        await firestoreService.addReservation(reserve: reserve);
                        // await firestoreService.addReservation(
                        //     userId: currentId, doctorId: widget.doctorId);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PaymentScreen()));
                      } catch (e) {
                        print('Failed to make reservation: $e');
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PaymentScreen()));
                    }
                  },
                  child: const Text(
                    'Book an Appointment',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans',
                      height: 0.05,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
