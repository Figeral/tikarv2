import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/utils/app_navigator.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/views/desktop/tikar/main_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  bool isLoding = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  void dispose() {
    setState(() {
      isLoding = false;
    });
    super.dispose();
    usernameController.dispose();
    pwController.dispose();
  }

  final _string = AppStrings.auth;
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: _string["email"][0],
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return _string["email"][1][0];
                  } else if (value.length < 4) {
                    return _string["email"][1][1];
                  } else if (!value.contains("@") || !value.contains(".")) {
                    return _string["email"][1][2];
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextFormField(
                obscureText: isPressed,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_open),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      child: Icon(
                          isPressed ? Icons.visibility : Icons.visibility_off)),
                  hintText: _string["pw"][0],
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: pwController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return _string["pw"][1][0];
                  } else if (value.length < 4) {
                    return _string["pw"][1][1];
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              AppStrings.auth["desc"],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(const Size(300, 60)),
                backgroundColor: WidgetStateProperty.all(AppColors.blue),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //implemention loading logic
                  setState(() {
                    isLoding = true;
                  });

                  //implement login base logic

                  await userCubit.fetchData(
                      usernameController.value.text, pwController.value.text);

                  // ... Navigate To your Home Page
                  if (userCubit.state != null) {
                    AppNavigator.push(context, destination: const MainScreen());
                    print("pushed to next page");
                  }
                }
              },
              child: isLoding
                  ? AppLoader.adaptative()
                  : Text(
                      'Login',
                      style: TextStyle(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

// class something<T> {
//   T data(T e) {
//     if (T is Error) {}
//   }
// }
