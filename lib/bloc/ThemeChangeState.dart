import 'package:equatable/equatable.dart';
import 'package:flutter_app/ThemeData/AppTheme.dart';

abstract class ThemeChangeState extends Equatable {
  const ThemeChangeState();
}

class GetThemeState extends ThemeChangeState {
  final AppTheme theme;

  GetThemeState(this.theme);

  @override
  List<Object> get props => [theme];
}

class SetThemeState extends ThemeChangeState {
  final String theme;

  SetThemeState(this.theme);

  @override
  List<Object> get props => [theme];
}
