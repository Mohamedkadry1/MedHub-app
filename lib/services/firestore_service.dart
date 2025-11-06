
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/chatbotMessage.dart';
import '../model/doctor.dart';
import '../model/reservation.dart';
import '../model/user.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Error adding user: $e');
      throw Exception('Failed to add user');
    }
  }

  Future<void> deleteUser({required String userId}) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user document from Firestore: $e');
      throw Exception('Failed to delete user document from Firestore');
    }
  }

  Future<void> updateUserInfo({required String userId, String? name,String? specialty,String? price,String?imagUrl}) async {
    try {
      Map<String, dynamic> updateData = {};
      if (name != null) updateData['name'] = name;
      if (name != null) updateData['specialty'] = specialty;
      if(imagUrl!=null)updateData['profileImageUrl']=imagUrl;
      if(imagUrl!=null)updateData['price']=price;
      await _db.collection('users').doc(userId).update(updateData);
    } catch (e) {
      print('Error updating user info: $e');
      throw Exception('Failed to update user info');
    }
  }

  // Function to get user information by user ID
  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    }
  }

  Future<Map<String, String>> getDoctorNames(List<String> doctorIds) async {
    try {
      Map<String, String> doctorNames = {};
      for (String doctorId in doctorIds) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _db.collection('users').doc(doctorId).get();
        if (snapshot.exists) {
          doctorNames[doctorId] = snapshot.data()?['name'] ?? 'Unknown Doctor';
        } else {
          doctorNames[doctorId] = 'Unknown Doctor';
        }
      }
      return doctorNames;
    } catch (e) {
      print('Error getting doctor names: $e');
      return {};
    }
  }

  Future<String?> getDoctorNameById(String doctorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('doctors').doc(doctorId).get();
      if (snapshot.exists) {
        return snapshot.data()?[
            'name']; // Assuming 'name' is a field in your 'doctors' collection
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error getting doctor name: $e');
      return null;
    }
  }

  Future<List<ReservationModel>> getReservationsForDoctor(
      String doctorId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .doc(doctorId)
          .collection('reservations')
          .get();

      List<ReservationModel> reservations = [];
      for (var doc in querySnapshot.docs) {
        reservations.add(ReservationModel.fromMap(doc.data(), doc.id));
      }
      return reservations;
    } catch (e) {
      print('Error fetching reservations: $e');
      return [];
    }
  }

  Future<Map<String, String>> getUserNames(List<String> userIds) async {
    try {
      Map<String, String> userNames = {};
      for (String userId in userIds) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _db.collection('users').doc(userId).get();
        if (snapshot.exists) {
          userNames[userId] = snapshot.data()?['name'] ?? 'Unknown User';
        } else {
          userNames[userId] = 'Unknown User';
        }
      }
      return userNames;
    } catch (e) {
      print('Error fetching user names: $e');
      return {};
    }
  }

  Future<List<UserModel>> getAllDoctors() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .where('isDoctor', isEqualTo: true)
          .get();

      List<UserModel> doctors = [];

      querySnapshot.docs.forEach((doc) {
        doctors.add(UserModel.fromMap(doc.data(), doc.id));
      });

      return doctors;
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

  // Function to get current user's information (name, email, type)
  Future<Map<String, dynamic>?> getCurrentUserInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _db.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          return {
            'name': snapshot.data()!['name'],
            'email': snapshot.data()!['email'],
            'isDoctor': snapshot.data()!['isDoctor'],
          };
        } else {
          print('User document does not exist');
          return null;
        }
      } else {
        print('No user is currently signed in');
        return null;
      }
    } catch (e) {
      print('Error fetching current user info: $e');
      return null;
    }
  }

  // Function to get all messages from the chatBot sub-collection
  Future<List<Map<String, dynamic>>> getAllChatBotMessages(
      String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection('users').doc(userId).collection('chatBot').get();

      List<Map<String, dynamic>> messages = [];

      querySnapshot.docs.forEach((doc) {
        messages.add(doc.data());
      });

      return messages;
    } catch (e) {
      print('Error fetching chatBot messages: $e');
      return [];
    }
  }

  // Function to get all messages from the chats sub-collection
  Future<List<Map<String, dynamic>>> getAllChatsMessages(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection('users').doc(userId).collection('chats').get();

      List<Map<String, dynamic>> messages = [];

      querySnapshot.docs.forEach((doc) {
        messages.add(doc.data());
      });

      return messages;
    } catch (e) {
      print('Error fetching chats messages: $e');
      return [];
    }
  }

  // Function to get all reservations for a user
  Future<List<Map<String, dynamic>>> getAllReservations(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('reservations')
          .get();

      List<Map<String, dynamic>> reservations = [];

      querySnapshot.docs.forEach((doc) {
        reservations.add(doc.data());
      });

      return reservations;
    } catch (e) {
      print('Error fetching reservations: $e');
      return [];
    }
  }


  Future<void> addReservation({required ReservationModel reserve}) async {
    try {
      // Generate a unique reservation ID
      String reservationId = _db
          .collection('users')
          .doc(reserve.userId)
          .collection('reservations')
          .doc()
          .id;

      // Create a new reservation document
      await _db
          .collection('users')
          .doc(reserve.userId)
          .collection('reservations')
          .doc(reservationId)
          .set(reserve.toMap());

      // Optionally, update the doctor's reservations sub-collection
      await _db
          .collection('users')
          .doc(reserve.doctorId)
          .collection('reservations')
          .doc(reservationId)
          .set(reserve.toMap());
    } catch (e) {
      print('Error adding reservation: $e');
      throw Exception('Failed to add reservation');
    }
  }

  Future<List<ReservationModel>> getReservationsForUser(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('reservations')
          .get();

      List<ReservationModel> reservations = [];

      querySnapshot.docs.forEach((doc) {
        reservations.add(ReservationModel.fromMap(doc.data(), doc.id));
      });

      return reservations;
    } catch (e) {
      print('Error fetching reservations: $e');
      return [];
    }
  }

  Future<List<ChatbotModel>> getChatbotMessages(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('chatbot')
          .orderBy('timestamp', descending: true)
          .get();

      List<ChatbotModel> messages = [];
      for (var doc in querySnapshot.docs) {
        messages.add(ChatbotModel.fromMap(doc.data(), doc.id));
      }
      return messages;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  Stream<List<ChatbotModel>> getChatbotMessagesStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('chatbot')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatbotModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<DocumentReference> addChatbotMessage(
      String userId, ChatbotModel message) async {
    try {
      DocumentReference docRef = await _db
          .collection('users')
          .doc(userId)
          .collection('chatbot')
          .add(message.toMap());

      return docRef;
    } catch (e) {
      print("Error adding chatbot message: $e");
      throw e; // Propagate the error upwards for handling
    }
  }

  Future<List<ChatDoctorModel>> getChatMessages(
      String userId, String doctorId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(doctorId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      List<ChatDoctorModel> messages = [];
      for (var doc in querySnapshot.docs) {
        messages.add(ChatDoctorModel.fromMap(doc.data(), doc.id));
      }
      return messages;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  Stream<List<ChatDoctorModel>> getChatMessagesStream(
      String userId, String doctorId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(doctorId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatDoctorModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addChatMessage(
      String userId, String doctorId, ChatDoctorModel message) async {
    try {
      DocumentReference userChatDoc =
          _db.collection('users').doc(userId).collection('chats').doc(doctorId);

      DocumentReference doctorChatDoc =
          _db.collection('users').doc(doctorId).collection('chats').doc(userId);

      await _db.runTransaction((transaction) async {
        transaction.set(
            userChatDoc.collection('messages').doc(), message.toMap());
        transaction.set(
            doctorChatDoc.collection('messages').doc(), message.toMap());
      });
    } catch (e) {
      print("Error adding chat message: $e");
      throw e;
    }
  }
}
