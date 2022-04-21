import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/auth/login.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List notes=[{"title":"1hhh",'note':"hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"},
    {"title":"2gggg",
      "note":"ggggggggggggggggggggggggggggggggggg"},
{"title":"3aaa",
  "note":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}];
  getUser(){
    var user= FirebaseAuth.instance.currentUser;
    print(user!.email);
  }
  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){return login();}));
          }, icon:Icon(Icons.exit_to_app))
        ],
        title: Text("notes",style: TextStyle(color: Colors.white),),
      ),
floatingActionButton: FloatingActionButton(onPressed: () {  },
  child: Icon(Icons.add),
),
body:Container(
  child: ListView.builder(
    itemCount: notes.length,
    itemBuilder: (context,i) {
      return Dismissible(key: Key("$i"),
          child:listnotes(notes:notes[i]));
    },
  ),
),
    );
  }
}
class listnotes extends StatelessWidget{
  final notes;
  listnotes({this.notes});
  @override
  Widget build(BuildContext context) {
    return Card(
      child:ListTile(
        title: Text("${notes['title']}"),
        subtitle: Text("${notes['note']}"),

        trailing: IconButton(
          icon:Icon(Icons.edit),
          onPressed: () {  },

        )

      ) ,

    );
  }

}