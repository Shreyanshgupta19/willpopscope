import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String dataFromSecondScreen = "No data yet";

  void updateData(String newData) {
    setState(() {
      dataFromSecondScreen = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Data from Second Screen: $dataFromSecondScreen'),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the second screen and wait for result

                final result = await Navigator.of(context).push<String>(MaterialPageRoute(builder: (ctx) => SecondScreen() ) );

                // or final result = await Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SecondScreen()),
                // );

                // Update data on the first screen if there's a result
                if (result != null) {
                  updateData(result);
                }
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Retrieve data from the second screen and pop with result
        Navigator.pop(context, controller.text);
        return false; // Prevents the screen from being popped automatically
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Enter Data'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Return data to the first screen when the button is pressed
                  Navigator.pop(context, controller.text);
                },
                child: Text('Update First Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
