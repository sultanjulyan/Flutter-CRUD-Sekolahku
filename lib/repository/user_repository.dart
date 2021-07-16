import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/domain/user_domain.dart';
import 'package:sekolahku/model/student_model_provider.dart';

class UserRepository{
  final StudentModelProvider _studentModelProvider;
  UserRepository(this._studentModelProvider);

  Future<int> create(UserDomain userDomain){
    return _studentModelProvider.getDatabase().then((value) => value.insert('user', userDomain.toMap()));
  }

  Future<UserDomain> getEmail(String email){
   var sqlRaw = '''
        SELECT * FROM user
        WHERE email = '$email'
      ''';
   return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
     if(data.length == 1){
       UserDomain userDomain = UserDomain();
       userDomain.fromMap(data[0]);
       return userDomain;
     }

     return null;
   });
  }

  Future<UserDomain> getLogin(String email, String password){
   //var sqlRaw = "SELECT * FROM user WHERE email = $email and password = $password";
   var sqlRaw = '''
        SELECT * FROM user
        WHERE email = '$email' AND
        password = '$password'
      ''';
   return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
     if(data.length == 1){
       UserDomain userDomain = UserDomain();
       userDomain.fromMap(data[0]);
       return userDomain;
     }

     return null;
   });
  }
}