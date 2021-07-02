import 'package:flutter/material.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/screens/teacher/teacher_form_screen.dart';
import 'package:sekolahku/service/app_service.dart';

class TeacherDetailScreen extends StatefulWidget {
  final int id;

  const TeacherDetailScreen({Key key, this.id}) : super(key: key);

  @override
  _TeacherDetailScreenState createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen> {
  TeacherDomain _teacherDomain;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherFormScreen(
                    title: 'Edit Data',
                    isEdit: true,
                    teacherDomain: _teacherDomain,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.create),
          ),
          IconButton(
            onPressed: () {
              AppServices.getTeacherService
                  .deleteTeacher(widget.id)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
        future: AppServices.getTeacherService.teacherById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }

          _teacherDomain = snapshot.data;

          return ListView(
            children: [
              SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      _teacherDomain.gender == 'Pria'
                          ? "assets/images/pria.png"
                          : "assets/images/wanita.png",
                      height: 100,
                      width: 100),
                ],
              ),
              ListTile(
                leading: Icon(Icons.perm_contact_cal),
                title: Text(_teacherDomain.fullName),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(_teacherDomain.mobilePhone),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.label),
                title: Text(_teacherDomain.gender),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.book),
                title: Text(_teacherDomain.mapel),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(_teacherDomain.birthDate),
              )
            ],
          );
        },
      ),
    );
  }
}
