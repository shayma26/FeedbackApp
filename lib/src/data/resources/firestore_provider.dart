import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class FirestoreProvider {
  Firestore _firestoreIns = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;
  String _loggedInUserUID;

  Future<bool> authenticateUser(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        _loggedInUser = await _auth.currentUser();
        _loggedInUserUID = _loggedInUser.uid;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void signOut() async => await _auth.signOut();

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

  Future getFeedback(String uid) {
    return _firestoreIns
        .collection('feedback')
        .where('recipient', isEqualTo: uid)
        .getDocuments();
  }

  String getLoggedInUserUID() => _loggedInUserUID;

  Future<void> giveFeedback(
      {String recipientName,
      String title,
      String skill,
      String details,
      String action,
      String senderUID}) async {
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
        .where('UID', isEqualTo: senderUID)
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

  Stream<QuerySnapshot> getUsers() =>
      _firestoreIns.collection('users').snapshots();

  Future<void> reset(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
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
      return false;
    }
    return true;
  }
}
