import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final sidePadding = EdgeInsets.symmetric(horizontal: 20);
  final String rota;

  NavigationDrawerWidget(this.rota);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Color(hexColor('#6FA698')),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: sidePadding,
                children: <Widget>[
                  const SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                      text: 'Recepção',
                      icon: Icons.home,
                      onClicked: rota == 'welcome'
                          ? () {
                              Navigator.of(context).pop();
                            }
                          : () {
                              int count = 0;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 2);
                            }),
                  buildMenuItem(
                      text: 'Pets',
                      icon: Icons.pets_outlined,
                      onClicked: rota == 'feed'
                          ? () {
                              Navigator.of(context).pop();
                            }
                          : () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('feed');
                            }),
                  buildMenuItem(
                      text: 'contate-nos', icon: Icons.mail, onClicked: () {}),
                  /*const SizedBox(
                    height: 16,
                  ),
                  buildMenuItem(
                  text: 'Favoritos',
                  icon: Icons.favorite_border,
                  onClicked: () {
                    Navigator.of(context).pushNamed('register_pet');
                  }),*/
                ],
              ),
            ),
            buildMenuItem(
                text: 'Fazer Logout',
                icon: Icons.logout,
                onClicked: () async {
                  int count = 0;
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                    'Versão: 1.0',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
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

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Color(hexColor('#FFFFFF'));

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
