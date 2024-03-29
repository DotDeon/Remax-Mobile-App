import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Animation<double> buttonGrowAnimation;
  AddButton({this.buttonGrowAnimation});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: buttonGrowAnimation.value * 60,
      height: buttonGrowAnimation.value * 60,
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
          color: const Color.fromRGBO(207, 0, 15, 1),
          shape: BoxShape.circle),
      child: new Icon(
        Icons.add,
        size: buttonGrowAnimation.value * 40.0,
        color: Colors.white,
      ),
    ));
  }
}
