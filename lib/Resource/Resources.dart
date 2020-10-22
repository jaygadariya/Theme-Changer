import 'package:flutter_app/Providers/ThemeChangeProvider.dart';
import 'package:flutter_app/ThemeData/AppTheme.dart';

class Resources {
  final themeGenerator = ThemeChangeProvider();

  Future<AppTheme> getTheme() => themeGenerator.getTheme();

  setTheme(theme) => themeGenerator.setTheme(theme);
}
