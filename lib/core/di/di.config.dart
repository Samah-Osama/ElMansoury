// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mansoury/core/api_manager/api_service.dart' as _i185;
import 'package:mansoury/core/di/di.dart' as _i983;
import 'package:mansoury/features/home/data/data_source/product_remote_data_source.dart'
    as _i347;
import 'package:mansoury/features/home/data/repos/products_repo.dart' as _i599;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i185.ApiService>(() => registerModule.apiService);
    gh.factory<_i347.ProductRemoteDataSource>(
      () => _i347.ProductRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i599.ProductRepository>(
      () => _i599.ProductRepository(gh<_i347.ProductRemoteDataSource>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i983.RegisterModule {}
