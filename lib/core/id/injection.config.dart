// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/news/data/data_sources/online/news_online_data_source_impl.dart'
    as _i401;
import '../../features/news/data/data_sources/online/news_online_data_sources.dart'
    as _i1020;
import '../../features/news/data/data_sources/online/source_online_data_source.dart'
    as _i619;
import '../../features/news/data/data_sources/online/source_online_data_source_impl.dart'
    as _i473;
import '../../features/news/data/data_sources/repository/news_repostiory_impl.dart'
    as _i563;
import '../../features/news/data/data_sources/repository/source_repository_impl.dart'
    as _i1038;
import '../../features/news/domain/repository/news_repository.dart' as _i1049;
import '../../features/news/domain/repository/source_repository.dart' as _i24;
import '../../features/news/domain/usecases/get_news_use_case.dart' as _i147;
import '../../features/news/domain/usecases/get_sources_use_case.dart' as _i608;
import '../../features/news/presention/cubit/news/news_state.dart' as _i931;
import '../../features/news/presention/cubit/sources/sources_state.dart'
    as _i249;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1020.NewsOnlineDataSources>(
      () => _i401.NewsOnlineDataSourceImpl(),
    );
    gh.factory<_i931.NewsCubit>(
      () => _i931.NewsCubit(gh<_i147.GetNewsUseCase>()),
    );
    gh.factory<_i1049.NewsRepository>(
      () => _i563.NewsRepositoryImpl(gh<_i1020.NewsOnlineDataSources>()),
    );
    gh.factory<_i619.SourceOnlineDataSource>(
      () => _i473.SourceOnlineDataSourceImpl(),
    );
    gh.factory<_i24.SourceRepository>(
      () => _i1038.SourceRepositoryImpl(gh<_i619.SourceOnlineDataSource>()),
    );
    gh.factory<_i608.GetSourcesUseCase>(
      () => _i608.GetSourcesUseCase(gh<_i24.SourceRepository>()),
    );
    gh.factory<_i249.SourcesCubit>(
      () => _i249.SourcesCubit(gh<_i608.GetSourcesUseCase>()),
    );
    return this;
  }
}
