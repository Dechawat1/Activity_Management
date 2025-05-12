import 'package:flutter/material.dart';

class conSchedul extends StatefulWidget {
  const conSchedul({Key? key}) : super(key: key);

  @override
  State<conSchedul> createState() => _conSchedulState();
}

class _conSchedulState extends State<conSchedul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Mobile Appication",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold
                            ))
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Section : ..................",style: TextStyle(fontSize: 17),)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Time : ...................",style: TextStyle(fontSize: 17)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange),
                            onPressed: () {},
                            icon: const Icon(Icons.delete_forever),
                            label: const Text('Delete'))
                      ],
                    )
                  ]
              )),
        ],
      ),
    );

  }
  Container buildTextInfoHomework() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Text("Subject : "),
            Text("Submit work : "),
            Text("Detail : ")
          ],
        ));
  }
}