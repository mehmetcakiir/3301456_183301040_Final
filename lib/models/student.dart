class Student{
  int id=0;
  String fitstName="";
  String lastName="";
  int point=0;
  String _status="";

  Student(String firtName, String lastName, int point){
    this.fitstName = firtName;
    this.lastName = lastName;
    this.point = point;
  }

  Student.nullInfo(){

  }

  Student.withid( int id, String firtName, String lastName, int point){
    this.id = id;
    this.fitstName = firtName;
    this.lastName = lastName;
    this.point = point;
  }


  String get getStatus{
    String message = "";
    if (point < 50) {
      message = "Kaldı";
    }
    else if(point == 50){
      message = "Bütünleme";
    }
    else if(point > 50){
      message = "Geçti";
    }
    return message;
  }
}