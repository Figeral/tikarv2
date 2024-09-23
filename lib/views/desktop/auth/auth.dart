import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/app_navigator.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/views/desktop/auth/logIn.dart';
import 'package:tikar/views/desktop/tikar/main_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(125, 219, 208, 219),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: context.width * 0.40,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Image(
                      image: const AssetImage("assets/images/ui3.png"),
                      height: context.height * 0.5,
                      width: context.width * 0.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: context.width * 0.6,
              height: context.height,
              child: Padding(
                padding: EdgeInsets.fromLTRB(context.width * 0.10,
                    context.width * 0.15, context.width * 0.15, 0),
                child: Column(
                  children: [
                    Text(
                      AppStrings.auth["con"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: Login(),
                    ),
                  ],
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
