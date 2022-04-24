
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../componant/circler.dart';
import '../mainscrean/homepage.dart';
class editnote extends StatefulWidget {
  const  editnote({Key? key, this.note,this.noteid}) : super(key: key);
  final noteid;
  final note;
  @override
  State< editnote> createState() => _addnoteState();
}

class _addnoteState extends State< editnote> {


  var notesTitle,notedata;
  GlobalKey<FormState>formstate=new GlobalKey<FormState>();


  updateData()async{
    var formdata=formstate.currentState;
    if(formdata!.validate()) {
      Showleading(context);
      formdata.save();
      var user = FirebaseAuth.instance.currentUser!;
      var resp=await FirebaseFirestore.instance.collection("notes")
          .doc(widget.noteid).update(
          {
            "titel": notesTitle,
            "note": notedata,
            "userId":user.uid,
          });
      SetOptions(merge: true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return homepage();
      }));
      return resp;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add new note"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:Form(
            key: formstate,

            child: Center(
              child: Column(

                children: [

                  Container(
                    height: 90,
                    child: TextFormField(
                      initialValue: widget.note['titel'],
                      onSaved: (val){
                        notesTitle=val;
                      },
                      validator: (val){
                        if(val!.isEmpty){
                          return "titel can't be Empty";
                        }
                      },
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
                    initialValue: widget.note['note'],
                    onSaved: (val){
                      notedata=val;
                    },
                    validator: (val){
                      if(val!.isEmpty){
                        return "your note cant be empty";
                      }
                    },
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

                      onPressed: () async{
                        await updateData();
                      }, child: Text("update"),),
                  ),

                ],
              ),
            ),),
        ),
      ),
    );
  }
}
