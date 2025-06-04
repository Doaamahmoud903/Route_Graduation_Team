import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/api_services.dart';
import '../langauge_cache_helper/language_cache_helper.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale("en")));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
    await LanguageCacheHelper().getCachedLanguageCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    ApiService.setLanguage(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}