import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/article_model.dart';

@immutable
abstract class NewsState extends Equatable {}

class Initialized extends NewsState {
  @override
  List<Object?> get props => [];
}

class Loading extends NewsState {
  @override
  List<Object?> get props => [];
}

class Success extends NewsState {
  final List<Article> article;

  Success(this.article);

  @override
  List<Object?> get props => article;
}

class Error extends NewsState {
  final Failure failure;

  Error(this.failure);

  @override
  List<Object?> get props => [failure];
}
