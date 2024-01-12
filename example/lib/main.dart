import 'package:easy_localization/easy_localization.dart';
//import 'package:easy_localization_loader/easy_localization_loader.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'generated/locale_keys.g.dart';
import 'lang_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'DZ'),
      Locale('de', 'DE'),
      Locale('ru', 'RU')
    ],
    path: 'resources/langs',
    child: MyApp(),
    // fallbackLocale: Locale('en', 'US'),
    // startLocale: Locale('de', 'DE'),
    // saveLocale: false,
    // useOnlyLangCode: true,

    // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
    // install easy_localization_loader for enable custom loaders
    // assetLoader: RootBundleAssetLoader()
    // assetLoader: HttpAssetLoader()
    // assetLoader: FileAssetLoader()
    // assetLoader: CsvAssetLoader()
    // assetLoader: YamlAssetLoader() //multiple files
    // assetLoader: YamlSingleAssetLoader() //single file
    // assetLoader: XmlAssetLoader() //multiple files
    // assetLoader: XmlSingleAssetLoader() //single file
    // assetLoader: CodegenLoader()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Easy localization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  bool _gender = true;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void switchGender(bool val) {
    setState(() {
      _gender = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.title).tr(
          context: context,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LanguageView(), fullscreenDialog: true),
              );
            },
            child: Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Text(
              LocaleKeys.gender_with_arg,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ).tr(
              args: ['aissat'],
              gender: _gender ? 'female' : 'male',
              context: context,
            ),
            Text(
              tr(
                LocaleKeys.gender,
                gender: _gender ? 'female' : 'male',
                context: context,
              ),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.male),
                Switch(value: _gender, onChanged: switchGender),
                FaIcon(FontAwesomeIcons.female),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Text(LocaleKeys.msg).tr(args: ['aissat', 'Flutter']),
            Text(LocaleKeys.msg_named)
                .tr(namedArgs: {'lang': 'Dart'}, args: ['Easy localization']),
            Text(LocaleKeys.clicked).plural(counter),
            TextButton(
              onPressed: () {
                incrementCounter();
              },
              child: Text(LocaleKeys.clickMe).tr(),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                plural(LocaleKeys.amount, counter,
                    format: NumberFormat.currency(
                        locale: Intl.defaultLocale, symbol: '€')),
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (context.locale == Locale('ar', 'DZ')) {
                  context.setLocale(
                    Locale('en', 'US'),
                  );
                } else {
                  context.setLocale(
                    Locale('ar', 'DZ'),
                  );
                }
              },
              child: Text(LocaleKeys.reset_locale).tr(),
            ),
            Localizations.override(
              context: context,
              locale: Locale('de', 'DE'),
              // Using a Builder to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (context) {
                  // A toy example for an internationalized Material widget.

                  return Column(
                    children: [
                      Text(
                        LocaleKeys.gender_with_arg,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ).tr(
                        args: ['aissat'],
                        gender: _gender ? 'female' : 'male',
                        context: context,
                      ),
                      Text(
                        MaterialLocalizations.of(context)
                            .selectYearSemanticsLabel,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Localizations.override(
              context: context,
              locale: Locale('ru', 'RU'),
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    Text(
                      context.tr(
                        LocaleKeys.gender,
                        gender: _gender ? 'female' : 'male',
                      ),
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppDialog(
                              context: context,
                            );
                          },
                        );
                      },
                      child: Text("show dialog"),
                    ),
                  ],
                );
              }),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: Text('+1'),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppDialog extends StatelessWidget {
  BuildContext context;
  AppDialog({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr(
          LocaleKeys.gender,
          gender: 'male',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            MaterialLocalizations.of(context).selectYearSemanticsLabel,
          ),
          Container(
            width: 200,
            height: 200,
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              onDateChanged: (value) {},
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
