import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FileUploadScreen(),
    );
  }
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  double _progress = 0.0;
  bool _isUploading = false;
  bool _buttonTapped = false;

  void _simulateUpload() {
    setState(() {
      _progress = 0.0;
      _isUploading = true;
    });

    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _progress += 0.1;
        if (_progress >= 1.0) {
          timer.cancel();
          _isUploading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File uploaded successfully!")),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Upload & Animated Button"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isUploading ? null : _simulateUpload,
              child: Text("Upload File"),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTapDown: (_) {
                setState(() => _buttonTapped = true);
              },
              onTapUp: (_) {
                setState(() => _buttonTapped = false);
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Animated Button Pressed!")),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _buttonTapped ? 70 : 100,
                height: _buttonTapped ? 40 : 50,
                decoration: BoxDecoration(
                  color: _buttonTapped ? Colors.blueAccent : Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Tap Me",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
