class UserDomain {
  int idUser;
  String email;
  String password;

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'email': email,
      'password': password
    };
  }

  void fromMap(Map<String, dynamic> value){
    idUser = value['id_user'];
    email = value['email'];
    password = value['password'];
  }
}
