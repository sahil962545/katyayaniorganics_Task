import 'package:bloc_clean_coding/utils/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/invite_bloc/invite_user_bloc.dart';
import '../../main.dart';
import 'widgets/widgets.dart';

class InviteUserScreen extends StatefulWidget {
  const InviteUserScreen({super.key});

  @override
  State<InviteUserScreen> createState() => _InviteUserScreenState();
}

class _InviteUserScreenState extends State<InviteUserScreen> {
  late InviteUserBloc _inviteUserBloc;
  TimeOfDay selectTime = TimeOfDay.now();

  @override
  void initState() {
   _inviteUserBloc = InviteUserBloc(authApiRepository: getIt());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, "Choose Date and Time"),
        body: BlocProvider(
          create: (_) => _inviteUserBloc,
          child: Column(
            children: [TimePicker()],
          ),
        ));
  }
}
