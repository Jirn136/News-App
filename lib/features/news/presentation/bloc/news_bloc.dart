import 'package:clean_arch_news_flutter/features/news/domain/usecase/get_news_usecase.dart'
    as usecase;
import 'package:clean_arch_news_flutter/features/news/presentation/bloc/news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final usecase.FetchNews getNews;

  NewsBloc({required this.getNews})
      : super(Initialized()) {
    on<GetNews>(_onNewsFetched);
  }

  Future<void> _onNewsFetched(GetNews event, Emitter<NewsState> emit) async {
    emit(Loading());

    final newsEither = await getNews(usecase.Params(searchText: event.queryText));
    newsEither.fold(
      (err) => emit(
        Error(err),
      ),
      (articleList) => emit(
        Success(articleList),
      ),
    );
  }
}
