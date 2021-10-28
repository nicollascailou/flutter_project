import 'package:flutter/material.dart';
import 'package:flutter_project/widget/navigarion_drawer.dart';

class welcome_page extends StatefulWidget {
  const welcome_page({Key? key}) : super(key: key);

  @override
  _welcome_pageState createState() => _welcome_pageState();
}

class _welcome_pageState extends State<welcome_page> {
  int hexColor(String color) {
    //adding prefix
    String newColor = '0xff' + color;
    //removing # sign
    newColor = newColor.replaceAll('#', '');
    //converting it to the integer
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /*Fluttertoast.showToast(
          msg: '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );*/
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
          drawer: NavigationDrawerWidget('welcome'),
          appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Color(hexColor('#A6CCC2')),
              title: ListTile(
                leading: Text(
                  'PetLinkGo',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(hexColor('#0E5442'))),
                ),
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                child: Container(
              height: MediaQuery.of(context).size.height - 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Oi,\n{UserName}',
                            style: TextStyle(
                                color: Color(hexColor('#0E5442')),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\nO que deseja fazer hoje?',
                                  style: TextStyle(
                                    color: Color(hexColor('#0E5442')),
                                    fontWeight: FontWeight.normal,
                                  )),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Material(
                              color: Color(hexColor('#D3E7E2')),
                              child: InkWell(
                                  onTap: () {},
                                  splashColor: Color(hexColor('#D3E7E2')),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            colorFilter: new ColorFilter.mode(
                                                Colors.black.withOpacity(0.1),
                                                BlendMode.dstATop),
                                            image: new ExactAssetImage(
                                                'assets/profile.png'))),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButton(
                                  labelPrefix: 'Procurar',
                                  labelSufix: 'Pets',
                                  labelIcon: Icon(Icons.pets),
                                  navegation: () {
                                    Navigator.of(context).pushNamed('feed');
                                  }),
                              buildButton(
                                  labelPrefix: 'Seu',
                                  labelSufix: 'Perfil',
                                  labelIcon: Icon(Icons.person_rounded),
                                  navegation: () {
                                    Navigator.of(context).pushNamed('');
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButton(
                                  labelPrefix: 'Fazer',
                                  labelSufix: 'LogOut',
                                  labelIcon: Icon(Icons.logout_rounded),
                                  navegation: () {
                                    Navigator.of(context).pop();
                                  }),
                              buildButton(
                                  labelPrefix: 'Entre em',
                                  labelSufix: 'Contato',
                                  labelIcon: Icon(Icons.email_rounded),
                                  navegation: () {
                                    Navigator.of(context).pushNamed('');
                                  }),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          )),
    );
  }

  Widget buildButton({
    required String labelPrefix,
    required String labelSufix,
    required Icon labelIcon,
    required void Function() navegation,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Color(hexColor('#6FA698')),
        child: InkWell(
          splashColor: Color(hexColor('#D3E7E2')).withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: 130,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    labelIcon.icon,
                    color: Color(hexColor('#D3E7E2')),
                    size: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$labelPrefix\n$labelSufix',
                    style: TextStyle(
                      color: Color(hexColor('#D3E7E2')),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          onTap: navegation,
        ),
      ),
    );
  }
}
