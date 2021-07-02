import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/screens/student/detail_screen.dart';
import 'package:sekolahku/screens/student/form_screen.dart';
import 'package:sekolahku/service/app_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StudentDomain> _listStudent = <StudentDomain>[];
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
                  hintText: 'Cari Siswa...',
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
            : Text('Siswa'),
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
      body: FutureBuilder<List<StudentDomain>>(
        initialData: _listStudent,
        future: AppServices.getStudentService.readStudents(_valueKeyword),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) ||
              snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data.length > 0) {
            _listStudent = snapshot.data;
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: _listStudent[index].idStudent,
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                leading: Image.asset(_listStudent[index].gender == 'Pria'
                    ? 'assets/images/pria.png'
                    : 'assets/images/wanita.png'),
                title: Text(_listStudent[index].fullName),
                trailing: Column(
                  children: [
                    Text(_listStudent[index].grade.toUpperCase()),
                    Text(_listStudent[index].mobilePhone)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
              );
            },
            itemCount: _listStudent.length,
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
                  FormScreen(title: 'Tambah Data', isEdit: false),
            ),
          ).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
