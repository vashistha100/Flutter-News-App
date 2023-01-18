import 'package:flutter/material.dart';

import 'package:news_app/provider/themesProvider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {
  //const ChangeThemeButton({Key? key}) : super(key: key);

  //bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    final themPRovider = Provider.of<ThemesProvider>(context);

    return Switch.adaptive(
        value: themPRovider.darkTheme,
        onChanged: (value) {
          // final provider = Provider.of<ThemesProvider>(context, listen: false);
          // provider.toggleTheme();
          themPRovider.toggleTheme();
        });
  }
}
