import 'package:untitled5/DataContract/Faculties.dart';

class Students{
  late String studentNo;
  late String studentFirstName;
  late String studentLastName;
  late String mail;
  late Faculties faculties;

  Students(this.studentNo, this.studentFirstName, this.studentLastName,
      this.mail, this.faculties);
}