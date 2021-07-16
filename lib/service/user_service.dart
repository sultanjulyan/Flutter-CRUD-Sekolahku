import 'package:sekolahku/domain/user_domain.dart';
import 'package:sekolahku/repository/user_repository.dart';

class UserService{
  final UserRepository userRepository;

  UserService(this.userRepository);

  Future<int> createUser(UserDomain userDomain){
      return userRepository.create(userDomain);
  }

  Future<UserDomain> getEmail(String email){
    return userRepository.getEmail(email);
  }
  Future<UserDomain> getLogin(String email, String password){
    return userRepository.getLogin(email, password);
  }
}