
class StudentPhotoContract {
  late String studentId;
  late String studentFirstName;
  late String studentLastName;
  late String studentPhoto;
  late int birthYear;
  late String studentPhoneNumber;
  late String facultyPhotoName;
  late String adressPhotoName;

  StudentPhotoContract(this.studentId, this.studentFirstName, this.studentLastName, this.studentPhoto,
      this.birthYear, this.studentPhoneNumber, this.facultyPhotoName,  this.adressPhotoName);


  //json formatına çevirme
  //Gelen key i facultyıd ye aktarıldı
  factory StudentPhotoContract.fromJson(String key,Map<dynamic,dynamic> json){
    return StudentPhotoContract(key, json["studentFirstName"] as String, json["studentLastName"] as String,
        json["studentPhoto"] as String, json["birthYear"] as int, json["studentPhoneNumber"] as String, json["facultyPhotoName"] as String, json["adressPhotoName"] as String);
  }
}