import 'package:flutter/material.dart';
import 'package:flutter_project/widget/navigarion_drawer.dart';

class home_page_feed extends StatefulWidget {
  const home_page_feed({Key? key}) : super(key: key);

  @override
  _home_page_feedState createState() => _home_page_feedState();
}

class _home_page_feedState extends State<home_page_feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildNavigateButton(),
      drawer: NavigationDrawerWidget('feed'),
      appBar: AppBar(
          backgroundColor: Color(hexColor('#A6CCC2')),
          title: ListTile(
            leading: Text(
              'PetLinkGo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          )),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
          child: Column(
            children: [
              /*IconButton(onPressed: (){
                Navigator.of(context).pushNamed('register_pet');
              }, icon: Icon(
                Icons.pets_outlined,
              ),
              color: Colors.blue,)*/
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigateButton() => FloatingActionButton(
        backgroundColor: Color(hexColor('#A6CCC2')),
        onPressed: () {
          Navigator.of(context).pushNamed('register_pet');
        },
        child: Image.asset(
          'assets/registerPet.png',
          height: 40,
          width: 40,
        ),
      );
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
