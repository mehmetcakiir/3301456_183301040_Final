import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/admin_screen.dart';
import 'package:untitled5/models/student.dart';
import 'package:untitled5/validate/student_validation.dart';

class StudentEdit extends StatefulWidget{
  Student? selectedStudent;

  StudentEdit(Student? selectedStudent){
    if(selectedStudent != null){
      this.selectedStudent = selectedStudent;
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudendAddState(selectedStudent);
  }
}

class _StudendAddState extends State with StudentValidationMixin {
  Student? selectedStudent;
  var formKey = GlobalKey<FormState>();

  _StudendAddState(Student? selectedStudent){
    if(selectedStudent != null){
      this.selectedStudent = selectedStudent;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              //autovalidateMode: AutovalidateMode.always,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Öğrenci Güncelleme Ekranı',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xFF363F93),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  builFirstNameField(),
                  builLastNameField(),
                  builPuanField(),
                  buildSubmintButton(),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget builFirstNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      child: TextFormField(
        initialValue: selectedStudent!.fitstName,
        decoration: InputDecoration(labelText: "Öğrencinin Adı", hintText: "Mehmet"),
        validator: validatorFirstName,
        onSaved: (String? value){
          if(value != null){
            selectedStudent!.fitstName = value;
          }
        },
      ),
    );
  }

  Widget builLastNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      child: TextFormField(
        initialValue: selectedStudent!.lastName,
        decoration: InputDecoration(labelText: "Öğrencinin Soyadı", hintText: "Çakır"),
        validator: validatorLastName,
        onSaved: (String? value){
          if(value != null){
            selectedStudent!.lastName = value;
          }
        },
      ),
    );
  }

  Widget builPuanField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      child: TextFormField(
        initialValue: selectedStudent!.point.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "ÖğrenciniN Puanı", hintText: "0-100"),
        validator: validatorPuan,
        onSaved: (String? value){
          if(value != null){
            selectedStudent!.point = int.parse(value);
          }
        },
      ),
    );
  }

  Widget buildSubmintButton() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: (){
              if(formKey.currentState!.validate()){
                setState(() {
                  formKey.currentState!.save();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Kayıt Güncellendi'),),
                );
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
              }
            },
            child: Text(
              "Kaydet",
              style: TextStyle(color: Colors.black),
            )
        ) ,
      ) ,
    );
  }

  void saveStudent() {
    print(selectedStudent?.fitstName);
    print(selectedStudent?.lastName);
    print(selectedStudent?.point);
  }
}