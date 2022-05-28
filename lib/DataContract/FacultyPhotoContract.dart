class FacultyPhotoContract {
  late String facultyId;
  late String facultyName;

  FacultyPhotoContract(this.facultyId, this.facultyName);

  //json formatına çevirme
  //Gelen key i facultyıd ye aktarıldı
  factory FacultyPhotoContract.fromJson(String key,Map<dynamic,dynamic> json){
    return FacultyPhotoContract(key, json["facultyName"] as String);
  }
}