import 'package:flutter/material.dart';

class ParsedDataPage extends StatefulWidget {
  final List<Map<String, dynamic>> versions;

  ParsedDataPage({required this.versions});

  @override
  _ParsedDataPageState createState() => _ParsedDataPageState();
}

class _ParsedDataPageState extends State<ParsedDataPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
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
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: 400,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.teal.shade100,
                    ),
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    headingTextStyle: TextStyle(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                    dataTextStyle: TextStyle(
                      color: Colors.teal.shade700,
                    ),
                    rows: widget.versions.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> version = entry.value;
                      return DataRow(
                        color: MaterialStateColor.resolveWith(
                          (states) => index.isEven
                              ? Colors.grey.shade100
                              : Colors.white,
                        ),
                        cells: [
                          DataCell(Text(version['id'].toString())),
                          DataCell(Text(version['title'])),
                        ],
                      );
                    }).toList(),
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Title')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
        items: const [
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
