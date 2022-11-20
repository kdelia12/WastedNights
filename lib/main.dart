import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wasted Nights'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  //date input controller
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasted Nights'),
      ),
      // 2 padding of name and date of birth
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 3 text field for name
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // 4 text field for date of birth
            TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(FocusNode());

                  // Show Date Picker Here
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  dateController.text = DateFormat('dd-MM-yyyy').format(date!);
                }),
            const SizedBox(
              height: 20,
            ),
            // 5 button to calculate
            ElevatedButton(
              onPressed: () {
                // 6 calculate age
                final night = calculateAge(dateController.text);
                final name = myController.text;
                // 7 show dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Wasted Nights'),
                      content: Text(
                          'Selamat $name, Anda telah membuang $night Hari!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                          //dispose the dialog
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  calculateAge(String text) {
    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    final dateOfBirth = inputFormat.parse(text);
    final today = DateTime.now();
    final age = today.year - dateOfBirth.year;
    final dayinlive = today.difference(dateOfBirth).inDays;
    return dayinlive;
  }
}
