import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Faculties.dart';
import 'package:untitled5/Screens/faculties_screen.dart';
import 'package:untitled5/Screens/students_name_screen.dart';
import 'package:untitled5/Studentsdao.dart';

class StudentAddScreen extends StatefulWidget {

  late Faculties faculty;
  StudentAddScreen(this.faculty);

  @override
  State<StudentAddScreen> createState() => _StudentAddScreenState();
}

class _StudentAddScreenState extends State<StudentAddScreen> {

  var formKey = GlobalKey<FormState>();
  int saveFaculty = 1;

  List<String> facultyList = [];
  String selectedFaculty = "Bilgisayar Mühendisliği";

  @override
  void initState() {
    super.initState();
    facultyList.add("Bilgisayar Mühendisliği");
    facultyList.add("Makine Mühendisliği");
    facultyList.add("Elektrik Elektronik Mühendisliği");
    facultyList.add("Metalurji ve Malzeme Mühendisliği");
  }

  var tfStudentFirsName = TextEditingController();
  var tfStudentLastName = TextEditingController();
  var tfStudentNo = TextEditingController();
  var tfStudentMail = TextEditingController();
  var tfStudentFacultyId = TextEditingController();

  Future<void> studentsSave(String firstName, String lastName, String no, String mail, int facultyId) async {
    await Studentsdao().addStudents(firstName, lastName, no, mail, facultyId);
    print("$firstName kaydedildi");
    //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsName()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: tfStudentFirsName,
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'Öğrenci Adı',
                    helperText: 'Öğrenci adı en az 2 karekter olmalıdır',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                  validator: (String? value){
                    if( value != null && value.length < 2){
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
                  validator: (String? value){
                    if( value != null && value.length < 2){
                      return "Öğrenci soyadı en az 2 karekterden oluşmalıdır";
                    }
                  },
                ),
                TextFormField(
                  controller: tfStudentNo,
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Öğrenci Numarası',
                    hintText: "18*******",
                    helperText: 'Öğrenci numarası formattaki gibi giriniz',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                  validator: (String? value){
                    if( value != null && value.length != 9){
                      return "Öğrenci numarası formattaki gibi giriniz";
                    }
                  },
                ),
                TextFormField(
                  controller: tfStudentMail,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: 'Öğrenci Mail Adresi',
                    helperText: 'Öğrenci mailini giriniz',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                  validator: (String? value){
                    if( value != null && !(value.contains('@hotmail.com') ||
                        value.contains('@gmail.com') ||
                        value.contains('@outlook.com') ||
                        value.contains('@icloud.com') ||
                        value.contains('@example.com') ||
                        value.contains('@yahoo.com') ||
                        value.contains('@aol.com'))){
                      return "Geçersiz e-posta";
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(formKey.currentState!.validate()){
            print("Validasyona girdi");
            _showAllert();
          }

        },
        tooltip: "Öğrenci Kayıt",
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }

  _showAllert(){
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            title: Text('Kişi kaydedilecek emin misiniz?'),
            content: Text('Kaydet butonuna bastıktan sonra bu işlem geri alınamaz.'),
            actions: [
              TextButton(
                onPressed: () {
                  studentsSave(tfStudentFirsName.text, tfStudentLastName.text, tfStudentNo.text, tfStudentMail.text,widget.faculty.facultyId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Öğrenci Kaydedildi'),),
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentsName(faculty: widget.faculty)));
                },
                child: Text('KAYDET'),
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
        }
    );
  }

}

