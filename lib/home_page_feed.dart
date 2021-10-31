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
              'Adote um pet',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(hexColor('#0E5442'))),
            ),
          )),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPost(
                              imagePath: 'assets/gata1.jpg',
                              petName: 'Minina',
                              petRace: 'Vira-Lata',
                              petAge: '2 anos'),
                          buildPost(
                              imagePath: 'assets/rafinha1.jpg',
                              petName: 'Rafinha',
                              petRace: 'Calopsita',
                              petAge: '6 meses'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPost(
                              imagePath: 'assets/gata2.jpg',
                              petName: 'Minina',
                              petRace: 'Vira-Lata',
                              petAge: '2anos'),
                          buildPost(
                              imagePath: 'assets/gata3.jpg',
                              petName: 'Minina',
                              petRace: 'Vira-Lata',
                              petAge: '2 anos'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPost(
                              imagePath: 'assets/rafinha2.jpg',
                              petName: 'Rafinha',
                              petRace: 'Calopsita',
                              petAge: '6 meses'),
                          buildPost(
                              imagePath: 'assets/gata5.jpg',
                              petName: 'Minina',
                              petRace: 'Vira-Lata',
                              petAge: '2 anos'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPost(
                              imagePath: 'assets/rafinha4.jpg',
                              petName: 'Rafinha',
                              petRace: 'Calopsita',
                              petAge: '6 meses'),
                          buildPost(
                              imagePath: 'assets/rafinha3.jpg',
                              petName: 'Rafinha',
                              petRace: 'Calopsita',
                              petAge: '6 meses'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Widget buildPost(
      {required String imagePath,
      required String petName,
      required String petRace,
      required String petAge}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Color(hexColor('#6FA698')),
        child: InkWell(
          splashColor: Color(hexColor('#D3E7E2')),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                )),
            height: 260,
            width: 180,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(hexColor('#6FA698')),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    height: 75,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: petName,
                              style: TextStyle(
                                  color: Color(hexColor('#0E5442')),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n$petRace',
                                    style: TextStyle(
                                      color: Color(hexColor('#0E5442')),
                                      fontWeight: FontWeight.normal,
                                    )),
                                TextSpan(
                                    text: '\n$petAge',
                                    style: TextStyle(
                                      color: Color(hexColor('#0E5442')),
                                      fontWeight: FontWeight.normal,
                                    )),
                                // can add more TextSpans here...
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
    );
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
