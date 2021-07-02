import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/utils/capitalize.dart';
import 'package:sekolahku/widgets/custom_checkbox.dart';
import 'package:sekolahku/widgets/custom_radio.dart';

class TeacherFormScreen extends StatefulWidget {
  final String title;
  final bool isEdit;
  final TeacherDomain teacherDomain;

  const TeacherFormScreen({Key key, @required this.title, this.isEdit, this.teacherDomain}) : super(key: key);

  @override
  _TeacherFormScreenState createState() => _TeacherFormScreenState();
}

class _TeacherFormScreenState extends State<TeacherFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender;
  String mapel;
  String birthDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdit){
      firtNameController.text = widget.teacherDomain.firstName;
      lastNameController.text = widget.teacherDomain.lastName;
      mobilePhoneController.text = widget.teacherDomain.mobilePhone;
      addressController.text = widget.teacherDomain.address;
      gender = widget.teacherDomain.gender;
      mapel = widget.teacherDomain.mapel;
      birthDate = widget.teacherDomain.birthDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah data'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                        controller: firtNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Nama Depan',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))))),
                SizedBox(width: 8),
                Expanded(
                    child: TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Nama Belakang',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))))),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: mobilePhoneController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Tidak boleh kosong";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: 'No Hp',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            Text(
              'Jenis Kelamin',
              style: TextStyle(color: Colors.blue),
            ),
            Row(
              children: TeacherDomain.genders
                  .map((e) => CustomRadio(
                        activeColor: Colors.amber,
                        value: e,
                        label: capitalize(e),
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              items: TeacherDomain.mapelList
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              value: mapel,
              onChanged: (value) {
                setState(() {
                  mapel = value;
                });
              },
              isExpanded: true,
              hint: Text("Pilih Mata Pelajaran"),
            ),
            SizedBox(height: 10),
            Text('Tanggal Lahir', style: TextStyle(color: Colors.blue)),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              height: 37,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context, showTitleActions: true,
                      onChanged: (date) {
                        print('change $date');
                      },
                      onConfirm: (date) {
                        setState(() {
                          birthDate = DateFormat("dd MMMM yyyy")
                              .format(date)
                              .toString();
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en);
                },
                child: Text(
                  birthDate,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState.validate()){
            TeacherDomain teacherDomain = TeacherDomain();
            teacherDomain.address = addressController.text.trim();
            teacherDomain.birthDate = birthDate;
            teacherDomain.mapel = mapel;
            teacherDomain.gender = gender;
            teacherDomain.mobilePhone = mobilePhoneController.text.trim();
            teacherDomain.lastName = lastNameController.text.trim();
            teacherDomain.firstName = firtNameController.text.trim();

            if(widget.isEdit){
              AppServices.getTeacherService.updateTeacher(widget.teacherDomain.idTeacher, teacherDomain).then((value){
                Navigator.pop(context);
              }).catchError((error){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
            }else{
              AppServices.getTeacherService.createTeachers(teacherDomain).then((value){
                Navigator.pop(context);
              }).catchError((error){
                print(error);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
            }
          }else{
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Silahkan isi"))
            );
          }
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
