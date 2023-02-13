import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseServices {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  // String firebaseId = firebaseUser!.uid.toString;
  late final firebaseId = firebaseUser?.email.toString();
  final String _orderBy = 'dayNum';
  final bool _isDescending = false;

  getQuizuzData(String dayId) async {
    // return FirebaseFirestore.instance.collection("courses").doc(dayId).collection("question").get();//
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(dayId)
        .collection("question")
        .get();
  }

  videoShowData() async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(firebaseId)
        .get();
  }

  getQuizuzData2(String dayId) async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(dayId)
        .collection("question2")
        .get();
  }

  getQuizuzData3(String dayId) async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(dayId)
        .collection("question3")
        .get();
  }

  getCourses() {
    return FirebaseFirestore.instance
        .collection("courses")
        .orderBy(_orderBy, descending: _isDescending)
        .snapshots();
  }

  setTime(String res) {
    return FirebaseFirestore.instance
        .collection("Timestamp")
        .doc(firebaseId)
        .collection("days")
        .doc(res);
  }

  getUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  // setResponse(String day) async {
  //   return FirebaseFirestore.instance
  //       .collection("Responses")
  //       .doc(day)
  //       .collection('Ans')
  //       .doc()
  //       .collection("userAns")
  //       .doc()
  //       ;
  // }
}
