import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestory_web/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mile Story"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _signInFormKey,
              child: SizedBox(
                width: 40.w,
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Logowanie', style: TextStyle(fontSize: 30)),
                    SizedBox(
                        width: 20.w,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Podaj adres email',
                            border: OutlineInputBorder(),
                          ),
                        )),
                    SizedBox(
                        width: 20.w,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Podaj hasło',
                            border: OutlineInputBorder(),
                          ),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInEvent(context: context, email: _emailController.text, password: _passwordController.text));
                      },
                      child: const Text("zaloguj się"),
                    )
                  ],
                ),
              ),
            ),
            Form(
              key: _signUpFormKey,
              child: Container(
                width: 40.w,
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Rejestracja', style: TextStyle(fontSize: 30)),
                    SizedBox(
                        width: 20.w,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Podaj adres email',
                            border: OutlineInputBorder(),
                          ),
                        )),
                    SizedBox(
                        width: 20.w,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Podaj hasło',
                            border: OutlineInputBorder(),
                          ),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignUpEvent(context: context, email: _emailController.text, password: _passwordController.text));
                      },
                      child: const Text("Zarejestruj się"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('token');
                      },
                      child: const Text("Wyloguj się"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
