import 'dart:io' show Platform;

import 'package:clean_arch_news_flutter/core/failure/failure.dart';
import 'package:clean_arch_news_flutter/features/news/domain/entity/article_model.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/bloc/news.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/pages/web_view.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/utils/theme_provider.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/widgets/news_item.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../di/dependency_injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isDark = false;
  bool _isPositionChanged = false;
  late final NewsBloc _bloc;

  _clearSearch() {
    if (_searchController.text.isNotEmpty) {
      _bloc.add(GetNews(queryText: ''));
      _searchController.clear();
      FocusScope.of(context).unfocus();
      _positionChanged();
    }
  }

  _changeTheme() {
    Provider.of<ThemeProvider>(context, listen: false).changeTheme();
    setState(() {
      _isDark = !_isDark;
    });
  }

  _scrollToFirst() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    _positionChanged();
  }

  _positionChanged() {
    setState(() {
      _isPositionChanged = !_isPositionChanged;
    });
  }

  _scrollListener() {
    setState(() {
      _isPositionChanged = _scrollController.position.pixels != 0;
    });
  }

  _editingComplete() {
    _bloc.add(GetNews(queryText: _searchController.text));
    FocusScope.of(context).unfocus();
    _positionChanged();
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("unable to launch url");
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
    _bloc = sl.get<NewsBloc>();
    _bloc.add(GetNews(queryText: ''));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: _changeTheme,
              icon: Icon(_isDark ? Icons.nights_stay : Icons.sunny),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: customSearchField(
                _searchController, _clearSearch, _editingComplete),
          ),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              bloc: _bloc,
              builder: _listBuilder,
            ),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        width: 45,
        height: 45,
        child: Visibility(
          visible: _isPositionChanged,
          child: FloatingActionButton(
            onPressed: _scrollToFirst,
            backgroundColor:
                Theme.of(context).colorScheme.inversePrimary.withAlpha(70),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            elevation: 0,
            child: const Icon(Icons.keyboard_double_arrow_up),
          ),
        ),
      ),
    );
  }

  Widget _listBuilder(BuildContext _, NewsState state) {
    if (state is Loading || state is Initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is Error) {
      if (state.failure is DataNotFoundFailure) {
        return const Center(
          child: Text('Data Not Found \n  Search Again'),
        );
      }
      if (state.failure is ApiFailure) {
        return const Center(
          child: Text('Something went wrong'),
        );
      }
    }

    List<Article> articleList = (state as Success).article;
    return ListView.builder(
      itemCount: articleList.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return NewsItem(
          article: articleList[index],
          onItemClick: (String url) {
            Platform.isAndroid || Platform.isIOS
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => NewsWebView(url: url)),
                  )
                : _launchUrl(url);
          },
        );
      },
    );
  }
}
