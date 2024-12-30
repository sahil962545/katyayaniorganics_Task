import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login_bloc/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget representing the password input field.
class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2
              )
            ),
            icon: const Icon(Icons.lock),  
            helperText: AppLocalizations.of(context)!.passwordShouldbeatleast_characterswithatleastoneletterandnumber, 
            helperMaxLines: 2, 
            labelText: AppLocalizations.of(context)!.password, 
            errorMaxLines: 2, 
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            if (value.length < 6) {
              return 'please enter password greater than 6 char';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
