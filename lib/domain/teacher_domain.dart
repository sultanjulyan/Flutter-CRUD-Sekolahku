import 'package:sekolahku/utils/capitalize.dart';

class TeacherDomain {
  int idTeacher;
  String firstName;
  String lastName;
  String mobilePhone;   
  String gender;
  String mapel;
  String address;
  String birthDate;

  String get fullName{
    return "${capitalize(firstName)} ${capitalize(lastName)}";
  }
  static const genders = ["Pria", "Wanita"];
  static const mapelList = ["matematika", "fisika", "kimia"];

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'mobile_phone': mobilePhone,
      'gender': gender,
      'mapel': mapel,
      'address': address,
      'birth_date': birthDate,
    };
  }

  void fromMap(Map<String, dynamic> value){
    idTeacher = value['id_guru'];
    firstName = value['first_name'];
    lastName = value['last_name'];
    mobilePhone = value['mobile_phone'];
    gender = value['gender'];
    mapel = value['mapel'];
    address = value['address'];
    birthDate = value['birth_date'];
  }
}
