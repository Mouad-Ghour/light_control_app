import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/room_provider.dart';
import './screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Light Management App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),

        ),
      ),
      home: MainScreen(),
    );
  }
}

