import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../appLang/app_languages.dart';
import '../generated/l10n.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context)!.welcomeMessage),
            ElevatedButton(
              onPressed: () {
                final appLanguage =
                    Provider.of<AppLanguage>(context, listen: false);
                if (appLanguage.appLocale.languageCode == 'en') {
                  appLanguage.changeLanguage(const Locale('ar'));
                } else {
                  appLanguage.changeLanguage(const Locale('en'));
                }
              },
              child: Text('Change Language'),
            ),
          ],
        ),
      ),
    );
  }
}
