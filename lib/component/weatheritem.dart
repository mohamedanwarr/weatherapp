import 'package:flutter/material.dart';
class weatheritem extends StatelessWidget {
  final int value;
  final String unit;
  final String imageurl;





   weatheritem({
    super.key, required this.value, required this.unit, required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: EdgeInsets.all(10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Image.asset(imageurl),
        ),
        SizedBox(height: 8.0,),
        Text(
          value.toString(),style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        )
      ],
    );
  }
}