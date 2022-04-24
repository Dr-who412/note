import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/mainscrean/notesDetals.dart';
import '../adth/addnote.dart';
import '../adth/editnote.dart';
import '../auth/login.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  CollectionReference notesRef=FirebaseFirestore.instance.collection("notes");
deleteData(val)async{
  notesRef.doc("${val}").delete().then((value) {
    return AwesomeDialog(context:context,title: "deleted",dialogType: DialogType.SUCCES,autoHide: Duration(seconds: 2,))..show();
  }).catchError((e){return AwesomeDialog(context:context,title: "cant delete it something wroing",dialogType: DialogType.WARNING,autoHide: Duration(seconds: 1,))..show();});
}
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
floatingActionButton: FloatingActionButton(onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return addnote();
  }));

},
  child: Icon(Icons.add),
),
body:Container(
  child:FutureBuilder(

    future: notesRef.where("userId",isEqualTo: FirebaseAuth.instance.currentUser?.uid).get(),

    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
     if(snapshot.hasData){

       return ListView.builder(
         itemCount: snapshot.data?.docs.length,
         itemBuilder: (BuildContext context, int index) {
           return Dismissible(key: UniqueKey(),

           onDismissed: (dirction)async{
             await notesRef.doc(snapshot.data!.docs[index].id).delete().then((value) {
               return AwesomeDialog(context:context,title: "deleted",dialogType: DialogType.SUCCES,autoHide: Duration(seconds: 2,))..show();
             }).catchError((e){return AwesomeDialog(context:context,title: "cant delete it something wroing",dialogType: DialogType.WARNING,
                 autoHide: Duration(seconds: 2,))..show();});
           },
           child: listnotes(notes: snapshot.data?.docs[index],noteid: snapshot.data?.docs[index].id,));
         },
       );
     }
      return Center(child: CircularProgressIndicator(),);
      }
  ,),
),
    );
  }
}
class listnotes extends StatelessWidget{
  final noteid;
  final notes;
  listnotes({this.notes, this.noteid});
  @override
  Widget build(BuildContext context) {
    return Card(
      child:ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return noteDetals(note: notes,);
          }));
        },
        title: Text("${notes['titel']}"),
        subtitle: Text("${notes['note']}",
        maxLines: 1,
        ),


        trailing: IconButton(
          icon:Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return editnote(note:notes,noteid:noteid,);
            }));

          },

        )

      ) ,

    );
  }

}