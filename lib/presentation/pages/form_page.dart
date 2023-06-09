import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/domain/entites/user_entity.dart';
import 'package:swift/presentation/bloc/data_bloc/data_bloc.dart';
import 'package:swift/presentation/bloc/province_bloc/province_bloc.dart';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
GlobalKey<FormState> _addressKey = GlobalKey<FormState>();

final _housenumberController = TextEditingController();
final _soiController = TextEditingController();
final _roadController = TextEditingController();

final _nameController = TextEditingController();
final _nicknameController = TextEditingController();
final _phoneController = TextEditingController();
final _emailController = TextEditingController();

String? provinceValue = null;
String? amphureValue = null;
String? tambonValue = null;
String? zipcodeValue = null;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    _housenumberController.clear();
    _soiController.clear();
    _roadController.clear();
    _nameController.clear();
    _nicknameController.clear();
    _phoneController.clear();
    _emailController.clear();

    provinceValue = null;
    amphureValue = null;
    tambonValue = null;
    zipcodeValue = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กรุณากรอกข้อมูล'),
      ),
      body: StepperExample(),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index == 0) {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _index += 1;
            });
          }
        } else if (_index == 1) {
          if (_addressKey.currentState!.validate()) {
            print('${_nameController.text}'
                '${_nicknameController.text}'
                '${_phoneController.text}'
                '${_emailController.text}'
                '${_housenumberController.text}'
                '${_soiController.text}'
                '${_roadController.text}'
                '${provinceValue}'
                '${amphureValue}'
                '${tambonValue}'
                '${zipcodeValue}');
            context.read<DataBloc>().add(AddData(
                user: User(
                    _nameController.text,
                    _nicknameController.text,
                    _phoneController.text,
                    _emailController.text,
                    _housenumberController.text,
                    _soiController.text,
                    _roadController.text,
                    provinceValue!,
                    amphureValue!,
                    tambonValue!,
                    zipcodeValue!)));
            Navigator.of(context).pushReplacementNamed("/");
          }
        }
      },
      steps: <Step>[
        Step(
          title: const Text('ข้อมูลส่วนตัว'),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text('กรุณากรอกข้อมูลส่วนตัว'), MyCustomForm()],
            ),
          ),
        ),
        const Step(
          title: Text('ที่อยู่ตามบัตรประชาชน'),
          content: AddressForm(),
        ),
      ],
    );
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "ชื่อ-นามสกุล"),
            controller: _nameController,
            // The validator receives the text that the user has entered.
            validator: validateName,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "ชื่อเล่น"),
            controller: _nicknameController,
            // The validator receives the text that the user has entered.
            validator: validateName,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "เบอร์โทร"),
            controller: _phoneController,

            // The validator receives the text that the user has entered.
            validator: validateMobile,
          ),
          TextFormField(
              decoration: InputDecoration(labelText: "อีเมล"),
              controller: _emailController,

              // The validator receives the text that the user has entered.
              validator: validateEmail),
        ],
      ),
    );
  }
}

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  AddressFormState createState() {
    return AddressFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddressFormState extends State<AddressForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProvinceBloc>().add(ProvinceQuery());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _addressKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "บ้านเลขที่ "),
            controller: _housenumberController,
            // The validator receives the text that the user has entered.
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "ซอย"),
            controller: _soiController,

            // The validator receives the text that the user has entered.
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "ถนน"),
            controller: _roadController,

            // The validator receives the text that the user has entered.
          ),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              if (state is ProvinceLoading) {
                return CircularProgressIndicator();
              } else if (state is ProvinceHasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text("เลือกจังหวัด"),
                    ),
                    DropdownButton<String>(
                      value: provinceValue,
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
                          provinceValue = value!;
                          amphureValue = null;
                          tambonValue = null;
                          zipcodeValue = null;
                        });
                      },
                      items: state.provinceEntity
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value.nameTh,
                          child: Text(value.nameTh),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text("เลือกอำเภอ"),
                    ),
                    provinceValue == null
                        ? Text("กรุณาเลือกจังหวัดก่อน")
                        : DropdownButton<String>(
                            value: amphureValue,
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
                                amphureValue = value!;
                                tambonValue = null;
                                zipcodeValue = null;
                              });
                            },
                            items: state.provinceEntity
                                .where((element) =>
                                    element.nameTh == provinceValue)
                                .first
                                .amphure
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.nameTh,
                                child: Text(value.nameTh),
                              );
                            }).toList(),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text("เลือกตำบล"),
                    ),
                    amphureValue == null
                        ? Text("กรุณาเลือกอำเภอก่อน")
                        : DropdownButton<String>(
                            value: tambonValue,
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
                                tambonValue = value!;
                                zipcodeValue = state.provinceEntity
                                    .where((element) =>
                                        element.nameTh == provinceValue)
                                    .first
                                    .amphure
                                    .where((element) =>
                                        element.nameTh == amphureValue)
                                    .first
                                    .tambon
                                    .where((element) =>
                                        element.nameTh == tambonValue)
                                    .first
                                    .zipcode
                                    .toString();
                              });
                            },
                            items: state.provinceEntity
                                .where((element) =>
                                    element.nameTh == provinceValue)
                                .first
                                .amphure
                                .where(
                                    (element) => element.nameTh == amphureValue)
                                .first
                                .tambon
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.nameTh,
                                child: Text(value.nameTh),
                              );
                            }).toList(),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text("รหัสไปรษณีย์"),
                    ),
                    tambonValue == null
                        ? Text("กรุณาเลือกตำบลก่อน")
                        : Text(state.provinceEntity
                            .where((element) => element.nameTh == provinceValue)
                            .first
                            .amphure
                            .where((element) => element.nameTh == amphureValue)
                            .first
                            .tambon
                            .where((element) => element.nameTh == tambonValue)
                            .first
                            .zipcode
                            .toString())
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

String? validateName(String? value) {
  if (value == null) {
    return 'Please enter some text';
  }
  if (value.length < 3) {
    return 'Name must be more than 2 charater';
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
  if (value == null) {
    return 'Please enter some text';
  }
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

String? validateEmail(String? value) {
  if (value == null) {
    return 'Please enter some text';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
