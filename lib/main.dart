import 'package:flutter/material.dart';
import 'package:news_app/provider/themesProvider.dart';
import 'package:news_app/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemesProvider(),
      // child: Consumer<ThemesProvider>(
      //   builder: ((context, ThemesProvider notifier, child) {
      //     return MaterialApp(
      //       debugShowCheckedModeBanner: false,
      //       title: "News app",
      //       theme: notifier.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
      //       home: Home(),
      //     );
      //   }),
      // ),
         builder: (context, child) {
        final themeprovider = Provider.of<ThemesProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primaryColor: Colors.white,
          // ),

         // themeMode: themeprovider.themeMode,
     //    themeMode :themeprovider.da,
          theme: themeprovider.darkTheme? MyThemes.darkTheme:MyThemes.lightTheme,
      //    darkTheme: MyThemes.darkTheme,
          home: Home(),
        );
      }
    );

    //   builder: (context, child) {
    //     final themeprovider = Provider.of<ThemesProvider>(context);
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       // theme: ThemeData(
    //       //   primaryColor: Colors.white,
    //       // ),

    //      // themeMode: themeprovider.themeMode,
    //  //    themeMode :themeprovider.da,
    //       theme: MyThemes.lightTheme,
    //   //    darkTheme: MyThemes.darkTheme,
    //       home: Home(),
    //     );
    //   });
  }
}
