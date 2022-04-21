import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:note_app/auth/login.dart';
import 'package:note_app/componant/circler.dart';
import 'package:note_app/mainscrean/homepage.dart';
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var username,password,email;
  GlobalKey<FormState>formState=new GlobalKey<FormState>();
  signUp()async{
    var formdate=formState.currentState;
    if (formdate!.validate()){

      formdate.save();
      try {Showleading(context);
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      Navigator.of(context).pop();
        if(!credential.user!.emailVerified){
          var user=FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
          Navigator.of(context).pop();
          AwesomeDialog(context: context,title: "Verify",dialogType: DialogType.QUESTION,
              body: Text("please,check your account inbox"))..show();
        }else{
          if(credential != null) {Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context){return homepage();}));}else{print("sign up faild");}
        }
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(context: context,title: "Error",body: Text("password is to weak"))..show();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(context: context,
              title: "Error",
              body: Column(
                children: [
                  Text('The account already exists for that email, go to login'),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return login();}));
                  }, child: Text("GO Login.."),),
                ],
              ))..show();

          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }else{
      print("not valid");
    }
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 33, 31, 0.9725490196078431),
        title: Text("sign up"),

      ),*/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children:  [
            SizedBox(height: 70,),
            Center(child:CircleAvatar(
              radius: 40,
              child:Image.asset("images/Luffysicon.png"),)),
            SizedBox(height: 25,),
            Container(padding:EdgeInsets.all(12),
              child: Form(
                  key: formState,
                  child: Column(children: [
                TextFormField(
                  validator:(val){
                    if(val!.length <2){
                      return "username cant be less than 3 letter";
                    }
                    if(val.length >100){
                      return "username cant be larger than  letter";
                    }
                    return null;
                  },
                  onSaved: (val){
                    username=val;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.blue,),
                      hintText: "username",
                      border: OutlineInputBorder(
                        borderSide:BorderSide(width: 1.5),
                      )
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator:(val){
                    if(val!.length <8){
                      return " Email cant be less than 3 letter";
                    }
                    if(val.length >100){
                      return "Email cant be larger than  letter";
                    }
                    return null;
                  },
                  onSaved: (val){
                    email=val;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      hintText: "email",
                      border: OutlineInputBorder(
                        borderSide:BorderSide(width: 1.5),
                      )
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator:(val){
                    if(val!.length <8){
                      return " password cant be less than 3 letter";
                    }
                    if(val.length >100){
                      return "password cant be larger than  letter";
                    }
                    return null;
                  },
                  onSaved: (val){
                    password=val;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.blue,),
                      hintText: "password",
                      border: OutlineInputBorder(
                        borderSide:BorderSide(width: 1.5),)),),
                SizedBox(height: 2,),
                Container(
                  child: Row(children: [SizedBox(width: 8,),
                    Text("if you already haven account "), InkWell(
                      onTap: (){

                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return login();}));
                        },
                      child: Text("Click Here!",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,),),)],),),
                ElevatedButton(onPressed: ()async{
                  UserCredential respons=await signUp();

                  print(respons.user?.email);

                }, child:Text("sign Up",style: TextStyle(fontWeight: FontWeight.bold),),),
              ],
              )),
            )
          ],
        ),
      ),
    );
  }
}