import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app_theme.dart';
import 'src/router.dart';
import 'src/state/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Toggle to true after wiring Firebase and adding google-services files.
  const bool USE_FIREBASE = false;
  runApp(AarambhApp(useFirebase: USE_FIREBASE));
}

class AarambhApp extends StatelessWidget {
  final bool useFirebase;
  const AarambhApp({super.key, required this.useFirebase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()..bootstrap()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'AARAMBH CLASSES',
        theme: AppTheme.light(),
        routerConfig: buildRouter(),
      ),
    );
  }
}
