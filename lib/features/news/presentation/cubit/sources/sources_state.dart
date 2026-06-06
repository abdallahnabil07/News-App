import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/domain/usecases/get_sources_use_case.dart';

part 'sources_cubit.dart';

sealed class SourcesState {}

class InitialSourcesState extends SourcesState {}

class SourcesLoading extends SourcesState {}

class SourcesLoaded extends SourcesState {
  /// List of fetched news sources
  final List<SourceData> sources;

  SourcesLoaded({required this.sources});
}

/// State emitted when user changes selected tab/source index
///
/// Used only for UI updates without refetching data
class SourcesTabChanged extends SourcesState {}

class SourcesError extends SourcesState {
  final String failedMessage;

  SourcesError({required this.failedMessage});
}
