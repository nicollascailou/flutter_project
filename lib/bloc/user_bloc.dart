import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/UserModel.dart';

class UserBloc extends Cubit<UserModel?> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  UserBloc() : super(null){displayName();}

  Future displayName() async {
    DocumentSnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

  }

  addUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toJson());
  }

  void edit(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toJson());
  }
}
