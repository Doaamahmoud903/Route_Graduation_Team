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

import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/data_sources/remote/impl/auth_remote_data_source_impl.dart'
    as _i219;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_respository.dart' as _i776;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/reset_password_use_case.dart'
    as _i825;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i229;
import '../../features/auth/presentation/manager/login/login_view_model.dart'
    as _i526;
import '../../features/auth/presentation/manager/reset_password/reset_password_view_model.dart'
    as _i903;
import '../../features/auth/presentation/manager/signup/signup_view_model.dart'
    as _i36;
import '../api/api_services.dart' as _i124;
import '../api/dio_factory.dart' as _i1008;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioFactory = _$DioFactory();
    gh.lazySingleton<_i361.Dio>(() => dioFactory.dio());
    gh.factory<_i124.ApiService>(() => _i124.ApiService(gh<_i361.Dio>()));
    gh.factory<_i432.AuthRemoteDataSource>(
      () => _i219.AuthRemoteDataSourceImpl(gh<_i124.ApiService>()),
    );
    gh.factory<_i776.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i432.AuthRemoteDataSource>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i776.AuthRepository>()),
    );
    gh.factory<_i825.ResetPasswordUseCase>(
      () => _i825.ResetPasswordUseCase(gh<_i776.AuthRepository>()),
    );
    gh.factory<_i229.SignupUseCase>(
      () => _i229.SignupUseCase(gh<_i776.AuthRepository>()),
    );
    gh.factory<_i526.LoginViewModel>(
      () => _i526.LoginViewModel(loginUseCase: gh<_i37.LoginUseCase>()),
    );
    gh.factory<_i36.SignupViewModel>(
      () => _i36.SignupViewModel(signupUseCase: gh<_i229.SignupUseCase>()),
    );
    gh.factory<_i903.ResetPasswordViewModel>(
      () => _i903.ResetPasswordViewModel(
        resetPasswordUseCase: gh<_i825.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioFactory extends _i1008.DioFactory {}
