import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/providers/user_provider.dart';
import 'package:roaia/screen/Forget_Password.dart';
import 'package:roaia/screen/botton_bar.dart';
import 'package:roaia/screen/sign_Up.dart';
import 'package:roaia/services/api.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    tr("Roaia", context),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff1363DF)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  tr("login", context),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xff1363DF)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  tr("mail", context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    //check if valid mail
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: tr("email", context),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tr("password", context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: tr("epassword", context),
                      suffixIcon: const Icon(Icons.visibility_outlined),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Forget_Password_Screen(),
                    ));
                  },
                  child: Text(
                    tr("forget", context),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff5095FF)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .90,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xff2C67FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const Botton_Bar(),
                      // ));

                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      Api.login(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value.success) {
                          Provider.of<UserProvider>(context, listen: false)
                              .setUser(value.data!);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Botton_Bar(),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value.error!),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      tr("Login", context),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/google.png',
                        scale: 0.8,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/facebook.png',
                        color: Colors.blue,
                        scale: 0.7,
                      ),
                    ),
                    Container(
                      child: Image.asset('assets/images/twitter.png', scale: 1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr("have", context),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff626C83)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Sign_Up_Screen(),
                        ));
                      },
                      child: Text(
                        tr("account", context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xff007AFF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
