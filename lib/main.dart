import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/models/fs_models.dart';
import 'package:stock_hours/nav_bar.dart';
import 'package:stock_hours/services/firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (_) => FirestoreService().streamMarkets(),
          initialData: MarketList(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavBar(),
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: CupertinoColors.activeBlue,
            onPrimary: Colors.white,
            secondary: CupertinoColors.systemGrey,
            onSecondary: Colors.black,
            error: CupertinoColors.destructiveRed,
            onError: Colors.black,
            background: CupertinoColors.white,
            onBackground: Colors.black,
            surface: CupertinoColors.systemGrey,
            onSurface: Colors.black,
            inversePrimary: CupertinoColors.darkBackgroundGray,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: CupertinoColors.activeBlue,
            onPrimary: Colors.white,
            secondary: CupertinoColors.systemGrey,
            onSecondary: Colors.black,
            error: CupertinoColors.destructiveRed,
            onError: Colors.black,
            background: CupertinoColors.darkBackgroundGray,
            onBackground: Colors.white,
            surface: CupertinoColors.white,
            onSurface: Colors.black,
            inversePrimary: Colors.white,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
