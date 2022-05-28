import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/login_screen.dart';
import 'package:untitled5/costants.dart';
import 'package:untitled5/models/url_medai.dart';
import 'package:untitled5/models/users.dart';
import 'package:untitled5/service/auth.dart';
import 'package:untitled5/validate/login_vilidate.dart';



class Body_Signup extends StatefulWidget  {

  @override
  State<Body_Signup> createState() => _Body_SignupState();
}

//Ekranın yenilenme hızına göre animasyonun hızını belirleyen teknoloji
class _Body_SignupState extends State<Body_Signup> with LoginValidation , TickerProviderStateMixin{

  late AnimationController animationController;

  //animasyon değerlerini tutar
  late Animation<double> alphaAnimationValue;
  late Animation<double> scaleAnimationValue;
  late Animation<double> rotateAnimationValue;

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 2000),vsync: this);
    scaleAnimationValue = AnimationController(duration: Duration(milliseconds: 2000),vsync: this);
    rotateAnimationValue = AnimationController(duration: Duration(milliseconds: 2000),vsync: this);

    //Her değişimde arayüz güncellenir
    alphaAnimationValue = Tween(begin: 1.0, end: 0.5).animate(animationController)
      ..addListener(() {
        setState(() {

        });
      });

    scaleAnimationValue = Tween(begin: 20.0, end: 40.0).animate(animationController)
      ..addListener(() {
        setState(() {
        });
      });

    rotateAnimationValue = Tween(begin: 0.0, end: pi/2).animate(animationController)
      ..addListener(() {
        setState(() {

        });
      });

    super.initState();
  }

  //Sayfa kapandığında animasyon özelliğini bitir
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  var user = User("","");

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45.0,
                ),
                Text(
                  'KAYDOL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black.withOpacity(0.6)
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    "assets/icons/signup.png",
                    height: size.height * 0.30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: kPrimaryLighColor,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "mail_adresiniz@gmail.com",
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    validator: validateEmail,
                    /*onSaved: (String? value){
                      if(value != null){
                        user.email = value;
                      }
                    },*/
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: kPrimaryLighColor,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Parola",
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: kPrimaryColor,
                      ),
                    ),
                    validator: validatePassword,
                    onSaved: (String? value){
                      /*if(value != null){
                        user.password = value;
                      }*/
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          _authService.createPerson(_emailController.text, _passwordController.text).then((value) {
                            return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          print(user.email);
                          print(user.password);
                          print('Kaydeldi');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Kaydınız oluşturuldu. Giriş yapabilirsiniz :)'),),
                          );
                        }
                      },
                      child: Text(
                        "KAYDOL",
                        style: TextStyle(color: Colors.white),
                      ),
                    ) ,
                  ) ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                      "Hesabınız var mı?  ",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));},
                      child: Text(
                        "GİRİŞ YAP",
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
                Text(
                  "-------------------------------------" + " "+"OR"+" " + "-------------------------------------",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(opacity: animationController.value,
                      child: GestureDetector(
                        onTap: (){
                          facebookURL();
                        },
                        onDoubleTap: (){
                          animationController.forward();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.0,
                                  color: kPrimaryLighColor
                              ),
                              shape: BoxShape.circle
                          ),
                          child: Positioned(
                            child: Image.asset(
                              "assets/icons/facebook.png",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        twitterURL();
                      },
                      onDoubleTap: (){
                        animationController.forward();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: kPrimaryLighColor
                            ),
                            shape: BoxShape.circle
                        ),
                        child: Positioned(
                          child: Image.asset(
                            "assets/icons/twitter.png",
                            height: scaleAnimationValue.value,
                            width: scaleAnimationValue.value,
                          ),
                        ),
                      ),
                    ),
                    Transform.rotate(angle: rotateAnimationValue.value,
                      child: GestureDetector(
                        onTap: (){
                          googlePlusURL();
                        },
                        onDoubleTap: (){
                          animationController.forward();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.0,
                                  color: kPrimaryLighColor
                              ),
                              shape: BoxShape.circle
                          ),
                          child: Positioned(
                            child: Image.asset(
                              "assets/icons/google-plus.png",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}