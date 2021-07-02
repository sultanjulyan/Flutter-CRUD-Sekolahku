import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/screens/student/detail_screen.dart';
import 'package:sekolahku/screens/student/form_screen.dart';
import 'package:sekolahku/screens/teacher/teacher_detail_screen.dart';
import 'package:sekolahku/screens/teacher/teacher_form_screen.dart';
import 'package:sekolahku/service/app_service.dart';

class TeacherHomeScreen extends StatefulWidget {
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  List<TeacherDomain> _listTeacher = <TeacherDomain>[];
  String _valueKeyword = '';
  bool _isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Guru...',
                  fillColor: Colors.white,
                  filled: true,
                ),
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    _valueKeyword = value;
                  });
                },
              )
            : Text('Guru'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: _isSearch ? Icon(Icons.close) : Icon(Icons.search),
              onPressed: () {
                if(_isSearch){
                  setState(() {
                    _valueKeyword = '';
                    _isSearch = false;
                  });
                }else{
                  setState(() {
                    _valueKeyword = '';
                    _isSearch = true;
                  });
                }
              })
        ],
      ),
      body: FutureBuilder<List<TeacherDomain>>(
        initialData: _listTeacher,
        future: AppServices.getTeacherService.readTeachers(_valueKeyword),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) ||
              snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data.length > 0) {
            _listTeacher = snapshot.data;
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherDetailScreen(
                        id: _listTeacher[index].idTeacher,
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                leading: Image.asset(_listTeacher[index].gender == 'Pria'
                    ? 'assets/images/pria.png'
                    : 'assets/images/wanita.png'),
                title: Text(_listTeacher[index].fullName),
                trailing: Column(
                  children: [
                    Text(_listTeacher[index].mapel.toUpperCase()),
                    Text(_listTeacher[index].mobilePhone)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
              );
            },
            itemCount: _listTeacher.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TeacherFormScreen(title: 'Tambah Data', isEdit: false),
            ),
          ).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
