import 'package:flutter/material.dart';
import '../utils/getQuestion.dart';
import 'result.dart';
import 'home.dart';

class Mcq extends StatefulWidget {
  final sub;
  Mcq(this.sub);
  @override
  _McqState createState() => _McqState();
}

class _McqState extends State<Mcq> {
  var subject;
  var questionList;
  int qCount = 0;
  int score = 0;
  String answer;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool answered = false;
  bool completed = false;

  checkAnswer() {
    if (completed) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    }else{
    if (qCount < 15) {
      if (answer.toLowerCase() ==
          questionList[qCount].correctAnswer.toLowerCase()) {
        setState(() {
          score++;
          qCount++;
          check1 = check2 = check3 = check4 = false;
        });
      } else {
        setState(() {
          qCount++;
          check1 = check2 = check3 = check4 = false;
        });
      }
    }
    if (qCount == 15) {
      if (answer.toLowerCase() ==
          questionList[qCount].correctAnswer.toLowerCase()) {
        setState(() {
          qCount=14;
          score++;
          completed = true;
        });
      }
      setState(() {
        qCount=14;
        completed = true;
      });
    }}
  }

  toggleCheckBox(int n, String ans) {
    setState(() {
      switch (n) {
        case 1:
          if (check1 == false) {
            check1 = true;
            check2 = false;
            check3 = false;
            check4 = false;
            answer = ans;
          } else {
            check1 = false;
          }
          break;
        case 2:
          if (check2 == false) {
            check2 = true;
            check1 = false;
            check3 = false;
            check4 = false;
            answer = ans;
          } else {
            check2 = false;
          }
          break;
        case 3:
          if (check3 == false) {
            check3 = true;
            check2 = false;
            check1 = false;
            check4 = false;
            answer = ans;
          } else {
            check3 = false;
          }
          break;
        default:
          if (check4 == false) {
            check4 = true;
            check2 = false;
            check3 = false;
            check1 = false;
            answer = ans;
          } else {
            check4 = false;
          }
      }
      if (check1 || check2 || check3 || check4) {
        answered = true;
      } else {
        answered = false;
      }
    });
  }

  Widget optionHolder(String option, int n, bool check) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: check,
          onChanged: (value) {
            toggleCheckBox(n, option);
          },
          activeColor: Colors.green,
        ),
        Flexible(
          child: Text(option),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    subject = widget.sub;
    getQuestion(subject).then((result) {
      setState(() {
        result.shuffle();
        questionList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey[200],
              child: ListView(children: [
                Container(
                  height: (MediaQuery.of(context).size.height) / 2.6,
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(40),
                          bottomRight: const Radius.circular(40))),
                )
              ])),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 70),
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/headIcon2.png",
                        height: 90,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            "GURU",
                            style: TextStyle(
                                fontSize: 30, color: Colors.blue[900],fontWeight: FontWeight.w500),
                          ))
                    ],
                  ))),
          Center(
            child: Container(
              height: 450,
              width: 290,
              margin: new EdgeInsets.only(top: ht / 3.3),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0),
                        blurRadius: 7.0)
                  ],
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(100),
                      topRight: const Radius.circular(5),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(5))),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 15, top: 35),
                          child: Text(
                            (qCount+1 ).toString() + " /15",
                            style: TextStyle(fontSize: 18),
                          ))),
                  Divider(
                    thickness: 2,
                    color: Colors.black12,
                    indent: 50,
                    endIndent: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                        height: 270,
                        width: 230,
                        margin: new EdgeInsets.only(top: 35),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: Colors.green[400]),
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(70),
                                topRight: const Radius.circular(5),
                                bottomLeft: const Radius.circular(10),
                                bottomRight: const Radius.circular(5))),
                        child: questionList == null
                            ? Center(child: CircularProgressIndicator())
                            : completed
                                ? Result(questionList, score)
                                : Container(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(top: 20),
                                      height: 270,
                                      width: 190,
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              questionList[qCount].que,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                            color: Colors.black12,
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                optionHolder(
                                                    questionList[qCount]
                                                        .option1,
                                                    1,
                                                    check1),
                                                optionHolder(
                                                    questionList[qCount]
                                                        .option2,
                                                    2,
                                                    check2),
                                                optionHolder(
                                                    questionList[qCount]
                                                        .option3,
                                                    3,
                                                    check3),
                                                optionHolder(
                                                    questionList[qCount]
                                                        .option4,
                                                    4,
                                                    check4),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                  ),
                  Row(
                    children: <Widget>[
                      Spacer(flex: 1),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "   Score :  ",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                          TextSpan(
                              text: score.toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 20))
                        ]),
                      ),
                      Spacer(flex: 1),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward,
                              color: answered ? Colors.green : Colors.grey),
                          onPressed: () {
                            if (answered) {
                              checkAnswer();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
