import 'package:flutter/material.dart';

import '../methods/Constants.dart';
import 'Welcome.dart';
class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants myConstants=Constants();
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.primaryColor.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset('assets/get-started.png'),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Welcome()));
                },
                child: Container(
                  height: 50,
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                    color: myConstants.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text('Get started' ,style: TextStyle(
                      color: Colors.white,fontSize: 18,
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
