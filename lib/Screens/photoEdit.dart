import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/StudentPhotoContract.dart';
import 'package:untitled5/Screens/student_faculty_photo.dart';
import 'package:untitled5/Screens/studentphoto_screen.dart';

class StudentPhotoDetail extends StatefulWidget {
  StudentPhotoContract studentPhotoContract;

  StudentPhotoDetail({required this.studentPhotoContract});

  @override
  _StudentPhotoDetailState createState() => _StudentPhotoDetailState();
}

class _StudentPhotoDetailState extends State<StudentPhotoDetail> {

  var formKey = GlobalKey<FormState>();

  var tfstudentFirstName = TextEditingController();
  var tfStudentPhoneNumber = TextEditingController();
  var tfStudentLastName = TextEditingController();
  var tfStudentbirthYear = TextEditingController();
  var tfStudentAdress = TextEditingController();

  var refStudentPhoto = FirebaseDatabase.instance.ref().child("student");

  Future<void> update(String kisi_id,String studentFirstName,String studentLastName ,int birthYear
      ,String studentPhoneNumber ,String adressPhotoName) async {
    var info = HashMap<String,dynamic>();
    info["studentFirstName"] = studentFirstName;
    info["studentLastName"] = studentLastName;
    info["birthYear"] = birthYear;
    info["studentPhoneNumber"] = studentPhoneNumber;
    info["adressPhotoName"] = adressPhotoName;
    refStudentPhoto.child(kisi_id).update(info);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var student = widget.studentPhotoContract;
    tfstudentFirstName.text = student.studentFirstName;
    tfStudentLastName.text = student.studentLastName;
    tfStudentbirthYear.text = student.birthYear.toString();
    tfStudentPhoneNumber.text = student.studentPhoneNumber;
    tfStudentAdress.text = student.adressPhotoName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Detay"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    controller: tfstudentFirstName,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Öğrenci Adı',
                      helperText: 'Öğrenci adı en az 2 karekter olmalıdır',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                    validator: (String? value) {
                      if (value != null && value.length < 2) {
                        return "Öğrenci adı en az 2 karekter olmalıdır";
                      }
                    },
                  ),
              TextFormField(
                      controller: tfStudentLastName,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Öğrenci Soyadı',
                        helperText: 'Öğrenci soyadı en az 2 karekter olmalıdır',
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                      ),
                      validator: (String? value) {
                        if (value != null && value.length < 2) {
                          return "Öğrenci soyadı en az 2 karekterden oluşmalıdır";
                        }
                      }),
                  TextFormField(
                      controller: tfStudentbirthYear,
                      maxLength: 4,
                      decoration: InputDecoration(
                        labelText: 'Öğrencinin Doğum Yılı',
                        helperText: '19880-2010',
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                      ),
                      ),
                  TextFormField(
                    controller: tfStudentPhoneNumber,
                    maxLength: 13,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Öğrenci Numarası',
                      hintText: "05** *** ****",
                      helperText: 'Öğrenci telefon numarası formattaki gibi giriniz',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                    validator: (String? value){
                      if( value != null && value.length != 13){
                        return "Öğrenci numarası formattaki gibi giriniz";
                      }
                    },
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 3,
                    controller: tfStudentAdress,
                    decoration: InputDecoration(
                      labelText: 'Adres',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          update(widget.studentPhotoContract.studentId, tfstudentFirstName.text, tfStudentLastName.text,
              int.parse(tfStudentbirthYear.text),tfStudentPhoneNumber.text,tfStudentAdress.text);
          print(widget.studentPhotoContract.studentId);

          if(formKey.currentState!.validate()){
            _showAllert();
          }
        },
        tooltip: 'Kişi Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }

  _showAllert() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Kayıt güncellenecek emin misiniz?'),
            content: Text(
                'Güncelle butonuna bastıktan sonra bu işlem geri alınamaz.'),
            actions: [
              TextButton(
                onPressed: () {
                  update(widget.studentPhotoContract.studentId, tfstudentFirstName.text, tfStudentLastName.text,
                      int.parse(tfStudentbirthYear.text),tfStudentPhoneNumber.text,tfStudentAdress.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FacultyPhotoScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kayıt Güncellendi'),
                    ),
                  );
                },
                child: Text('GÜNCELLE'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Color(0xFF6200EE),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('VAZGEÇ'),
              ),
            ],
          );
        });
  }
}
