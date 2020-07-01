import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class FirestoreProvider {
  Firestore _firestoreIns = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;

  Future<bool> authenticateUser(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) _loggedInUser = await _auth.currentUser();
    } catch (e) {
      print(e);
      // ShowAlert.warning = e.message;

      return false;
    }
    return true;
  }

  Future<bool> hasFeedback() async {
    final QuerySnapshot result = await _firestoreIns
        .collection("feedback")
        .where('recipient', isEqualTo: _loggedInUser.uid)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0)
      return false;
    else
      return true;
  }

  Future<QuerySnapshot> getFeedback() async {
    return _firestoreIns
        .collection('feedback')
        .where('recipient', isEqualTo: _loggedInUser.uid)
        .getDocuments();
  }

  Future<void> giveFeedback(
      {String recipientName,
      String title,
      String skill,
      String details,
      String action}) async {
    String recipientUID;
    String senderName;
    var searchRecipientUID = await _firestoreIns
        .collection('users')
        .where('complete_name', isEqualTo: recipientName)
        .getDocuments();
    searchRecipientUID.documents.forEach((res) {
      recipientUID = res.data['UID'];
    });

    var searchSenderName = await Firestore.instance
        .collection('users')
        .where('UID', isEqualTo: _loggedInUser.uid)
        .getDocuments();
    searchSenderName.documents.forEach((res) {
      senderName = res.data['complete_name'];
    });

    return _firestoreIns.collection('feedback').add({
      'recipient': recipientUID,
      'skill': skill,
      'title': title,
      'details': details,
      'action': action.toString(),
      'sender': senderName,
    });
  }

  Future<bool> registerUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _loggedInUser = await _auth.currentUser();

      if (newUser != null) {
        _firestoreIns.collection('users').add({
          'complete_name': '$firstName $lastName',
          'UID': _loggedInUser.uid,
        });
      }
    } catch (e) {
      print(e);
      // ShowAlert.warning = e.message;
      return false;
    }
    return true;
  }
}
