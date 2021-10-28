import 'package:flutter/material.dart';

class register_user_page extends StatefulWidget {
  const register_user_page({Key? key}) : super(key: key);

  @override
  _register_user_pageState createState() => _register_user_pageState();
}

class _register_user_pageState extends State<register_user_page> {
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(hexColor('#A6CCC2')),
            title: ListTile(
              trailing: Text(
                'Criar uma conta',
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
                        labelText: "Confirme a Senha",
                        labelStyle: TextStyle(
                            fontSize: 24, color: Color(hexColor('#6FA698')))),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Criar Conta'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(hexColor('#6FA698')))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text('ou crie usando redes sociais',
                        style: TextStyle(
                            fontSize: 16, color: Color(hexColor('#6FA698')))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/facebookbuttonlogo.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Image.asset('assets/gmailbuttonlogo.png',
                          width: 70, height: 70),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
