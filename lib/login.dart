import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'utils/constants.dart';
import 'widgets/loading_indicator.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  bool _obsecurePassword=true;

  var email;
  var password;

  final _globalKeyScaffold=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.orange,
      key: _globalKeyScaffold,
      //appBar: AppBar(title: Text('NOTES',style: TextStyle(fontSize: 40, color: Colors.pink))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(icon: Icon(Icons.mail),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    labelText: 'Email'

                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(icon: Icon(Icons.lock_rounded),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    labelText: 'Password',
                    suffixIcon:IconButton(icon:(_obsecurePassword ? Icon(Icons.visibility):Icon(Icons.visibility_off)),
                      onPressed:(){
                        setState(() {
                          _obsecurePassword=!_obsecurePassword;
                        });
                      },)
                ),
                obscureText: _obsecurePassword,

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 20, 10),
                child: FlatButton(
                  color: Colors.white,
                  textColor: Colors.pink,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    email = emailController.text;
                    password=passwordController.text;
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ){
                      showSnackBar("All fields are required !!!");
                    }else{
                      loginUser();

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    }
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 20, 10),
                child: Row(children: <Widget>[
                  Text('Dont have an account ? '),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SignUp()),
                      // );
                      Navigator.pushNamed(context, "signUp");
                    },
                  )
                ],),
              )
            ],
          ),
        ),
      ),

    );
  }
  void showSnackBar(String message){
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message),
    );
    _globalKeyScaffold.currentState.showSnackBar(snackBar);
  }
  void loginUser() async {
    onLoading(context);
    var url ="$LOGIN_URL?email=$email&password=$password";
    var response = await http.get(url);
    Navigator.pop(context);
    if (response.body.contains("Login")){
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      //showSnackBar("Login Successful");
    }else{
      showSnackBar("Invalid Email or Password ! Please Try Again");
    }
  }
  void saveEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(email, email);
  }
}
