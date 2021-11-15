import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool showPassWord = true;
  bool isLogin = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  @override
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
                    color: Color(hexColor('#0E5442'))),
              ),
              trailing: Text(
                'Login',
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
            decoration: BoxDecoration(color: Color(hexColor('#D3E7E2'))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(hexColor('#6FA698')), width: 2.5),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(),
                        labelText: "e-mail",
                        labelStyle: TextStyle(
                            fontSize: 24, color: Color(hexColor('#6FA698')))),
                    onChanged: (text) {
                      setState(() {
                        email = text;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 25,
                              color: Color(hexColor('#6FA698')),
                            ),
                            onPressed: () {
                              setState(() {
                                showPassWord = !showPassWord;
                              });
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(hexColor('#6FA698')),
                                  width: 2.5),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                          labelStyle: TextStyle(
                              fontSize: 24, color: Color(hexColor('#6FA698')))),
                      obscureText: showPassWord,
                      onChanged: (text) {
                        setState(() {
                          password = text;
                        });
                      }),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: isLogin ||
                                  email.isEmpty ||
                                  password.isEmpty
                              ? () {}
                              : () async {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      'welcome', (route) => false);
                                },
                          child: isLogin
                              ? CircularProgressIndicator()
                              : Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Color(hexColor('#FFFFFF'))),
                                ),
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
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(color: Color(hexColor('#FFFFFF'))),
                          ),
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
                    child: Text('ou entre usando redes sociais',
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
