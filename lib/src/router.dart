import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/student/home_student.dart';
import 'screens/teacher/home_teacher.dart';
import 'screens/admin/home_admin.dart';

RouterConfig<Object> buildRouter() {
  return RouterConfig(
    routerDelegate: _Delegate(),
    routeInformationParser: _Parser(),
    routeInformationProvider: PlatformRouteInformationProvider(
      initialRouteInformation: const RouteInformation(location: '/splash'),
    ),
  );
}

class _Parser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(RouteInformation routeInformation) async {
    return RouteSettings(name: routeInformation.location);
  }
}

class _Delegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String _path = '/splash';

  @override
  RouteSettings? get currentConfiguration => RouteSettings(name: _path);

  void _setPath(String p) { _path = p; notifyListeners(); }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) async {
    _path = configuration.name ?? '/splash';
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: SplashScreen(onNext: () => _setPath('/onboarding'))),
        if (_path == '/onboarding') MaterialPage(child: OnboardingScreen(onDone: () => _setPath('/login'))),
        if (_path == '/login') MaterialPage(child: LoginScreen(
          onStudent: () => _setPath('/student'),
          onTeacher: () => _setPath('/teacher'),
          onAdmin: () => _setPath('/admin'),
        )),
        if (_path == '/student') const MaterialPage(child: StudentHome()),
        if (_path == '/teacher') const MaterialPage(child: TeacherHome()),
        if (_path == '/admin') const MaterialPage(child: AdminHome()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
