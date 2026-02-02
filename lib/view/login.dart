import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:toko_merch_hmif/controller/userController.dart';
import 'package:toko_merch_hmif/models/user.dart';
import 'package:toko_merch_hmif/view/register.dart';

import 'home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = UserController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Toko Merchandise HMIF", style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }if (!value.endsWith("@gmail.com")) {
                        return "only gmail.com is allowed";
                      }
                      return null;
                    },
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      }
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        userController.LoginUser(
                        User(
                          id: 0,
                          nama: "",
                          email: emailController.text,
                          password: passwordController.text,
                        )
                      ).then((message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message))
                        );
                        if(message == "Login Successful") {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => HomeScreen()
                            )
                          );
                        }
                      });
                      }
                    }, 
                    child: Text("Login")
                  ),
                ],
              )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => RegisterScreen())
                );
              },
              child: Text("Registrasi disini "),
              ),
          ],
        ),
      ),
    );
  }
}