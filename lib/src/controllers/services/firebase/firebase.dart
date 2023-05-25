import 'dart:convert';

import 'package:class_room/src/controllers/services/firebase/firebase_options.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/models/response_model/teacher_exam_id_response_model.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  final String _teacherString = "teacher";
  final String _examString = "exam";

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> signIn() async {
    try {
      if (kIsWeb) throw Exception("Use this app only on android.");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (kDebugMode) print("FirebaseController.signOut()");
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  Future<void> autoSignIn() async {
    if (kDebugMode) print("FirebaseController.autoSignIn().");
    await signIn();
  }

  Future<void> autoSignOut() async {
    if (kDebugMode) print("FirebaseController.autoSignOut().");
    FirebaseAuth.instance.signOut();
  }

  Future<void> addExam(ExamModel examModel) async {
    try {
      var res = await FirebaseFirestore.instance.collection(_examString).add(examModel.toMap());
      var documentSnapshot = await FirebaseFirestore.instance.collection(_teacherString).doc(FirebaseAuth.instance.currentUser?.uid).get();
      print(documentSnapshot.exists);
      if (!documentSnapshot.exists) {
        await FirebaseFirestore.instance.collection(_teacherString).doc(FirebaseAuth.instance.currentUser?.uid).set({});
      }
      await FirebaseFirestore.instance.collection(_teacherString).doc(FirebaseAuth.instance.currentUser?.uid).update({
        'exam': FieldValue.arrayUnion([res.id])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ExamModel>> getTeacherExamList(bool isTeacher) async {
    // try {
    List<ExamModel> questions = [];
    List<String> examList = [];
    if (isTeacher) {
      var res = await FirebaseFirestore.instance.collection(_teacherString).doc(FirebaseAuth.instance.currentUser?.uid).get();
      TeacherExamIdResponseModel examIdList = TeacherExamIdResponseModel.fromMap(res.data() ?? {});
      examList = examIdList.exam;
    } else {
      var res = await FirebaseFirestore.instance.collection(_examString).get();
      for (var element in res.docs) {
        examList.add(element.id);
      }
    }

    // Split the productIdList into smaller chunks of 10
    List<List<String>> idChunks = [];
    for (var i = 0; i < examList.length; i += 10) {
      var end = (i + 10 < examList.length) ? i + 10 : examList.length;
      idChunks.add(examList.sublist(i, end));
    }

    // Query Firestore for each chunk of product ids
    for (var chunk in idChunks) {
      var query = await FirebaseFirestore.instance.collection(_examString).where(FieldPath.documentId, whereIn: chunk).get();
      var chunkProducts = query.docs.map((doc) {
        Map<String, dynamic> r = doc.data();
        r.addAll({'examId': doc.id});
        return ExamModel.fromMap(doc.data());
      }).toList();
      questions.addAll(chunkProducts);
    }

    return questions;
  }
}
