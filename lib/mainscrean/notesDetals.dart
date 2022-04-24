import 'package:flutter/material.dart';
class noteDetals extends StatefulWidget {

  const noteDetals({Key? key,this.note}) : super(key: key);
  final note;
  @override
  State<noteDetals> createState() => _noteDetalsState();
}

class _noteDetalsState extends State<noteDetals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( widget.note['titel'],),
        backgroundColor: Colors.black12,
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            alignment: Alignment.topLeft,
            child: Text("${widget.note['note']}",style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),),

        ),
      ),
    );
  }
}
