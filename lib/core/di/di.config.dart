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

import '../../features/account/data/data_sources/profile_remote_data_source.dart'
    as _i64;
import '../../features/account/data/data_sources/profile_remote_data_source_impl.dart'
    as _i684;
import '../../features/account/data/models/ProfileResponse.dart' as _i321;
import '../../features/account/data/repository/profile_repository.dart'
    as _i307;
import '../../features/account/data/repository/profile_repository_impl.dart'
    as _i560;
import '../../features/account/presentation/manager/edit_profile_cubit/edit_profile_view_model.dart'
    as _i362;
import '../../features/account/presentation/manager/profile_cubit/profile_view_model.dart'
    as _i987;
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
import '../../features/browse/data/data_sources/movie_remote_data_source.dart'
    as _i651;
import '../../features/browse/data/data_sources/movie_remote_data_source_impl.dart'
    as _i150;
import '../../features/browse/data/repository/movie_repository.dart' as _i345;
import '../../features/browse/data/repository/movie_repository_impl.dart'
    as _i472;
import '../../features/browse/presentation/manager/movie_view_model.dart'
    as _i582;
import '../../features/movie_details/data/data_sources/remote/favourite/favourite_remote_data_source.dart'
    as _i371;
import '../../features/movie_details/data/data_sources/remote/favourite/impl/favourite_remote_data_source_impl.dart'
    as _i391;
import '../../features/movie_details/data/data_sources/remote/movie_details/impl/movie_details_remote_data_source_impl.dart'
    as _i913;
import '../../features/movie_details/data/data_sources/remote/movie_details/movie_details_remote_data_source.dart'
    as _i960;
import '../../features/movie_details/data/repository/favourite/favourite_respository_impl.dart'
    as _i781;
import '../../features/movie_details/data/repository/movie_details/movie_repository_impl.dart'
    as _i521;
import '../../features/movie_details/domain/repository/favourite/favourite_respository.dart'
    as _i355;
import '../../features/movie_details/domain/repository/movie_details/movie_repository.dart'
    as _i885;
import '../../features/movie_details/domain/usecases/favourite/add_to_fav_use_case.dart'
    as _i253;
import '../../features/movie_details/domain/usecases/favourite/del_from_fav_use_case.dart'
    as _i849;
import '../../features/movie_details/domain/usecases/favourite/get_all_fav_use_case.dart'
    as _i300;
import '../../features/movie_details/domain/usecases/favourite/is_fav_use_case.dart'
    as _i747;
import '../../features/movie_details/presentation/manager/favourite/favourite_view_model.dart'
    as _i597;
import '../../features/movie_details/presentation/manager/movie_details/movie_details_view_model.dart'
    as _i377;
import '../api/api_services.dart' as _i124;
import '../api/dio_factory.dart' as _i1008;
import '../services/secure_storage.dart' as _i451;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioFactory = _$DioFactory();
    gh.lazySingleton<_i361.Dio>(() => dioFactory.dio());
    gh.lazySingleton<_i451.SecureStorage>(() => _i451.SecureStorage());
    gh.factory<_i124.ApiService>(() => _i124.ApiService(gh<_i361.Dio>()));
    gh.factory<_i960.MovieDetailsRemoteDataSource>(
      () => _i913.MovieDetailsRemoteDataSourceImpl(gh<_i124.ApiService>()),
    );
    gh.factory<_i64.ProfileRemoteDataSource>(
      () => _i684.ProfileRemoteDataSourceImpl(
        apiService: gh<_i124.ApiService>(),
        secureStorage: gh<_i451.SecureStorage>(),
      ),
    );
    gh.factory<_i885.MovieDetailsRepository>(
      () => _i521.MovieDetailsRepositoryImpl(
        movieDetailsRemote: gh<_i960.MovieDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i307.ProfileRepository>(
      () => _i560.ProfileRepositoryImpl(
        remoteDataSource: gh<_i64.ProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i371.FavouriteRemoteDataSource>(
      () => _i391.FavouriteRemoteDataSourceImpl(gh<_i124.ApiService>()),
    );
    gh.factory<_i987.ProfileViewModel>(
      () => _i987.ProfileViewModel(
        profileRepository: gh<_i307.ProfileRepository>(),
        secureStorage: gh<_i451.SecureStorage>(),
      ),
    );
    gh.factory<_i651.MovieRemoteDataSource>(
      () => _i150.MovieRemoteDataSourceImpl(gh<_i124.ApiService>()),
    );
    gh.factory<_i432.AuthRemoteDataSource>(
      () => _i219.AuthRemoteDataSourceImpl(gh<_i124.ApiService>()),
    );
    gh.factory<_i355.FavouriteRespository>(
      () =>
          _i781.FavouriteRespositoryImpl(gh<_i371.FavouriteRemoteDataSource>()),
    );
    gh.factoryParam<
      _i362.EditProfileViewModel,
      _i321.ProfileResponse?,
      dynamic
    >(
      (initialProfileData, _) => _i362.EditProfileViewModel(
        profileRepository: gh<_i307.ProfileRepository>(),
        initialProfileData: initialProfileData,
        secureStorage: gh<_i451.SecureStorage>(),
      ),
    );
    gh.factory<_i776.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i432.AuthRemoteDataSource>()),
    );
    gh.factory<_i345.MovieRepository>(
      () => _i472.MovieRepositoryImpl(
        movieRemote: gh<_i651.MovieRemoteDataSource>(),
      ),
    );
    gh.factory<_i253.AddToFavUseCase>(
      () => _i253.AddToFavUseCase(gh<_i355.FavouriteRespository>()),
    );
    gh.factory<_i849.DelFromFavUseCase>(
      () => _i849.DelFromFavUseCase(gh<_i355.FavouriteRespository>()),
    );
    gh.factory<_i300.GetAllFavUseCase>(
      () => _i300.GetAllFavUseCase(gh<_i355.FavouriteRespository>()),
    );
    gh.factory<_i747.IsFavUseCase>(
      () => _i747.IsFavUseCase(gh<_i355.FavouriteRespository>()),
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
    gh.factory<_i597.FavouriteViewModel>(
      () => _i597.FavouriteViewModel(
        gh<_i253.AddToFavUseCase>(),
        gh<_i849.DelFromFavUseCase>(),
        gh<_i747.IsFavUseCase>(),
      ),
    );
    gh.factory<_i377.MovieDetailsViewModel>(
      () => _i377.MovieDetailsViewModel(
        movieDetailsRepo: gh<_i885.MovieDetailsRepository>(),
        movieRepo: gh<_i345.MovieRepository>(),
      ),
    );
    gh.factory<_i582.MovieViewModel>(
      () => _i582.MovieViewModel(movieRepo: gh<_i345.MovieRepository>()),
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
