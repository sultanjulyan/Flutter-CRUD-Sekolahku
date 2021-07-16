import 'package:sekolahku/model/student_model_provider.dart';
import 'package:sekolahku/repository/student_repository.dart';
import 'package:sekolahku/repository/teacher_repository.dart';
import 'package:sekolahku/repository/user_repository.dart';
import 'package:sekolahku/service/student_service.dart';
import 'package:sekolahku/service/teacher_service.dart';
import 'package:sekolahku/service/user_service.dart';
import 'package:sqflite/sqflite.dart';

StudentRepository studentRepository = StudentRepository(StudentModelProvider.getInstance());
TeacherRepository teacherRepository = TeacherRepository(StudentModelProvider.getInstance());
UserRepository userRepository = UserRepository(StudentModelProvider.getInstance());
StudentService studentService = StudentService(studentRepository);
TeacherService teacherService = TeacherService(teacherRepository);
UserService userService = UserService(userRepository);

class AppServices {
  static StudentService get getStudentService {
    return studentService;
  }

  static TeacherService get getTeacherService {
    return teacherService;
  }

  static UserService get getUserService {
    return userService;
  }

  static Future<Database> openDb(){
    return StudentModelProvider.getInstance().openDb();
  }

  static Future<Database> closeDb(){
    return StudentModelProvider.getInstance().closeDb();
  }
}
