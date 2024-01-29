import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/tasks/blocs/localization_bloc.dart';
import 'features/tasks/blocs/task_bloc.dart';
import 'features/tasks/data/localization/app_localizations.dart';
import 'features/tasks/data/repositories/task_repository.dart';
import 'features/tasks/presentation/screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  print('Initializing LocalizationBloc');
  final localizationBloc = LocalizationBloc();

  try {
    final box = await Hive.openBox<String>('localeBox');
    print('Locale box opened successfully');
    final savedLocale = box.get('selectedLocale', defaultValue: 'en_US');
    print('Saved Locale: $savedLocale');
  } catch (error) {
    print('Hive initialization error: $error');
  }

  runApp(MyApp(localizationBloc: localizationBloc));
}

class MyApp extends StatelessWidget {
  final LocalizationBloc localizationBloc;

  const MyApp({Key? key, required this.localizationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (context) => localizationBloc,
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(TaskRepository()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => AppLocalizations(),
        builder: (context, child) {
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, state) {
              print('MyApp BlocBuilder: $state');
              return MaterialApp(
                title: 'Task Manager',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ru', 'RU'),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                home: TaskScreen(),
              );
            },
          );
        },
      ),
    );
  }
}