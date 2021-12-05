import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/pet.dart';

class PetBloc extends Cubit<List<Pet>?> {
  PetBloc() : super(null) {
    FirebaseFirestore.instance.collection('pets').snapshots().listen((event) {
      List<Pet> petList = event.docs.map((e) {
        dynamic json = e.data();
        json['petId'] = e.id;
        return Pet.fromJson(json);
      }).toList();
      emit(petList);
    });
  }

  addPet(Pet pet) async {
    await FirebaseFirestore.instance
        .collection('pets')
        .doc()
        .set(pet.toJson());
  }

  void edit(Pet pet) async {
    await FirebaseFirestore.instance
        .collection('pets')
        .doc(pet.petId)
        .set(pet.toJson());
  }
}
