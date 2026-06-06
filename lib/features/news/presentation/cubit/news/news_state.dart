import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/domain/usecases/get_news_use_case.dart';

part 'news_cubit.dart';

sealed class NewsState {}

class InitialNewsState extends NewsState {}

class NewsLoading extends NewsState {}

/// Loading state for pagination (loading more articles)
class NewsLoadingMore extends NewsState {}

class NewsLoaded extends NewsState {}

/// State when search mode is active
///
/// Used to trigger UI search mode (input + filtering UI)
class NewsSearching extends NewsState {}

class NewsError extends NewsState {
  final String failedMessage;

  NewsError({required this.failedMessage});
}
