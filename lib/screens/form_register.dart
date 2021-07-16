import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/domain/user_domain.dart';
import 'package:sekolahku/service/app_service.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({Key key}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
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
                    onRegister();
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
                        'REGISTER',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRegister() {
    if (usernameController.text.length > 0) {
      if (passwordController.text.length > 0) {
        UserDomain userDomain = UserDomain();
        userDomain.email    = usernameController.text.toString();
        userDomain.password = passwordController.text.toString();

        AppServices.getUserService.getEmail(usernameController.text.toString()).then((value){
          if(value==null){
            AppServices.getUserService.createUser(userDomain).then((valueCreate){
              Navigator.pop(context);
            }).catchError((error){
              print(error);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Akun tersebut telah terdaftar')));
          }
        }).catchError((error){
          print('error reg'+error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register gagal, periksa user anda dengan benar')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anda belum mengisi password')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anda belum mengisi email')));
    }
  }
}
