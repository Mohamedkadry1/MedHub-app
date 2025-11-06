import 'package:flutter/material.dart';

import '../const.dart';
import '../screens/HomeScreen.dart';
import '../screens/doctorChatScreen.dart';

class Reservationcard extends StatefulWidget {
  final String doctorId, userId, status, reserveNumber, userName;

  Reservationcard({
    required this.reserveNumber,
    required this.userId,
    required this.doctorId,
    required this.status,
    required this.userName,
  });

  @override
  State<Reservationcard> createState() => _ReservationcardState();
}

class _ReservationcardState extends State<Reservationcard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isDoctor ? widget.userName : 'Dr. ${widget.userName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                height: 0.05,
                letterSpacing: 0.44,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(
                              userId: widget.userId,
                              doctorId: widget.doctorId,
                            )));
              },
              icon: const Icon(
                Icons.chat,
                color: primary,
              ),
            ),
          ],
        ),
        // const Text(
        //   "22 Jan 2024  17:30",
        //   style: TextStyle(
        //     color: gray,
        //     fontSize: 14,
        //     fontFamily: 'Open Sans',
        //     fontWeight: FontWeight.w600,
        //     height: 0.05,
        //     letterSpacing: 0.44,
        //   ),
        // ),
        Text(
          isDoctor
              ? "UserId ${widget.userId.substring(0, 8)}"
              : "DrId ${widget.userId.substring(0, 8)}",
          style: const TextStyle(
            color: gray,
            fontSize: 14,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
        // Text(
        //   "user id ${widget.userId.substring(0, 8)}",
        //   style: const TextStyle(
        //     color: gray,
        //     fontSize: 14,
        //     fontFamily: 'Open Sans',
        //     fontWeight: FontWeight.w600,
        //     height: 0.05,
        //     letterSpacing: 0.44,
        //   ),
        // ),
        Text(
          "#Num:123 ${widget.reserveNumber.substring(0, 8)}",
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
              onPressed: () {},
              child: const Text(
                'Booked',
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
          ],
        ),
      ],
    );
  }
}
