import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/model/repository/news/repository/news_repository.dart';

part 'news_cubit.dart';

sealed class NewsState {}

class InitialNewsState extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoadingMore extends NewsState {}

class NewsLoaded extends NewsState {}

class NewsSearching extends NewsState {}

class NewsError extends NewsState {
  final String failedMessage;

  NewsError({required this.failedMessage});
}
