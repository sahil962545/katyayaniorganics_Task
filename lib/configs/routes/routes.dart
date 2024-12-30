import 'package:bloc_clean_coding/configs/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../view/views.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
        case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignupScreen());
        case RoutesName.userScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const UserScreen());
        case RoutesName.inviteUser:
        return MaterialPageRoute(builder: (BuildContext context) => const InviteUserScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
