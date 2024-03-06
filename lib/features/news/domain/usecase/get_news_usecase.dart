import 'package:clean_arch_news_flutter/core/failure/failure.dart';
import 'package:clean_arch_news_flutter/core/usecase/usecase.dart';
import 'package:clean_arch_news_flutter/features/news/domain/entity/article_model.dart';
import 'package:clean_arch_news_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchNews extends UseCase<List<Article>, Params> {
  final NewsRepository repository;

  FetchNews(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(Params params) {
    return repository.getNews(params.searchText);
  }
}

class Params extends Equatable {
  final String searchText;

  const Params({required this.searchText});

  @override
  get props => [searchText];
}
