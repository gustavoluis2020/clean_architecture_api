import 'package:clean_architecture_api/core/helpers/use_case.dart';

class UsersNotFoundException implements Failure {
  @override
  final String message;

  @override
  final Exception? exception;

  UsersNotFoundException(this.message, {this.exception});
}
