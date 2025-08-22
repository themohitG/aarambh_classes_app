import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app_theme.dart';
import 'src/router.dart';
import 'src/state/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Toggle to true after wiring Firebase and adding google-services files.
  const bool USE_FIREBASE = false;

  runApp(const AarambhApp(useFirebase: USE_FIREBASE));
}

class AarambhApp extends StatelessWidget {
  final bool useFirebase;
  const AarambhApp({super.key, required this.useFirebase});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aarambh Classes',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
