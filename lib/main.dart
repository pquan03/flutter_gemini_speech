import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_gemini_ai/config/helpers/local_storage.dart';
import 'package:winter_gemini_ai/config/theme/theme.dart';
import 'package:winter_gemini_ai/pages/chat/page.dart';
import 'package:winter_gemini_ai/pages/on_boarding/page.dart';
import 'package:winter_gemini_ai/riverpod/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await LocalStorage().initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isFirstTime = LocalStorage().isFirstTime;
    return MaterialApp(
      title: 'Winter Gemini',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      home: isFirstTime ? const OnBoardingPage() : const ChatPage(),
    );
  }
}
