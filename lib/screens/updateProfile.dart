import 'package:flutter/material.dart';
import 'package:grad_app/screens/HomeScreen.dart';

import '../const.dart';
import '../model/cutsom_text_filed.dart';
import '../services/firestore_service.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  TextEditingController userName = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CutsomTextFiled(
              obscureText: false,
              isPassword: false,
              hintText: 'Enter Your Full Name',
              labelText: "Full Name",
              controller: userName,
              validator: (val) {
                if (val == '') return '* UserName is required.';
                return null;
              },
            ),
            isDoctor
                ? CutsomTextFiled(
                    obscureText: false,
                    isPassword: false,
                    hintText: 'Enter Price',
                    labelText: 'Price',
                    controller: priceController,
                    validator: (val) {
                      if (val == '') return '* Price is required.';
                      return null;
                    },
                  )
                : Text(''),
            isDoctor
                ? CutsomTextFiled(
                    obscureText: false,
                    isPassword: false,
                    hintText: 'Enter Specialty',
                    labelText: 'Specialty',
                    controller: specialtyController,
                    validator: (val) {
                      if (val == '') return '* Specialty is required.';
                      return null;
                    },
                  )
                : Text(''),
            SizedBox(height: 16.0),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: primary,
                ),
                onPressed: () async {
                  FirestoreService firestoreService = FirestoreService();
                  if (isDoctor) {
                    await firestoreService.updateUserInfo(
                        userId: currentId,
                        name: userName.text,
                        specialty: specialtyController.text);
                  } else {
                    await firestoreService.updateUserInfo(
                        userId: currentId, name: userName.text);
                  }
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Home()));
                },
                child: Text('Update',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
