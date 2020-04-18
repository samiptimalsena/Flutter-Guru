import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'register.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Guru",
      initialRoute: "/",
      routes: {
        "/": (context) => Guru(),
        "/register": (context) => Register()
      }));
}

class Guru extends StatefulWidget {
  @override
  _GuruState createState() => _GuruState();
}

class _GuruState extends State<Guru> {
  bool _isLoading = false;
  var _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  signIn(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {"email": email, "password": password};
    var response = await http.post("https://auth1234.herokuapp.com/auth/login",
        body: data);
    var getData = json.decode(response.body);
    if (getData["token"] != null) {
      sharedPreferences.setString("token", getData['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget inputText(String text, var handler) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
          validator: (String value) {
            if (text == "Email") {
              return !value.contains("@") || !value.endsWith(".com")
                  ? "Please enter a valid email address"
                  : null;
            } else {
              return value.isEmpty ? "Please enter Password" : null;
            }
          },
          controller: handler,
          keyboardType:
              text == "Email" ? TextInputType.emailAddress : TextInputType.text,
          obscureText: text == "Password" ? _obscureText : false,
          decoration: InputDecoration(
              prefixIcon: Icon(
                text == "Email" ? Icons.email : Icons.lock,
                color: Colors.green,
              ),
              suffixIcon: _obscureText && text == "Password"
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : !_obscureText && text == "Password"
                      ? IconButton(
                          icon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : null,
              labelText: text,
              labelStyle: TextStyle(color: Colors.green),
              focusedBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Scaffold(
        //  resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset("assets/images/background.png"),
                    ),
                    Center(
                      child: Container(
                        height: 370,
                        width: 290,
                        margin: new EdgeInsets.only(top: ht / 3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(100),
                                topRight: const Radius.circular(5),
                                bottomLeft: const Radius.circular(10),
                                bottomRight: const Radius.circular(5))),
                        child: ListView(
                          children: <Widget>[
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 18),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Form(
                              key: _loginFormKey,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: <Widget>[
                                      inputText("Email", email),
                                      inputText("Password", password),
                                    ],
                                  )),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 65),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    MaterialButton(
                                      child: Text("Don't have an account?",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10)),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/register");
                                      },
                                    ),
                                    MaterialButton(
                                        color: Colors.green[400],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(100),
                                                topRight:
                                                    const Radius.circular(5),
                                                bottomLeft:
                                                    const Radius.circular(10),
                                                bottomRight:
                                                    const Radius.circular(5))),
                                        child: Text(
                                          " Login",
                                          style: TextStyle(
                                              color: Colors.grey[200]),
                                        ),
                                        onPressed: () {
                                          if (_loginFormKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            signIn(email.text, password.text);
                                          }
                                        })
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
