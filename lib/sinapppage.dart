// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String correctEmail = 'osm@gmail.com';
  final String correctPassword = '123456';

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == correctEmail && password == correctPassword) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid email or password'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a324d), 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/intersect.png'),
                radius: 50,
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350], 
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true, 
                  fillColor: Colors.grey[350], 
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.amber.shade300,
                 foregroundColor: Colors.black,        
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              Text('Don’t have an account?', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWidget()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: getEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(
                snapshot.data ?? 'No email found',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
