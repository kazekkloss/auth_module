import 'package:milestory_web/core/exception/exceptions.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<DataState<User>> call({required String email, required String password}) async {
    return await repository.signUp(email: email, password: password);
  }
}
