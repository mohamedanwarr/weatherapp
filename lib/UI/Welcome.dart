import 'package:flutter/material.dart';
import 'package:weatherapp/UI/Home%20page.dart';

import '../methods/City.dart';
import '../methods/Constants.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> citiez=City.citiesList.where((city) => city.isDefault==false).toList();//get citiez data and selected citiez data
    List<City> selectedcitiez=City.getSelectedCIties();//get citiez data and selected citiez data
    Constants myConstants=Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title: Text('${selectedcitiez.length}Selected'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: citiez.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(left: 10,top: 20,right: 10),
              height: size.height*.08,
              width: size.width,
              decoration: BoxDecoration(
                border: citiez[index].isSelected==true?Border.all(
                  color: myConstants.secondaryColor.withOpacity(.6),width: 2
                ):Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow:[ BoxShadow(
                  color: myConstants.primaryColor.withOpacity(.2),
                      spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0,3)
                )]
              ),
              child: Row( 
                children: [
                  GestureDetector
                    (onTap: (){
                      setState(() {
                        citiez[index].isSelected =! citiez[index].isSelected;
                      });
                  },
                      child: Image.asset(citiez[index].isSelected==true?'assets/checked.png':'assets/unchecked.png',width: 30,)),
                  const SizedBox(width: 10,),
                  Text(citiez[index].city,style: TextStyle(
                    fontSize: 16,
                    color: citiez[index].isSelected==true?myConstants.primaryColor:Colors.black54
                  ),)
                ],
              ),

            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
        },
        backgroundColor: myConstants.secondaryColor,
        child: Icon(Icons.pin_drop),
      ),
    );
  }
}


