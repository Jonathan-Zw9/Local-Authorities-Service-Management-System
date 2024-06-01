import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMethods {
  Future addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .set(userInfoMap);
  }

  Future addServiceDetails(
      Map<String, dynamic> serviceInfoMap, String id) async {
    serviceInfoMap['status'] = 'RECEIVED';
    return FirebaseFirestore.instance
        .collection("serviceRequest")
        .doc(id)
        .set(serviceInfoMap);
  }

  Future<Stream<QuerySnapshot>> getServiceDetails() async {
    return FirebaseFirestore.instance.collection("serviceRequest").snapshots();
  }

  Future updateServiceDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("serviceRequest")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteServiceDetails(String id) async {
    // Get a reference to the document
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("serviceRequest").doc(id);

    // Delete the document
    await docRef.delete();
    if (kDebugMode) {
      print("Document deleted successfully!");
    } // Optional: Add success message
  }
}

class ReportProblems {
  Future addProblemDetails(
      Map<String, dynamic> problemInfoMap, String id) async {
    return FirebaseFirestore.instance
        .collection("problemReports")
        .doc(id)
        .set(problemInfoMap);
  }
}
