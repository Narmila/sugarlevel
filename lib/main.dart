import 'package:flutter/material.dart';

void main() {
  runApp(BloodSugarMonitorApp());
}

class BloodSugarMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Sugar Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController beforeController = TextEditingController();
  TextEditingController afterController = TextEditingController();

  void _navigateToInfoScreen() {
    double? before = double.tryParse(beforeController.text);
    double? after = double.tryParse(afterController.text);
    if (before != null && after != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(
            before: before,
            after: after,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter valid blood sugar values.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Monitor'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/g.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: beforeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Before Meal (mg/dL)'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: afterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'After Meal (mg/dL)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToInfoScreen,
                child: Text('Show Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  final double before;
  final double after;

  InfoScreen({required this.before, required this.after});

  String _getCategory() {
    if (before >= 80 && before <= 130) {
      if (after < 180) {
        return 'Normal (Adults with type 1 diabetes)';
      } else {
        return 'Abnormal (Adults with type 1 diabetes)';
      }
    } else if (before >= 90 && before <= 130) {
      if (before >= 90 && before <= 130){
        return 'Normal (Children with type 1 diabetes )';
      } else {
        return 'Abnormal (Children with type 1 diabetes )';
      }
    } else if (before < 95) {
      if (after == 140) {
        return 'Normal (Pregnant people )';
      } else {
        return 'Abnormal (Pregnant people )';
      }
    } else if (before >= 80 && before <= 180) {
      if (before >= 80 && before <= 180) {
        return 'Normal (65 or older )';
      } else {
        return 'Abnormal (65 or older )';
      }
    } else if (before <= 99) {
      if (after <= 140) {
        return 'Normal (Without diabetes)';
      } else {
        return 'Abnormal (Without diabetes)';
      }
    }
    return 'Abnormal';
  }

  @override
  Widget build(BuildContext context) {
    String category = _getCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Information'),
      ),
      body: Container(
        color: Color.fromARGB(255, 160, 212, 216), // Setting background color to pink
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Blood Sugar Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Image.asset('assets/y.png'),
                SizedBox(height: 20),
                Text('Before Meal: $before mg/dL'),
                Text('After Meal: $after mg/dL'),
                SizedBox(height: 20),
                Text('Category: $category', style: TextStyle(color: Color.fromARGB(255, 161, 68, 61))), // Setting text color to red
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageScreen(),
                      ),
                    );
                  },
                  child: Text('information'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Sugar chart',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(101, 233, 16, 0),
          ),
        ),
      ),
      body: Center(
        child: Image.asset('assets/sugar.png'),
      ),
    );
  }
}
