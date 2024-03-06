import 'package:clean_arch_news_flutter/features/news/presentation/pages/home_page.dart';
import 'package:clean_arch_news_flutter/features/news/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'features/news/presentation/di/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(600, 800),
    maximumSize: Size(700, 900),
    size: Size(600,800),
    center: true,
    title: "News"
  );
  windowManager.waitUntilReadyToShow(windowOptions,() async {
    await windowManager.show();
    await windowManager.focus();
  });
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: Provider.of<ThemeProvider>(context).currentTheme,
      ),
    );
  }
}
