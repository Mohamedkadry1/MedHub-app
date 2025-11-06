import 'package:flutter/material.dart';
import 'package:grad_app/model/reservation.dart';
import 'package:grad_app/model/reservationCard.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'package:grad_app/services/firestore_service.dart';

import '../const.dart';

class ReservationScreen extends StatefulWidget {
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<ReservationModel> reservations = [];
  Map<String, String> doctorNames = {};
  FirestoreService firestore = FirestoreService();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchReservationsForUser();
  }

  Future<void> _fetchReservationsForUser() async {
    List<ReservationModel> _fetchedReservations =
        await firestore.getReservationsForUser(currentId);
    if (_fetchedReservations.isNotEmpty) {
      List<String> doctorIds =
          _fetchedReservations.map((r) => r.doctorId).toList();
      Map<String, String> _fetchedDoctorNames =
          await firestore.getDoctorNames(doctorIds);
      setState(() {
        reservations = _fetchedReservations;
        doctorNames = _fetchedDoctorNames;
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
          'Your Reservations',
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
          ? Center(
              child: CircularProgressIndicator(
              color: primary,
            ))
          : reservations.length == 0
              ? const Center(
                  child: Text('Not found any doctors',
                      style: TextStyle(color: Colors.black, fontSize: 20)))
              : SingleChildScrollView(
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
                              String doctorId = reservations[index].doctorId;
                              String userName =
                                  doctorNames[doctorId] ?? 'Unknown Doctor';
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
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
                                            'images/doctor.png',
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
                ),
    );
  }
}
