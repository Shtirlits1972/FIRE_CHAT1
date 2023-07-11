import 'package:fire_chat/Forms/register_form.dart';
import 'package:fire_chat/Forms/chat_forms.dart';
import 'package:fire_chat/Forms/sign_in_form.dart';
import 'package:fire_chat/block/user_chat_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final DataCubitChat chatCubit = DataCubitChat(KeeperChat());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const SignInForm(),
          ),
        );

      case '/Register':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const RegisterForm(),
          ),
        );

      case '/ChatForms':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const ChatForms(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const SignInForm(),
          ),
        );
    }
  }
}
