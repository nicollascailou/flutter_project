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
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(hexColor('#6FA698')),
                                  width: 2.5),
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
                      validator: (String? text) {
                        if (text != null && text.isEmpty ||
                            text != null && !text.contains('@')) {
                          return 'E-mail inválido!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passController,
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
                      },
                      validator: (String? text) {
                        if (text != null && text.isEmpty ||
                            text != null && text.length < 8) {
                          return 'Senha inválida! no minimo 8 caracteres';
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              initLogin();
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
                              style:
                                  TextStyle(color: Color(hexColor('#FFFFFF'))),
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
            ),
          )),
        ));
  }

  void initLogin() {
    isLogin || email.isEmpty || password.isEmpty
        ? () {
            if (_formKey.currentState!.validate()) {
              return null;
            }
          }()
        : () async {
            if (_formKey.currentState!.validate()) {
              try {
                setState(() {
                  isLogin = true;
                });
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);
                setState(() {
                  isLogin = false;
                });
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('welcome', (route) => false);
              } catch (eventError) {
                print(eventError);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email ou senha Invalidos',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
                setState(() {
                  isLogin = false;
                });
              }
            }
          }();
  }
}
