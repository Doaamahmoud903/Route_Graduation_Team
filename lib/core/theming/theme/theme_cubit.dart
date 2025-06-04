// theme_cubit.dart
import 'package:movie_app/core/cach_helper/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const SystemThemeState()) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    try {
      final savedTheme = await CacheHelper().getData('themeMode');
      switch (savedTheme) {
        case 'light':
          emit(const LightThemeState());
          break;
        case 'dark':
          emit(const DarkThemeState());
          break;
        default:
         // emit(const SystemThemeState());
          emit(const DarkThemeState());
      }
    } catch (e) {
      print('Error loading theme: $e');
      //emit(const SystemThemeState());
      emit(const DarkThemeState());
    }
  }

  Future<void> setLightTheme() async {
    await _saveThemePreference('light');
    emit(const LightThemeState());
  }

  Future<void> setDarkTheme() async {
    await _saveThemePreference('dark');
    emit(const DarkThemeState());
  }

  Future<void> setSystemTheme() async {
    await _saveThemePreference('system');
    emit(const SystemThemeState());
  }

  Future<void> toggleTheme() async {
    if (state is LightThemeState) {
      await setDarkTheme();
    } else if (state is DarkThemeState) {
      await setSystemTheme();
    } else {
      await setLightTheme();
    }
  }

  ThemeMode get themeMode => state.themeMode;

  bool get isDarkMode {
    if (state is SystemThemeState) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    }
    return state is DarkThemeState;
  }

  bool get isLightMode {
    if (state is SystemThemeState) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      return brightness == Brightness.light;
    }
    return state is LightThemeState;
  }

  String get currentThemeName {
    if (state is LightThemeState) return 'light';
    if (state is DarkThemeState) return 'dark';
    return 'system';
  }

  Future<void> _saveThemePreference(String theme) async {
    try {
      await CacheHelper().saveData('themeMode', theme);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }
}
