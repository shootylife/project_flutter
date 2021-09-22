import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:projet_flutter/screen/sign_in/sign_in.dart';
import 'package:projet_flutter/screen/sign_up/sign_up_form.dart';

class SignUpWeb extends StatelessWidget {
  const SignUpWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 75),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.3)),
              child: Column(children: [
                Image.asset('assets/images/noir.png',
                    height: height * 0.35, fit: BoxFit.fill),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Text("Create\nan account",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SignUpForm(heightArg: 0.09, widthArg: 0.2, padding: 5,),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: width * 0.15,
                  child: const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextButton(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: HexColor('#BEBBC9'))),
                            const TextSpan(
                                text: 'Sign in',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignIn()));
                      }),
                ),
              ])),
        ),
      ),
    );
  }
}
