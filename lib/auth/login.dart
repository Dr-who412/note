import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:note_app/auth/signup.dart';

import '../componant/circler.dart';
import '../mainscrean/homepage.dart';



class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailAddress, password;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  logInFun() async {

    var formdate = formstate.currentState;
    if (formdate!.validate()) {

      formdate.save();
      try {Showleading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
      Navigator.of(context).pop();
        if(!credential.user!.emailVerified){
          var user=FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
          AwesomeDialog(context: context,title: "Verified",dialogType: DialogType.QUESTION,
              body: Text("please,check your account inbox"))..show();
        }else{

          return credential;
        }

      } on FirebaseAuthException catch (e){
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop;
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("No user found for that email."))
            ..show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop;
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('Wrong password provided for that user.'))
            ..show();
          print('Wrong password provided for that user.');
        }
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 33, 31, 0.9725490196078431),
        title: Text("login"),

      ),*/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
                child: CircleAvatar(
              radius: 40,
              child: Image.asset("images/Luffysicon.png"),
            )),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "username or email can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          emailAddress = val;

                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(40)),
                              borderSide: BorderSide(width: 1.5),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val){
                          if (val!.isEmpty) return "password cant be Empty";
                          return null;
                        },
                        onSaved: (val) {
                          password = val;
                          print(password.isEmpty);
                        },

                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    24,
                                  ),
                                  bottomRight: Radius.circular(40)),
                              borderSide: BorderSide(width: 1.5),
                            )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text("if you haven't account "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return signup();
                                }));
                              },
                              child: Text(
                                "Click Here!",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var respons = await logInFun();
                          if (respons != null) {
                            print("??????");
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return homepage();
                            }));
                          }else{
                            Navigator.of(context).pop();
                            AwesomeDialog(context: context,title: "error",body: Text("cant login please enter your valied email : Email@***.com"
                                ))..show();
                          }
                        },
                        child: Text(
                          "login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
