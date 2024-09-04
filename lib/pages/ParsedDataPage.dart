import 'package:flutter/material.dart';
import 'package:job_task/pages/input_data.dart';
import 'package:job_task/pages/parseAndDisplay.dart';
import 'package:lottie/lottie.dart';
import 'package:job_task/pages/animated_button.dart';

class JsonParserPage extends StatefulWidget {
  @override
  _JsonParserPageState createState() => _JsonParserPageState();
}

class _JsonParserPageState extends State<JsonParserPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> parseAndDisplay(
      BuildContext context, List<dynamic> input) async {
    setState(() {
      _isLoading = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15),
            Text('Parsing data... Please wait'),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );

    await Future.delayed(Duration(seconds: 1));

    final parsedVersions = parseJson(input);

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ParsedDataPage(versions: parsedVersions),
    ));

    _controller.forward(from: 0);
  }

  List<Map<String, dynamic>> parseJson(dynamic input) {
    List<Map<String, dynamic>> versions = [];

    if (input is Map) {
      input.forEach((key, value) {
        if (value is Map) {
          versions.add({
            'id': value['id'],
            'title': value['title'],
          });
        }
      });
    } else if (input is List) {
      for (var item in input) {
        if (item is Map) {
          versions.addAll(parseJson(item));
        } else if (item is List) {
          for (var subItem in item) {
            if (subItem is Map) {
              versions.add({
                'id': subItem['id'],
                'title': subItem['title'],
              });
            }
          }
        }
      }
    }

    return versions;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E55),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "JOB TASK",
            style: TextStyle(fontSize: 21, color: Colors.white),
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 15, top: 15),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.white,
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (index) {},
            padding: const EdgeInsets.symmetric(vertical: 20),
            iconSize: 28,
            iconColor: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Link 1",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Link 2",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text(
                  "Link 3",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text(
                  "Link 4",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const PopupMenuItem<int>(
                value: 5,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _isLoading
                ? Lottie.network(
                    "https://lottie.host/01c20cbf-b79f-4975-855a-57a5a9caecbc/2Ygq7TSPMT.json",
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        onPressed: () => parseAndDisplay(context, input1),
                        label: 'Button1',
                        gradientColors: [Colors.blue, Colors.purple],
                      ),
                      SizedBox(height: 20),
                      AnimatedButton(
                        onPressed: () => parseAndDisplay(context, input2),
                        label: 'Button2',
                        gradientColors: [Colors.green, Colors.yellow],
                      ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Lottie.network(
              "https://lottie.host/01c20cbf-b79f-4975-855a-57a5a9caecbc/2Ygq7TSPMT.json",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.network(
              "https://lottie.host/01c20cbf-b79f-4975-855a-57a5a9caecbc/2Ygq7TSPMT.json",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
