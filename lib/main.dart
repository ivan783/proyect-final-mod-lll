import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyect_examen_mod_ll/pages/tabs_page.dart';
import 'package:proyect_examen_mod_ll/services/new_services.dart';
import 'package:proyect_examen_mod_ll/theme/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsServices()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}
