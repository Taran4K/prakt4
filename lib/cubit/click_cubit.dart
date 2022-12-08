import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

bool LightMode = true;

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  double count = 0;
  List<String> history = [];
  void onClick(int num, String operation) {
    switch (operation) {
      case '+':
        count += num;
        break;
      case '-':
        count -= num;
        break;
      case '*':
        count = count * num;
        break;
      case '/':
        count = count / num;
        break;
    }
    if (LightMode) history.add(count.round().toString() + " Светлана");
    else history.add(count.round().toString() + " Дарт вейдер");
    emit(Click(count.round(), history));
  }
}

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(isDarkThemeOff: LightMode));

  void toggleSwitch(bool? value) {
    if (LightMode) {
      LightMode = false;
    } else {
      LightMode = true;
    }
    emit(state.copyWith(changeState: value));
  }
}
