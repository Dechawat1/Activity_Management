import 'package:flutter/material.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Transform.rotate(
          angle: 32,
          child: Container(
            width: width * 1.5,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 191, 255, 1),
            ),
          ),
        ),
        Transform.rotate(
          angle: 6,
          alignment: Alignment.bottomLeft,
          child: Container(
              width: width * 2,
              height: height * 2,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(90, 133, 215, 1),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 170, horizontal: 80),
                    child: Wrap(
                      direction: Axis.horizontal, //Vertical || Horizontal
                      children: <Widget>[
                        Transform.rotate(
                            angle: 38,
                            child: const Text('Activity \nManagement ',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  // height: 5.5
                                ))),
                      ],
                    ),
                  )
                ],
              )),
        ),
        Transform.rotate(
          angle: 1,
          alignment: Alignment.topRight,
          child: Container(
            width: width * 0.5,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 191, 255, 1),
            ),
          ),
        ),
      ],
    );
  }
}
