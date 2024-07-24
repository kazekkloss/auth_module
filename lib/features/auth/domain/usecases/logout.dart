import 'package:milestory_web/core/exception/exceptions.dart';
import '../repository/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<DataState> call() async {
    return await repository.logout();
  }
}
