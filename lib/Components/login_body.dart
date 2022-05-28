import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/admin_screen.dart';
import 'package:untitled5/Screens/signup_screen.dart';
import 'package:untitled5/costants.dart';
import 'package:untitled5/models/users.dart';
import 'package:untitled5/service/auth.dart';
import 'package:untitled5/validate/login_vilidate.dart';


class Login_Body extends StatelessWidget with LoginValidation {
  /*const Login_Body({
    Key? key,
  }) : super(key: key);*/

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String? email, password;
    bool controlEmail = false;
    bool controlPassword = false;

    List<User> users=[
      User('info.mehmetcakir@gmail.com', 'Bybrt_69'),
      User('turktoygulernur@hotmail.com', 'Afyon_03'),
      User('hamzacakir@outlook.com', 'Bybrt_069'),
    ];

    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 65.0,
              ),
              Text(
                'GİRİŞ YAP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black.withOpacity(0.6)
                ),
              ),
              Positioned(
                child: Image.asset(
                  "assets/icons/login.png",
                  width: size.width * 0.75,
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
                  validator:  validateEmail,
                  onChanged: (String value){
                    email = value;
                  },
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
                  onChanged: (String value){
                    password = value;
                  },
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
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        /*for(int i =0 ; i< users.length ; i++){
                          if(users[i].email == email ){
                            controlEmail = true;
                          }

                          for(int i =0 ; i< users.length ; i++){
                            if(users[i].password == password){
                              controlPassword = true;
                              break;
                            }
                          }
                        }*/

                        /*if(controlEmail == false){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Geçersiz Kullanıcı'),),
                          );
                        }

                        if(controlEmail == true && controlPassword == false){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Hatalı Şifre'),),
                          );
                        }

                        if(controlEmail == true && controlPassword == true){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                        }*/

                        _authService.sigIn(_emailController.text, _passwordController.text).then((value){
                          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                      }
                    },
                    child: Text(
                      "GİRİŞ YAP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ) ,
                ) ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Text(
                    "Hesabınız yok mu?  ",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));},
                    child: Text(
                      "KAYDOL",
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
      ),

    );
  }
}