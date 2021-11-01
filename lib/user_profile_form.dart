import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({Key? key}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  File? image;
  List healthlist = [
    "Excelente",
    "Bom Estado",
    "Vacinação pendente",
    "Precisa de muitos cuidados"
  ];
  String? valueChoose;

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
      body: ListView(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: new Container(
                height: MediaQuery.of(context).size.height - 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(children: [
                    // Spacer(),
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
                                            image: AssetImage(image!.path)))),
                                    child: Column(),
                                  )),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Material(
                                  color: Color(hexColor('#D3E7E2')),
                                  child: InkWell(
                                      splashColor: Color(hexColor('#D3E7E2')),
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
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
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
                              fontSize: 24, color: Color(hexColor('#6FA698')))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(hexColor('#6FA698')),
                                  width: 2.5),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'DD/MM/AAAA',
                          labelText: "Data de nascimento",
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
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(hexColor('#6FA698')),
                                  width: 2.5),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'DDD-XXXXX-XXXX / Número para contato',
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
                    TextField(
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

                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'welcome', (route) => false);
                      },
                      child: Text('Salvar'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(hexColor('#6FA698')))),
                    )
                  ]),
                )),
          ),
        ),
      ]),
    );
  }
}
