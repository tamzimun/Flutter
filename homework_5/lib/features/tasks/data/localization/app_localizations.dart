import 'package:flutter/material.dart';

class AppLocalizations with ChangeNotifier {
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  String addButtonLabel = '';
  String appBarTitle = '';
  String enterTaskHint = '';
  String noTasksYet = '';
  String selectLanguageDialogTitle = '';
  String englishLanguageOption = '';
  String russianLanguageOption = '';
  String editTaskDialogTitle = '';
  String editTaskHint = '';
  String saveButtonLabel = '';
  String cancelButtonLabel = '';

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<void> load(Locale locale) async {
    print('Load method called with locale: $locale');
    if (locale.languageCode == 'en' || locale.languageCode == 'en_US') {
      addButtonLabel = 'Add Task';
      appBarTitle = 'App Bar Title';
      enterTaskHint = 'Enter Task';
      noTasksYet = 'No Tasks Yet';
      selectLanguageDialogTitle = 'Select Language';
      englishLanguageOption = 'English';
      russianLanguageOption = 'Русский';
      editTaskDialogTitle = 'Edit Task';
      editTaskHint = 'Enter updated task';
      saveButtonLabel = 'Save';
      cancelButtonLabel = 'Cancel';
    } else if (locale.languageCode == 'ru' || locale.languageCode == 'ru_RU') {
      addButtonLabel = 'Добавить задачу';
      appBarTitle = 'Заголовок приложения';
      enterTaskHint = 'Введите задачу';
      noTasksYet = 'Пока нет задач';
      selectLanguageDialogTitle = 'Выберите язык';
      englishLanguageOption = 'English';
      russianLanguageOption = 'Русский';
      editTaskDialogTitle = 'Редактировать задачу';
      editTaskHint = 'Введите обновленную задачу';
      saveButtonLabel = 'Сохранить';
      cancelButtonLabel = 'Отмена';
    }
    print('Translations updated: $this');
    print('Load method completed');

    notifyListeners();
  }

  void notifyListeners() {
    super.notifyListeners();
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'ru_RU', 'en_US'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations();
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}