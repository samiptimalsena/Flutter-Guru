import 'package:flutter/material.dart';

class Mcq extends StatefulWidget {
  @override
  _McqState createState() => _McqState();
}


class _McqState extends State<Mcq> {
Image bImage;

void initState(){
  super.initState();
   bImage=Image.asset("assets/images/background.png");
}
@override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(bImage.image, context);
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        /*decoration: BoxDecoration(
                    image: DecorationImage(image: bimage,
                    fit: BoxFit.cover
                    )*/
                    child: bImage,
      ),
    );
  }
}
