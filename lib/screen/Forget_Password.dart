import 'package:flutter/material.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/OTP.dart';
import 'package:roaia/services/api.dart';

class Forget_Password_Screen extends StatelessWidget {
  Forget_Password_Screen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          tr("fpassword", context),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff1363DF)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              tr("mail_restpassword", context),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff40444C),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'ahmed.asad3988@gmail.com',
                    prefixIcon: Icon(
                      Icons.email,
                      size: 18,
                    ),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xff96A0B6)),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 90,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xff2C67FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  Api.forgotPassword(email: emailController.text).then((value) {
                    if (value.success) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTP_Screen(
                          email: emailController.text,
                        ),
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
                  tr("rpassword", context),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
