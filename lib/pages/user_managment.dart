import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  Future<QuerySnapshot<Map<String, dynamic>>> retrieveCollection(
      String collectionName) async {
    try {
      return await FirebaseFirestore.instance.collection(collectionName).get();
    } catch (e) {
      print('Error retrieving collection: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }
}
