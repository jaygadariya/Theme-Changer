import 'package:equatable/equatable.dart';

abstract class ThemeChangeEvent extends Equatable {
  const ThemeChangeEvent();
}

class GetThemeChangeEvent extends ThemeChangeEvent {
  @override
  List<Object> get props => [];
}

class SetThemeChangeEvent extends ThemeChangeEvent {
  final String theme;

  SetThemeChangeEvent(this.theme);

  @override
  List<Object> get props => [theme];
}
