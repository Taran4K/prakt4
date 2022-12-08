part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickError extends ClickState {
  final String message;

  ClickError(this.message);
}

class Click extends ClickState {
  int count;
  List<String> history;
  Click(this.count, this.history);
}

class SwitchInitial extends ClickState {}

class SwitchState {
  bool isDarkThemeOff;
  ThemeData theme = ThemeData(brightness: Brightness.dark);
  SwitchState({required this.isDarkThemeOff}) {
    if (isDarkThemeOff) {
      theme = ThemeData(brightness: Brightness.light);
    } else {
      theme = ThemeData(brightness: Brightness.dark);
    }
  }

  SwitchState copyWith({bool? changeState}) {
    return SwitchState(isDarkThemeOff: changeState ?? isDarkThemeOff);
  }
}