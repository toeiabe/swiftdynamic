import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:swift/data/datasource/remote_datasource.dart';
import 'package:swift/data/repositories/province_repository_impl.dart';
import 'package:swift/domain/usecases/provinces_usecase.dart';
import 'package:swift/presentation/bloc/data_bloc/data_bloc.dart';
import 'package:swift/presentation/bloc/province_bloc/province_bloc.dart';
import 'package:swift/presentation/pages/form_page.dart';

import '../../domain/entites/user_entity.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(("/formpage"));
                },
                child: Text("เพิ่มรายชื่อ"))
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "ทั้งหมด",
              ),
              Tab(
                text: "แยกตามจังหวัด",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[AllContact(), ProvinceContact()],
        ),
      ),
    );
  }
}

class AllContact extends StatelessWidget {
  const AllContact({super.key});

  showAlertDialog(BuildContext context, User user) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("ลบ"),
      onPressed: () {
        context.read<DataBloc>().add(DeleteData(user: user));
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("ไม่ลบ"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("แน่ใจนะ"),
      content: Text("คุณแน่ใจนะว่าต้องการลบรายชื่อ!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        var users = state.users;
        return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].province),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              "/detailpage",
                              arguments: users[index]);
                        },
                        child: Text("แสดงรายละเอียด")),
                    ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context, users[index]);
                        },
                        child: Text("ลบ"))
                  ],
                ),
              );
            });
      },
    );
  }
}

class ProvinceContact extends StatefulWidget {
  const ProvinceContact({super.key});

  @override
  State<ProvinceContact> createState() => _ProvinceContactState();
}

class _ProvinceContactState extends State<ProvinceContact> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProvinceBloc>().add(ProvinceQuery());

    super.initState();
  }

  String? dropdownValue = null;
  List selectedProvince = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProvinceBloc, ProvinceState>(
      builder: (context, provincestate) {
        if (provincestate is ProvinceLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provincestate is ProvinceHasData) {
          return BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              selectedProvince = state.users
                  .where((element) => element.province == dropdownValue)
                  .toList();
              return Column(
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: provincestate.provinceEntity
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.nameTh,
                        child: Text(value.nameTh),
                      );
                    }).toList(),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedProvince.length,
                      itemBuilder: (context, index) {
                        return selectedProvince.length == 0
                            ? Center(child: Text("Not found"))
                            : ListTile(
                                title: Text(selectedProvince[index].name),
                                subtitle:
                                    Text(selectedProvince[index].province),
                              );
                      })
                ],
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
