part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  ThemeState(this.appTheme);

  final AppTheme appTheme;

  ThemeData get theme => appThemes[appTheme]!;

  @override
  List<Object> get props => [appTheme];
}
