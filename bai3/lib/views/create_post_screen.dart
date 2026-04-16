import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';
import '../widgets/custom_textfield.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final PostController controller = PostController();

  String responseText = '';

  void createPost() async {
    Post post = Post(
      title: titleController.text,
      body: bodyController.text,
      userId: 1,
    );

    final response = await controller.createPost(post);

    if (response.statusCode == 201) {
      setState(() {
        responseText = jsonDecode(response.body).toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '6451071077',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),
            CustomTextField(
              controller: titleController,
              hint: 'Enter title',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: bodyController,
              hint: 'Enter content',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: createPost,
              child: Text('Create Post'),
            ),
            SizedBox(height: 20),
            Text(responseText),
          ],
        ),
      ),
    );
  }
}