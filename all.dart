import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String status = "Active";
  String message = "";

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);
    await prefs.setString("status", status);

    setState(() {
      message = "Data successfully entered!";
    });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Status: "),
                Radio(
                  value: "Active",
                  groupValue: status,
                  onChanged: (value) {
                    setState(() {
                      status = value.toString();
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text("Active"),
                Radio(
                  value: "Inactive",
                  groupValue: status,
                  onChanged: (value) {
                    setState(() {
                      status = value.toString();
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text("Inactive"),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveData,
              child: Text("Submit"),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "";
  String password = "";
  String status = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email") ?? "";
      password = prefs.getString("password") ?? "";
      status = prefs.getString("status") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: $email", style: TextStyle(fontSize: 18, color: Colors.blue)),
            SizedBox(height: 10),
            Text("Password: $password", style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 95, 54, 244)r.fromARGB(255, 124, 54, 244))),
            SizedBox(height: 10),
            Text("Status: $status", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}