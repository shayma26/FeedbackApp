import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<bool> authenticateUser(String email, String password) =>
      _firestoreProvider.authenticateUser(email, password);

  String getLoggedInUserUID() => _firestoreProvider.getLoggedInUserUID();

  void signOut() => _firestoreProvider.signOut();

  Future<bool> hasFeedback() => _firestoreProvider.hasFeedback();

  Future<void> giveFeedback(
    String recipientName,
    String title,
    String skill,
    String action,
    String details,  ) =>
      _firestoreProvider.giveFeedback(
          recipientName: recipientName,
          title: title,
          skill: skill,
          action: action,
          details: details);

  Future<bool> registerUser(
          String firstName, String lastName, String email, String password) =>
      _firestoreProvider.registerUser(firstName, lastName, email, password);

  Future<QuerySnapshot> getFeedback(String uid) {
    return _firestoreProvider.getFeedback(uid);
  }
}
