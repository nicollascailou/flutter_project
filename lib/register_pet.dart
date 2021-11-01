import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPet extends StatefulWidget {
  RegisterPet({Key? key}) : super(key: key);

  @override
  _RegisterPetState createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
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
                            hintText: 'Nome do pet',
                            labelText: "Nome",
                            labelStyle: TextStyle(
                                fontSize: 24,
                                color: Color(hexColor('#6FA698')))),
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
                        onPressed: () {},
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
}
