import 'package:flutter/material.dart';

import '../const.dart';

class ChatWithDr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          'Message',
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                'Active Now',
                style: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: primary,
                            radius: 30,
                            child: Image.asset('images/doctor.png')),
                      );
                    }),
              ),
              SizedBox(height: 15,),
              Text(
                'Messages',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                  letterSpacing: 0.44,
                ),
              ),
              SizedBox(height: 20,),
              ...List.generate(5, (index) =>Container(
                height:90,
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: primary,
                      radius: 30,child: Transform.scale(scale: 1.4,child: Image.asset('images/doctor.png'))),
                  title: Text(
                    'Dr. John Doe',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.05,
                      letterSpacing: 0.44,
                    ),
                  ),
                  subtitle: Text(
                    'Hi Dr,How are you?',
                    style: TextStyle(
                      color: gray,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.05,
                      letterSpacing: 0.44,
                    ),
                  ),
                  trailing: Text("12:30 AM"),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
