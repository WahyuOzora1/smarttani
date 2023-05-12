import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smarttaniapp/screens/admin/home_admin_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';

class LoginnScreen extends StatefulWidget {
  const LoginnScreen({super.key});

  @override
  State<LoginnScreen> createState() => _LoginnScreenState();
}

class _LoginnScreenState extends State<LoginnScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                height: 230,
                child: Lottie.network(
                    "https://assets5.lottiefiles.com/private_files/lf30_ngencarb.json"),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: const [
                    Text(
                      "Login.",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    Text("Welcome Admin",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: username,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.people,
                            color: Colors.black45,
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          focusColor: primaryColor,
                          hoverColor: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: password,
                          obscureText: true,
                          cursorColor: primaryColor,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.key, color: Colors.black45),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (username.text == "admin" &&
                          password.text == "rahasiaadmin123") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("login Berhasil")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeAdminScreen()));
                      } else {
                        username.clear();
                        password.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Username dan password tidak cocok")));
                      }
                    },
                    child: const Text("Login")),
              )
            ],
          ),
        ),
      )),
    );
  }
}
