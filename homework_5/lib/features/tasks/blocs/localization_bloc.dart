import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  late final Box<String> _localeBox;
  late final Completer<void> _hiveCompleter;

  LocalizationBloc() : super(LocalizationInitial()) {
    _hiveCompleter = Completer<void>();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.openBox<String>('localeBox').then((box) {
      _localeBox = box;
      _hiveCompleter.complete();
      final savedLocale = _localeBox.get(
          'selectedLocale', defaultValue: 'en_US');
      if (savedLocale != null) {
        add(ChangeLocalization(locale: Locale(savedLocale)));
        print('savedLocale is: ${savedLocale}');
      }
    }).catchError((error) {
      print('Hive initialization error: $error');
    });
  }


  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event,) async* {
    await _hiveCompleter.future;
    if (event is ChangeLocalization) {
      print('Locale changed to: ${event.locale}');
      _localeBox.put('selectedLocale', event.locale.toString());
      yield LocalizationLoaded(locale: event.locale);
    }
  }
}