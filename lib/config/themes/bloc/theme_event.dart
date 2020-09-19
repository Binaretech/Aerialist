part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  ThemeChanged(this.theme);

  final AppTheme theme;

  @override
  List<Object> get props => [theme];
}
