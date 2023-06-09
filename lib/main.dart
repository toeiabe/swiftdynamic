import 'package:flutter/material.dart';
import 'package:swift/presentation/bloc/data_bloc/data_bloc.dart';
import 'package:swift/presentation/bloc/province_bloc/province_bloc.dart';
import 'package:swift/presentation/pages/contact_list.dart';
import 'package:swift/presentation/pages/detail_page.dart';
import 'package:swift/presentation/pages/form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => DataBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const ContactList(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/formpage': (context) => const FormPage(),
          '/detailpage': (context) => const DetailPage()
        },
      ),
    );
  }
}
