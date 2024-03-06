import 'package:clean_arch_news_flutter/features/news/data/datasource/news_data_source.dart';
import 'package:clean_arch_news_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:clean_arch_news_flutter/features/news/domain/usecase/get_news_usecase.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/bloc/news_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory<NewsBloc>(() => NewsBloc(getNews: sl.get()));

  //UseCase
  sl.registerLazySingleton<FetchNews>(() => FetchNews(sl.get()));

  //Repo
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(dataSource: sl.get()));

  //Datasource
  sl.registerLazySingleton<NewsDataSource>(() => NewsDataSourceImpl());
}
