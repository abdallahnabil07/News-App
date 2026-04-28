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

import '../../model/repository/news/data_sources/online/impl/news_online_data_source_impl.dart'
    as _i125;
import '../../model/repository/news/data_sources/online/news_online_data_sources.dart'
    as _i356;
import '../../model/repository/news/repository/impl/news_repostiory_impl.dart'
    as _i190;
import '../../model/repository/news/repository/news_repository.dart' as _i923;
import '../../model/repository/sources/data%20sources/online/impl/source_online_data_source_impl.dart'
    as _i1031;
import '../../model/repository/sources/data%20sources/online/source_online_data_source.dart'
    as _i949;
import '../../model/repository/sources/repository/impl/source_repository_impl.dart'
    as _i313;
import '../../model/repository/sources/repository/source_repository.dart'
    as _i1069;
import '../../modules/cubit/news/news_state.dart' as _i87;
import '../../modules/cubit/sources/sources_state.dart' as _i262;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i356.NewsOnlineDataSources>(
      () => _i125.NewsOnlineDataSourceImpl(),
    );
    gh.factory<_i949.SourceOnlineDataSource>(
      () => _i1031.SourceOnlineDataSourceImpl(),
    );
    gh.factory<_i923.NewsRepository>(
      () => _i190.NewsRepositoryImpl(gh<_i356.NewsOnlineDataSources>()),
    );
    gh.factory<_i1069.SourceRepository>(
      () => _i313.SourceRepositoryImpl(gh<_i949.SourceOnlineDataSource>()),
    );
    gh.factory<_i262.SourcesCubit>(
      () => _i262.SourcesCubit(gh<_i1069.SourceRepository>()),
    );
    gh.factory<_i87.NewsCubit>(
      () => _i87.NewsCubit(gh<_i923.NewsRepository>()),
    );
    return this;
  }
}
