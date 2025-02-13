import 'package:flutter/material.dart';
import 'package:weatherai/core/utilies/ColorManager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome",style: TextStyle(
        color: ColorManager.textColor,
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
