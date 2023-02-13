import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
    text: const TextSpan(
    style: TextStyle(fontSize: 22),
      children: <TextSpan>[
         TextSpan(text: "Quiz",style: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black54
        )),
         TextSpan(text: "Maker",style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.blue
        ))
      ]
    ),
  );
}

Widget blueButton(BuildContext context , String lable)
{
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18),
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30)
    ),
    child: Text(lable , style: const TextStyle(
        color: Colors.white , fontSize: 16
    ),),
  );
}