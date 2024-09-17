import 'package:flutter/material.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      body: Center(
        child: Text(
          userCubit.user?.username ?? "no user in",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }
}
