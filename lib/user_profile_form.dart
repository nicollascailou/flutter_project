import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/user_bloc.dart';
import 'models/UserModel.dart';

class UserProfileForm extends StatefulWidget {
  final String rota;

  UserProfileForm(
    this.rota,
  );

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  File? image;
  String? valueChoose;
  User? auth = FirebaseAuth.instance.currentUser;
  String name = '';
  String phoneNumber = '';
  String addres = '';

  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime? birthDate; // instance of DateTime
  String birthDateInString = '';

  bool isLogin = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addresController = TextEditingController();
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(hexColor('#A6CCC2')),
          title: ListTile(
            trailing: Text(
              'Suas informações',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(hexColor('#0E5442'))),
            ),
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: new Container(
                    height: MediaQuery.of(context).size.height - 80,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: Color(hexColor('#D3E7E2'))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Container(),
                          image != null
                              ? Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: (BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      image!.path)))),
                                          child: Column(),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            pickImageGalery();
                                          },
                                          child: Text('Galeria'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(hexColor(
                                                          '#6FA698')))),
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
                                                      Color(hexColor(
                                                          '#6FA698')))),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Material(
                                        color: Color(hexColor('#D3E7E2')),
                                        child: InkWell(
                                            splashColor:
                                                Color(hexColor('#D3E7E2')),
                                            child: Opacity(
                                              opacity: 0.7,
                                              child: Image.asset(
                                                'assets/profilePicPetlink.png',
                                                height: 130,
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            pickImageGalery();
                                          },
                                          child: Text('Galeria'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(hexColor(
                                                          '#6FA698')))),
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
                                                      Color(hexColor(
                                                          '#6FA698')))),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
                                hintText: 'Nome Completo',
                                labelText: "Nome",
                                labelStyle: TextStyle(
                                    fontSize: 24,
                                    color: Color(hexColor('#6FA698')))),
                          ),
                          SizedBox(
                            height: 16,
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
                          TextFormField(
                            controller: _addresController,
                            validator: (String? text) {
                              if (text != null && text.isEmpty) {
                                return 'Preencha o campo acima!';
                              }
                              return null;
                            },
                            onChanged: (text) {
                              setState(() {
                                addres = text;
                              });
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(hexColor('#6FA698')),
                                        width: 2.5),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Cidade-UF/CEP',
                                labelText: "Endereço",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontSize: 24,
                                  color: Color(hexColor('#6FA698')),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              Text(
                                'Data de nascimento',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(hexColor('#6FA698'))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Material(
                                      color: Color(hexColor('#6FA698')),
                                      child: InkWell(
                                          onTap: () async {
                                            final datePick =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        new DateTime.now(),
                                                    firstDate:
                                                        new DateTime(1900),
                                                    lastDate:
                                                        new DateTime(2100));
                                            if (datePick != null &&
                                                datePick != birthDate) {
                                              setState(() {
                                                birthDate = datePick;
                                                isDateSelected = true;
                                                birthDateInString =
                                                    "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                                              });
                                            }
                                          },
                                          splashColor:
                                              Color(hexColor('#D3E7E2')),
                                          child: Opacity(
                                              opacity: 0.7,
                                              child: Icon(
                                                Icons.event_outlined,
                                                size: 30,
                                                color:
                                                    Color(hexColor('#FFFFFF')),
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  (birthDateInString == null)
                                      ? Text(
                                          'DD/MM/AAAA',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color(hexColor('#6FA698'))),
                                        )
                                      : Text('$birthDateInString'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLogin
                                  ? CircularProgressIndicator(
                                      color: Color(hexColor('#6FA698')),
                                    )
                                  : Icon(
                                      Icons.done_all_outlined,
                                      color: Color(hexColor('#6FA698')),
                                      size: 30,
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: name.isEmpty ||
                                        addres.isEmpty ||
                                        phoneNumber.isEmpty ||
                                        birthDateInString.isEmpty
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          return null;
                                        }
                                      }
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              isLogin = true;
                                            });
                                            UserModel user = UserModel(
                                                name,
                                                phoneNumber,
                                                birthDateInString,
                                                addres,
                                                auth!.uid);
                                            if (widget.rota == 'register') {
                                              await BlocProvider.of<UserBloc>(
                                                      context)
                                                  .addUser(user);
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      'welcome',
                                                      (route) => false);
                                            } else {
                                              BlocProvider.of<UserBloc>(context)
                                                  .edit(user);
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      'welcome',
                                                      (route) => false);
                                            }
                                            setState(() {
                                              isLogin = false;
                                            });
                                          } catch (e) {
                                            print(e);
                                            setState(() {
                                              isLogin = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Erro ao registrar dados',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                child: Text('Salvar'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(hexColor('#6FA698')))),
                              ),
                            ],
                          )
                        ]),
                      ),
                    )),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
