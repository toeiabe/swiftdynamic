import 'package:flutter/material.dart';

import '../../domain/entites/user_entity.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดของ ${args.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("ชื่อ: ${args.name}"),
            Text("ชื่อเล่น: ${args.nickName}"),
            Text("เบอร์: ${args.phoneNumber}"),
            Text("อีเมล: ${args.email}"),
            SizedBox(
              height: 20,
            ),
            Text("ที่อยู่"),
            Text(
                "บ้านเลขที่ ${args.houseNumber} ซอย ${args.soi} ถนน ${args.road} ตำบล ${args.tambon} อำเภอ ${args.amphure} จังหวัด ${args.province} รหัสไปรษณีย์ ${args.zipcode}"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/");
                },
                child: Text("กลับ"))
          ],
        ),
      ),
    );
  }
}
