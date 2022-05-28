
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/admin_screen.dart';
import 'package:untitled5/Screens/faculties_screen.dart';
import 'package:untitled5/Screens/login_screen.dart';
import 'package:untitled5/Screens/notebook_screen.dart';
import 'package:untitled5/Screens/signup_screen.dart';
import 'package:untitled5/Screens/start_weather_screen.dart';
import 'package:untitled5/Screens/student_faculty_photo.dart';
import 'package:untitled5/aaaaa.dart';
//import 'package:my_flutter_proje/Screens/statistics_screen.dart';
import 'package:untitled5/costants.dart';

import '../Screens/main_weather_screen.dart';
import '../Screens/studentphoto_add_screen.dart';

class Body_Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 65.0,
            ),
            Text(
              "HOŞ GELDİNİZ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black.withOpacity(0.6)
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Positioned(
              child: Image.asset(
                "assets/icons/chat.png",
                width: size.width * 0.60,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0, bottom: 10.0),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();},),);},
                    //Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();},),);
                    child: Text(
                      "GİRİŞ YAP",
                      style: TextStyle(color: Colors.white),
                    )
                ) ,
              ) ,
            ),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryLighColor,
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){return SignupScreen();},),);},
                    //Navigator.push(context, MaterialPageRoute(builder: (context){return SignupScreen();},),);
                    child: Text(
                      "KAYDOL",
                      style: TextStyle(color: Colors.black),
                    )
                ) ,
              ) ,
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Text(
                  "Bugün Hava Nasıl?  ",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  //onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartScreen()));},
                  onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartScreen()));},
                  child: Text(
                    "Hava Durumu",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
