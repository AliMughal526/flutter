import 'package:flutter/material.dart';
import 'db_help.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Map<String, dynamic>> _grades = [];
  bool _isLoading = false;

  // Load data from API and store in database
  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    await DBHelper().fetchAndStoreData();
    await _refreshData();

    setState(() {
      _isLoading = false;
    });
  }

  // Refresh data from database
  Future<void> _refreshData() async {
    List<Map<String, dynamic>> data = await DBHelper().getGrades();
    setState(() {
      _grades = data;
    });
  }

  // Erase all data from the database
  void _eraseData() async {
    await DBHelper().deleteAllData();
    _refreshData();
  }

  // Erase a specific row by ID
  void _eraseRow(int id) async {
    await DBHelper().deleteOneRow(id);
    _refreshData();
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("To Load Data Click Load Button")),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: _grades.isEmpty
                ? Center(child: Text("No data available"))
                : ListView.builder(
              itemCount: _grades.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_grades[index]['studentName'] ?? "No Name"),
                  subtitle: Text(
                      "${_grades[index]['courseTitle'] ?? 'No Title'} - Marks: ${_grades[index]['obtainedMarks'] ?? '0'}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _eraseRow(_grades[index]['id']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _loadData,
                  child: Text("Load Data"),
                ),
                ElevatedButton(
                  onPressed: _eraseData,
                  child: Text("Erase Data"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text("To Erase Data Click Erase Button")),
        ),
      ),
    );
  }
}