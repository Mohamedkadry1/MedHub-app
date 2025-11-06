import 'package:flutter/material.dart';
import 'package:grad_app/model/user.dart';

import '../const.dart';
import '../model/dr card.dart';

class DoctorsScreen extends StatelessWidget {
  final List<UserModel> doctors;
  DoctorsScreen({required this.doctors});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'All Doctors',
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CardWidget(
                        imagePath: doctor.profileImageUrl,
                        doctorId: doctor.uid,
                        name: doctor.username,
                        specialty: doctor.specialty==''?'None':doctor.specialty,
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
