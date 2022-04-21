
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add new note"),
      ),
      body: SingleChildScrollView(
        child: Container(child:Form(

          child: Column(

            children: [

                 Container(
                   height: 60,
                   child: TextFormField(
                    maxLength: 40,
                    maxLines: 1,
                    decoration: InputDecoration(
                       labelText: "Title..",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.dehaze_sharp)
                    ),
                ),
                 ),
                TextFormField(
                  maxLength: 300,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "what happened bro...?",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.subtitles)
                  ),
                ),

              Container(
                margin: EdgeInsets.only(top: 200),
                  height: 50,
                  width: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(24)))

                    ) ,
                    onPressed: () {  }, child: Text("save"),),
                ),

            ],
          ),),
        ),
      ),
    );
  }
}
