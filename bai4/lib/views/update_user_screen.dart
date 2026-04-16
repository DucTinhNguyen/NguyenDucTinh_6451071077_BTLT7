import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final controller = UserController();

  bool isLoading = true;
  String result = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final user = await controller.getUser(1);

    setState(() {
      nameController.text = user.name;
      emailController.text = user.email;
      isLoading = false;
    });
  }

  void updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    User user = User(
      id: 1,
      name: nameController.text,
      email: emailController.text,
    );

    final response = await controller.updateUser(1, user);

    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body).toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update thành công')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Update User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👉 MÃ SINH VIÊN
            Text(
              '6451071077',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Không được để trống' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Không được để trống' : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateUser,
                    child: Text('Update'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}