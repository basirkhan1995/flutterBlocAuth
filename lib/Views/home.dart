import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite/Bloc/AuthBloc/auth_bloc.dart';
import 'package:flutter_bloc_sqlite/Views/login.dart';

import '../Constants/env.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is UnAuthenticated){
          Env.gotoReplacement(context, const LoginScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(UnAuthenticatedEvent());
                    },
                    icon: const Icon(Icons.logout))
              ],
              title: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Text(state.users.fullName!);
                    }
                    return Container();
                  }
              )
          ),

          body: const Center(
            child: Text("Hello"),
          ),
        );
      },
    );
  }
}
