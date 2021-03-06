import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/screens/form_register.dart';
import 'package:sekolahku/screens/tab_screen.dart';
import 'package:sekolahku/service/app_service.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/sekolah.png'),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                color: Colors.deepPurple,
                child: RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    onLogin();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => FormRegister()));
                    },
                    child: Text('Daftar di sini!',
                      style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onLogin() {
    if (usernameController.text.length > 0) {
      if (passwordController.text.length > 0) {
        String email    = usernameController.text.toString();
        String password = passwordController.text.toString();

        AppServices.getUserService.getEmail(email).then((value){
          if(value!=null){
            AppServices.getUserService.getLogin(email, password).then((valueLogin){
              if(valueLogin!=null){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TabScreen()));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password salah')));
              }
            }).catchError((error){
              print(error);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login gagal, periksa user anda dengan benar')));
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Akun tersebut belum terdaftar')));
          }
        }).catchError((error){
          print(error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login gagal, periksa user anda dengan benar')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anda belum mengisi password')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anda belum mengisi email')));
    }
  }
}
