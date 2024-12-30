import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../bloc/login_bloc/login_bloc.dart';

/// A widget representing the email input field.
class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.focusNode});

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
                borderSide: BorderSide(color: Colors.black, width: 2)),
            icon: const Icon(Icons.email), // Icon for email input field
            labelText: AppLocalizations.of(context)!
                .email, // Label text for email input field
            helperText: AppLocalizations.of(context)!
                .aCompleteValidEmailExamplejoegmailcom, // Helper text for email input field
          ),
          keyboardType: TextInputType
              .emailAddress, // Setting keyboard type to email address
          onChanged: (value) {
            // Dispatching EmailChanged event when email input changes
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter email';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
