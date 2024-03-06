import 'package:clean_arch_news_flutter/core/failure/failure.dart';
import 'package:clean_arch_news_flutter/features/news/data/datasource/news_data_source.dart';
import 'package:clean_arch_news_flutter/features/news/domain/entity/article_model.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getNews(String searchText);
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource dataSource;

  NewsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Article>>> getNews(String searchText) async {
    final news = await dataSource.getNews(searchText);
    if (news.status == 'ok') {
      if (news.articles != null && news.articles!.isNotEmpty) {
        final articles = news.articles!
            .map((element) => Article(
                  title: element.title,
                  description: element.description,
                  url: element.url,
                  imgUrl: element.urlToImage,
                ))
            .toList();
          return Right(articles);
      } else {
        return Left(DataNotFoundFailure());
      }
    } else {
      return Left(ApiFailure());
    }
  }
}
