import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'mcq.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Guru()),
        (Route<dynamic> route) => false);
  }

  Widget drawerItem(var icon, String text) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      onTap: () {
        if (text == "Logout") {
          logOut();
        }
      },
      title: Text(
        text,
        style: TextStyle(
            color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget imageHolder(
      String path, String text, double margin, double imgHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => Mcq()));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(margin, 40, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              height: imgHeight,
              width: 50,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage(path),
                fit: BoxFit.fill,
              )),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffoldKey,
        endDrawer: Drawer(
          child: Container(
              color: Colors.green[100],
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/user.png"),
                      ),
                    ),
                  )),
                  drawerItem(Icons.person, "My profile"),
                  drawerItem(Icons.info, "About"),
                  drawerItem(Icons.help_outline, "Help"),
                  drawerItem(Icons.exit_to_app, "Logout")
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(child: Image.asset("assets/images/background.png")),
              Positioned(
                  right: 5,
                  top: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState.openEndDrawer();
                    },
                  )),
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
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Please Select",
                                style: TextStyle(fontSize: 18),
                              ))),
                      Divider(
                        thickness: 2,
                        color: Colors.black12,
                        indent: 50,
                        endIndent: 25,
                      ),
                      Wrap(
                        children: <Widget>[
                          imageHolder(
                              "assets/images/chem.png", "Chemistry", 40, 60),
                          imageHolder(
                              "assets/images/phys.png", "Physics", 80, 60),
                          imageHolder("assets/images/math.png", "Math", 45, 60),
                          imageHolder(
                              "assets/images/bio2.png", "Biology", 85, 60),
                          imageHolder(
                              "assets/images/comp2.png", "Computer", 40, 50),
                          imageHolder("assets/images/quiz3.png", "Quiz", 80, 55)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
