import 'package:colored_note/color_schemes.dart';
import 'package:colored_note/routing_table.dart';
import 'package:flutter/material.dart';
import 'package:folder_list/folder_list.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const ColoredNoteApp());
}

class ColoredNoteApp extends StatefulWidget {
  const ColoredNoteApp({Key? key}) : super(key: key);

  @override
  State<ColoredNoteApp> createState() => _ColoredNoteAppState();
}

class _ColoredNoteAppState extends State<ColoredNoteApp> {
  final _keyValueStorage = KeyValueStorage();

  late final _folderRepository = FolderRepository(keyValueStorage: _keyValueStorage);

  late final RoutemasterDelegate _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          folderRepository: _folderRepository,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routerDelegate: _routerDelegate,
      routeInformationParser: const RoutemasterParser(),
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        FolderListLocalizations.delegate,
      ],
    );
  }
}
