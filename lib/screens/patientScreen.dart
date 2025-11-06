import 'package:flutter/material.dart';
import 'package:grad_app/model/reservation.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'package:grad_app/services/firestore_service.dart';

import '../const.dart';
import '../model/reservationCard.dart';

class DoctorReservationsScreen extends StatefulWidget {
  @override
  _DoctorReservationsScreenState createState() =>
      _DoctorReservationsScreenState();
}

class _DoctorReservationsScreenState extends State<DoctorReservationsScreen> {
  List<ReservationModel> reservations = [];
  Map<String, String> userNames = {};
  FirestoreService firestore = FirestoreService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReservationsForDoctor();
  }

  Future<void> _fetchReservationsForDoctor() async {
    List<ReservationModel> _fetchedReservations =
        await firestore.getReservationsForDoctor(currentId);
    if (_fetchedReservations.isNotEmpty) {
      List<String> userIds = _fetchedReservations.map((r) => r.userId).toList();
      Map<String, String> _fetchedUserNames =
          await firestore.getUserNames(userIds);
      setState(() {
        reservations = _fetchedReservations;
        userNames = _fetchedUserNames;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Your Patients',
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          :reservations.length==0?Center(child: const Text('Not found any patients',style: TextStyle(color: Colors.black,fontSize: 20))): SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        itemCount: reservations.length,
                        itemBuilder: (context, index) {
                          String userId = reservations[index].userId;
                          String userName = userNames[userId] ?? 'Unknown User';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: 380,
                              height: 160,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.1),
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                color: light,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'images/Ellipse 18.png',
                                        height: 150,
                                        width: 150,
                                      ),
                                    ],
                                  ),
                                  Reservationcard(
                                    userName: userName,
                                    reserveNumber:
                                    reservations[index].reservationId,
                                    userId: reservations[index].userId,
                                    doctorId: reservations[index].doctorId,
                                    status: reservations[index].status,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
    );
  }
}
