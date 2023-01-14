import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({required this.lable,this.onTap}) ;
   String lable;
   VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(lable,style: const TextStyle(
            fontSize: 20.0,
            color: Color(0XFF2B475E),
          ),),
        ),
      ),
    );
  }
}
