import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

// ✅ Database Helper Class
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('signup.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(String email, String password) async {
    final db = await instance.database;
    return await db.insert('user', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>?> getLatestUser() async {
    final db = await instance.database;
    final result = await db.query('user', limit: 1, orderBy: 'id DESC');
    return result.isNotEmpty ? result.first : null;
  }
}

// ✅ Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup with Sqflite',
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

// ✅ Sign Up Screen
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      int result = await DatabaseHelper.instance.insertUser(email, password);
      print("Inserted ID: $result");

      if (result > 0) {
        final userData = await DatabaseHelper.instance.getLatestUser();
        print("User Data Retrieved: $userData");

        if (userData != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDataScreen(userData: userData),
            ),
          );
        } else {
          print("Error: User data is null.");
        }
      } else {
        print("Error: Data not inserted");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('براہ کرم Email اور Password درج کریں')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Show Data Screen (Display user data)
class ShowDataScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  ShowDataScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Data')),
      body: Center(
        child: Text(
          'Signup Successful!\n\nEmail: ${userData['email']}\nPassword: ${userData['password']}',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
