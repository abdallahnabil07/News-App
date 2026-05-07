import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/domain/usecases/get_sources_use_case.dart';

part 'sources_cubit.dart';

sealed class SourcesState {}

class InitialSourcesState extends SourcesState {}

class SourcesLoading extends SourcesState {}

class SourcesLoaded extends SourcesState {
  final List<SourceData> sources;

  SourcesLoaded({required this.sources});
}

class SourcesTabChanged extends SourcesState {}

class SourcesError extends SourcesState {
  final String failedMessage;

  SourcesError({required this.failedMessage});
}
