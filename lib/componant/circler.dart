import 'package:flutter/material.dart';
Showleading(context){
return showDialog(context: context, builder: (context){
  return AlertDialog(
    title: Text("pleas wait"),
    content: Container(
      height: 40,
      child: CircularProgressIndicator(),
    ),
  );
});
}