 part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class ChangeLocalization extends LocalizationEvent {
final Locale locale;

   ChangeLocalization({required this.locale});
}