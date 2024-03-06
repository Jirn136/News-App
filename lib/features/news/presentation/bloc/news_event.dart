import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class GetNews extends NewsEvent {
  final String queryText;

  GetNews({required this.queryText});

  @override
  get props => [queryText];
}
