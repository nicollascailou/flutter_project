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
      child: ListView(
        padding: sidePadding,
        children: <Widget>[
          const SizedBox(
            height: 48,
          ),
          buildMenuItem(
              text: 'Pets',
              icon: Icons.pets_outlined,
              onClicked: rota == 'home_page_feed'
                  ? () {}
                  : () {
                      Navigator.of(context).pushReplacementNamed('/');
                    }),
          const SizedBox(
            height: 16,
          ),
          buildMenuItem(
              text: 'Favoritos',
              icon: Icons.favorite_border,
              onClicked: () {
                Navigator.of(context).pushNamed('register_pet');
              }),
          const SizedBox(
            height: 16,
          ),
          buildMenuItem(
              text: 'Pets',
              icon: Icons.people,
              onClicked: () {
                Navigator.of(context).pushNamed('register_pet');
              })
        ],
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
