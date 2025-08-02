import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mansoury/core/api_manager/api_service.dart';
import 'package:mansoury/core/di/di.config.dart';




final GetIt getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  ApiService get apiService => ApiService(getIt<Dio>());
}