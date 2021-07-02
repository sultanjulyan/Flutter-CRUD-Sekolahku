import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/model/student_model_provider.dart';

class TeacherRepository{
  final StudentModelProvider _studentModelProvider;
  TeacherRepository(this._studentModelProvider);

  Future<int> create(TeacherDomain teacherDomain){
    return _studentModelProvider.getDatabase().then((value) => value.insert('guru', teacherDomain.toMap()));
  }

  Future<void> delete(int idGuru){
    return _studentModelProvider.getDatabase().then((value) => value.delete('guru', where: 'id_guru = $idGuru'));
  }

  Future<List<TeacherDomain>> readTeachers(String keyword){
    var sqlRaw = "SELECT * FROM guru";

    if(keyword.isNotEmpty){
      var pattern = '%$keyword%';
      sqlRaw += '''
        WHERE first_name LIKE '$pattern' OR
        last_name LIKE '$pattern' OR
        mobile_phone LIKE '$pattern' OR
        gender LIKE '$pattern' OR
        mapel LIKE '$pattern'
      ''';
    }

    return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
      if(data.length == 0){
        return [];
      }

      List<TeacherDomain> teachers = [];
      for(int i=0; i<data.length; i++){
        TeacherDomain teacherDomain = TeacherDomain();
        teacherDomain.fromMap(data[i]);
        teachers.add(teacherDomain);
      }

      return teachers;
    });
  }

 Future<TeacherDomain> teacherById(int idGuru){
   var sqlRaw = "SELECT * FROM guru WHERE id_guru = $idGuru";
   return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
     if(data.length == 1){
       TeacherDomain teacherDomain = TeacherDomain();
       teacherDomain.fromMap(data[0]);
       return teacherDomain;
     }

     return null;
   });
 }

 Future<int> updateTeacher(int idSiswa, TeacherDomain dataSiswa){
    return _studentModelProvider.getDatabase().then((value){
      return value.update('guru', dataSiswa.toMap(), where: 'id_guru = $idSiswa');
    });
 }

}