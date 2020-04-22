import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Question{
  String type;
  String que;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctAnswer;

  Question({this.type,this.que,this.option1,this.option2,this.option3,this.option4,this.correctAnswer});

  factory Question.fromJson(Map<String,dynamic> json){
   return Question(
     type: json["type"],
     que: json["question"],
     option1: json["option1"],
     option2: json["option2"],
     option3: json["option3"],
     option4: json["option4"],
     correctAnswer: json["correctAnswer"]
   );
  }
}

Future<List<Question>> getQuestion(String type)async{
    var response=await http.get(DotEnv().env['API']+type);
    var getData=json.decode(response.body) as List;
    List<Question> questionList=getData.map((data)=>Question.fromJson(data)).toList();
    return questionList;
}