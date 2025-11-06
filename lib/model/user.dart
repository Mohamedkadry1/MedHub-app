// user_model.dart
class UserModel {
  final String uid;
  final String username;
  final String email;
  final String password;
  final String profileImageUrl;
  final String specialty;
  final bool isDoctor;
  final String price;
  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      required this.profileImageUrl,
      required this.specialty,
      required this.isDoctor,
      required this.price});

  // Factory constructor to create a UserModel from a map (e.g., Firestore document)
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      price: data['price'] ?? '',
      uid: documentId,
      username: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      specialty: data['specialty'] ?? 'None',
      isDoctor: data['isDoctor'] ?? false,
    );
  }

  // Method to convert UserModel to a map (e.g., for Firestore document)
  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'name': username,
      'email': email,
      'password': password,
      'profileImageUrl': profileImageUrl,
      'specialty': specialty,
      'isDoctor': isDoctor,
    };
  }
}
