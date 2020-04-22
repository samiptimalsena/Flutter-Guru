import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final qList;
  final scr;

  Result(this.qList, this.scr);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var questionList;
  int score;
  @override
  void initState() {
    super.initState();
    questionList = widget.qList;
    score = widget.scr == null ? 0 : widget.scr;
  }

  Widget answer(int n) {
    return Container(
      margin: const EdgeInsets.only(bottom:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text((n+1).toString()+" "+ questionList[n].que),
          RichText(text: TextSpan(
            children:[
              TextSpan(text:"ans:  ",style:TextStyle(color: Colors.green,fontSize:15,fontWeight:FontWeight.w500)),
              TextSpan(text: questionList[n].correctAnswer,style: TextStyle(color: Colors.black))
            ]
          ),),
        ],
      ),
    );
  }

  Widget answerList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 15,
        itemBuilder: (context, index) {
          return answer(index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15,23,15,0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text("Answers",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
          Container(
            
            margin: const EdgeInsets.only(top:10),
            child: answerList()
            )
        ],
      ),
    );
  }
}
