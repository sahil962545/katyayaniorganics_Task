import 'package:flutter/material.dart';
import '../../../configs/routes/routes_name.dart'; // Importing the route names
import '../../../services/storage/local_storage.dart'; // Importing the LocalStorage class for managing local storage
class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocalStorage localStorage = LocalStorage();
        localStorage.clearValue('token').then((value) {
          localStorage.clearValue('isLogin');
          Navigator.pushNamed(context, RoutesName.login); // Navigating to the login screen after clearing token and isLogin value
        });
      },
      child: Center(
        child: Text(
         "Logout",
          style: Theme.of(context).textTheme.displayMedium, // Applying displayMedium text style from current theme
        ),
      ),
    );
  }
}
