import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();
  TextEditingController userName = new TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();

  bool _obscureTextC = true;
  bool _obscureText = true;
  bool _isLoading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  register(String email, String password, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {"email": email, "password": password, "name": name};
    var response = await http
        .post("https://auth1234.herokuapp.com/auth/register", body: data);
    var getData = json.decode(response.body);
    if (getData["token"] != null) {
      sharedPreferences.setString("token", getData['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    }
  }

  Widget inputText(String text, var handler, var pIcon) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: TextFormField(
        obscureText: text == "Password"
            ? _obscureText
            : text == "Confirm Password" ? _obscureTextC : false,
        controller: handler,
        validator: (String value) {
          if (text == "Email") {
            return  !value.contains("@") || !value.endsWith(".com")
                ? "Please enter valid email address"
                : null;
          } else if (text == "Username") {
            return value.isEmpty ? "Please enter some text" : null;
          } else {
            return value.length < 6 ? "Password too short" : null;
          }
        },
        decoration: InputDecoration(
            suffixIcon: _obscureText && text == "Password"
                ? IconButton(
                    icon: Icon(Icons.visibility, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    })
                : _obscureTextC && text == "Confirm Password"
                    ? IconButton(
                        icon: Icon(Icons.visibility, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obscureTextC = !_obscureTextC;
                          });
                        },
                      )
                    : !_obscureText && text == "Password"
                        ? IconButton(
                            icon:
                                Icon(Icons.visibility_off, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            })
                        : !_obscureTextC && text == "Confirm Password"
                            ? IconButton(
                                icon: Icon(Icons.visibility_off,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextC = !_obscureTextC;
                                  });
                                },
                              )
                            : null,
            prefixIcon: Icon(
              pIcon,
              color: Colors.green,
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.green),
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.green))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                     height: MediaQuery.of(context).size.height,
                color: Colors.grey[200],
                child: ListView(
                  children:[
                    Container(
                      height:(MediaQuery.of(context).size.height)/2.6,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(40),
                          bottomRight: const Radius.circular(40))
                      ),
                    )
                  ]
                )
                  ),
                  Center(child:
                    Container(
                      margin: EdgeInsets.only(top:70),
                      height:150,
                      child: Column(children: <Widget>[
                        Image.asset("assets/images/headIcon2.png",height: 90,),
                        Container(
                          margin: const EdgeInsets.only(top:10),
                          child: Text("GURU",style: TextStyle(fontSize: 30,color: Colors.blue[900]),))
                      ],)
                    )
                  ),
                  Center(
                    child: Container(
                      height: 450,
                      width: 290,
                      margin: new EdgeInsets.only(top: ht / 3.3),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            color:Colors.grey,
                            offset: Offset(0.0,3.0),
                            blurRadius: 7.0
                          )],
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
                                "REGISTER",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Form(
                            key: _registerFormKey,
                            child: Container(
                                margin: const EdgeInsets.only(top: 35),
                                child: Column(
                                  children: <Widget>[
                                    inputText(
                                        "Username", userName, Icons.person),
                                    inputText("Email", email, Icons.email),
                                    inputText("Password", password, Icons.lock),
                                    inputText("Confirm Password", cPassword,
                                        Icons.lock),
                                  ],
                                )),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(160, 20, 0, 0),
                                child: MaterialButton(
                                    color: Colors.green[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(100),
                                            topRight: const Radius.circular(5),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(5))),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(color: Colors.grey[200]),
                                    ),
                                    onPressed: () {
                                      if (password.text.isNotEmpty &&
                                          cPassword.text.isNotEmpty &&
                                          password.text != cPassword.text) {
                                        _scaffoldKey.currentState
                                            .showSnackBar(new SnackBar(
                                          content: new Text(
                                              "Password didn't matched"),
                                          backgroundColor: Colors.red,
                                        ));
                                        password.text = "";
                                        cPassword.text = "";
                                      } else if (_registerFormKey.currentState
                                          .validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        register(email.text, password.text,
                                            userName.text);
                                      }
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
