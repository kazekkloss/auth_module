import 'package:milestory_web/core/exception/exceptions.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<DataState> call(Params params);
}