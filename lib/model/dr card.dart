import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grad_app/screens/AppointmentScreen.dart';

import '../const.dart';

class CardWidget extends StatefulWidget {
  String name, specialty, doctorId;
  var imagePath;

  CardWidget(
      {required this.doctorId, required this.name, required this.specialty, imagePath});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    String education = 'MBBS., D.D.,DIH.';
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => DoctorDetailsScreen(
        //             name: 'Dr. John Doe',
        //             stars: 4,
        //             specialization: major,
        //             education: education,
        //             description: description,
        //             image: 'assets/dr.png')));
      },
      child: Container(
        width: 380,
        height: 160,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            // color: Colors.grey.withOpacity(.1),
            color: labny,
            blurRadius: 1,
            offset: const Offset(1, 1),
          )
        ], color: light, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Column(
              children: [
                // if(widget.imagePath.)
                // Image.file(
                //   File(widget.imagePath),
                //   height: 150,
                //   width: 150,
                // ),
                widget.imagePath!=null?
                Image.file(
                  File(widget.imagePath),
                  height: 150,
                  width: 150,
                ):Image.asset('images/doctor.png')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Dr.${widget.name}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    height: 0.05,
                    letterSpacing: 0.44,
                  ),
                ),
                Text(
                  widget.specialty!,
                  style: const TextStyle(
                    color: gray,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    height: 0.05,
                    letterSpacing: 0.44,
                  ),
                ),
                Text(
                  education,
                  style: const TextStyle(
                    color: gray,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    height: 0.05,
                    letterSpacing: 0.44,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AppointmentScreen(
                                  specialty: widget.specialty,
                                      doctorId: widget.doctorId,
                                      doctorName: widget.name,
                                    )));
                      },
                      child: const Text(
                        'Book',
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
                    const SizedBox(
                      width: 30,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: orange,
                          size: 30,
                        ),
                        Text(
                          '5.0',
                          style: TextStyle(
                            color: Colors.black,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
