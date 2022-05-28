class StudentValidationMixin{

  String? validatorFirstName(String? value){
    if(value != null && value.length < 2){
      return "Öğrenci ismi en az 2 karekterden oluşmalıdır";
    }
  }

  String? validatorLastName(String? value){
    if( value != null && value.length < 2){
      return "Öğrenci soyadı en az 2 karekterden oluşmalıdır";
    }
  }

  String? validatorPoint(String? value){
    if(value != null && value.length < 2){
      return "Öğrenci ismi en az 2 karekterden oluşmalıdır";
    }
  }

  String? validatorPuan(String? value){
    if(value != null){
      int point = int.parse(value);
      if(point < 0 || point > 100){
        return "Puan 0-100 aralığında olamlıdır";
      }
    }
  }
}