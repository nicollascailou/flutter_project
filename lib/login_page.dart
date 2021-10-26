import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  int hexColor(String color) {
    //adding prefix
    String newColor = '0xff' + color;
    //removing # sign
    newColor = newColor.replaceAll('#', '');
    //converting it to the integer
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(hexColor('#A6CCC2')),
            title: ListTile(
              leading: Text(
                'PetLinkGo',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(hexColor('#D3E7E2'))),
              ),
              trailing: Text(
                'Login',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(hexColor('#D3E7E2'))),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(hexColor('#6FA698')), width: 2.5),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(),
                        labelText: "e-mail",
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
                                color: Color(hexColor('#6FA698')), width: 2.5),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(),
                        labelText: "Senha",
                        labelStyle: TextStyle(
                            fontSize: 24, color: Color(hexColor('#6FA698')))),
                    obscureText: true,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Login'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(hexColor('#6FA698')))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('register');
                          },
                          child: Text('Cadastre-se'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(hexColor('#6FA698')))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Text('ou entre usando redes sociais',
                        style: TextStyle(
                            fontSize: 16, color: Color(hexColor('#6FA698')))),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/facebookbuttonlogo.png',width: 70, height: 70,),
                      SizedBox(width: 50,),
                      Image.asset('assets/gmailbuttonlogo.png',width: 70, height: 70),
                    ],
                  ),

                ],
              ),
            ),
          )),
        ));
  }
}
