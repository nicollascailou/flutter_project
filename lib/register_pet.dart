import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/pet_bloc.dart';
import 'package:flutter_project/models/pet.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPet extends StatefulWidget {
  RegisterPet({Key? key}) : super(key: key);

  @override
  _RegisterPetState createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
  final _storage = FirebaseStorage.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String name = '';
  String description = '';
  String phoneNumber = '';
  String age = '';
  String race = '';
  String downloadUrl = '';
  File? image;
  bool isRegister = false;

  List healthlist = [
    "Excelente",
    "Bom Estado",
    "Vacinação pendente",
    "Precisa de muitos cuidados"
  ];
  String? valueChoose;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _raceController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();

  Future pickImageGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  int hexColor(String color) {
    //adding prefix
    String newColor = '0xff' + color;
    //removing # sign
    newColor = newColor.replaceAll('#', '');
    //converting it to the integer
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(hexColor('#A6CCC2')),
          title: ListTile(
            trailing: Text(
              'Dispor pet para adoção',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(hexColor('#0E5442'))),
            ),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                  decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(children: [
                      // Spacer(),
                      Container(),
                      image != null
                          ? Column(
                              children: [
                                Container(
                                  child: Image.file(File(image!.path)),
                                  height: 300,
                                  width: double.infinity,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        pickImageGalery();
                                      },
                                      child: Text('Galeria'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(hexColor('#6FA698')))),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        pickImageCamera();
                                      },
                                      child: Text('Camera'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(hexColor('#6FA698')))),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/fotoDoPet.png'),
                                  height: 300,
                                  width: double.infinity,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        pickImageGalery();
                                      },
                                      child: Text('Galeria'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(hexColor('#6FA698')))),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        pickImageCamera();
                                      },
                                      child: Text('Camera'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(hexColor('#6FA698')))),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _nameController,
                              validator: (String? text) {
                                if (text != null && text.isEmpty) {
                                  return 'Preencha o campo acima!';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  name = text;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(hexColor('#6FA698')),
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Nome do pet',
                                  labelText: "Nome",
                                  labelStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(hexColor('#6FA698')))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _raceController,
                              validator: (String? text) {
                                if (text != null && text.isEmpty) {
                                  return 'Preencha o campo acima!';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  race = text;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(hexColor('#6FA698')),
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Raça do pet',
                                  labelText: "Raça",
                                  labelStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(hexColor('#6FA698')))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _ageController,
                              validator: (String? text) {
                                if (text != null && text.isEmpty) {
                                  return 'Preencha o campo acima!';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  age = text;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(hexColor('#6FA698')),
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Idade do pet',
                                  labelText: "Idade",
                                  labelStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(hexColor('#6FA698')))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              validator: (String? text) {
                                if (text != null && text.isEmpty) {
                                  return 'Preencha o campo acima!';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  description = text;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(hexColor('#6FA698')),
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  hintText:
                                      'Saúde do pet, comportamento, aspectos...',
                                  labelText: "Descrição",
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    fontSize: 24,
                                    color: Color(hexColor('#6FA698')),
                                  )),
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              validator: (String? text) {
                                if (text != null && text.isEmpty) {
                                  return 'Preencha o campo acima!';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  phoneNumber = text;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(hexColor('#6FA698')),
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  hintText:
                                      'DDD-XXXXX-XXXX / Número para contato',
                                  labelText: "Celular",
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    fontSize: 24,
                                    color: Color(hexColor('#6FA698')),
                                  )),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(hexColor('#D3E7E2')),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(hexColor('#6FA698'))),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Color(hexColor('#D3E7E2')),
                            value: valueChoose,
                            hint: Text("Saúde"),
                            items: healthlist
                                .map((e) => buildMenuItem(e))
                                .toList(),
                            onChanged: (value) => setState(() {
                              valueChoose = value;
                            }),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          registerPet();
                        },
                        child: Text('Salvar'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color(hexColor('#6FA698')))),
                      )
                    ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void registerPet() {
    name.isEmpty ||
            race.isEmpty ||
            age.isEmpty ||
            description.isEmpty ||
            phoneNumber.isEmpty ||
            valueChoose!.isEmpty
        ? () {
            if (_formKey.currentState!.validate()) {
              return null;
            }
          }()
        : () async {
            if (_formKey.currentState!.validate()) {
              try {
                setState(() {
                  isRegister = true;
                });

                if (image != null) {
                  try {
                    var snapshot =
                    await _storage
                        .ref()
                        .child('petImage/$uid$name')
                        .putFile(image!);

                    var downloadUrl1 = await snapshot.ref.getDownloadURL();
                    setState(() {
                      downloadUrl = downloadUrl1;
                    });
                  } on FirebaseException catch (e) {
                    print('ERRO IMAGE: $e');
                  }
                }
                Pet pet = Pet(name, race, age, uid, description, valueChoose!,
                    downloadUrl);

                await BlocProvider.of<PetBloc>(context).addPet(pet);

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('welcome', (route) => false);
                setState(() {
                  isRegister = false;
                });
              } catch (e) {
                print(e);
                setState(() {
                  isRegister = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Erro ao registrar dados',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            }
          }();
  }
}
