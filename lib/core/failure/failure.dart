import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> _props;

  const Failure([this._props = const <dynamic>[]]);

  @override
  get props => _props;
}

class ApiFailure extends Failure {}
class DataNotFoundFailure extends Failure {}