import 'package:flutter/material.dart';
import '../controllers/article_controller.dart';
import '../models/article.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final controller = ArticleController();

  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await controller.getArticles();

    setState(() {
      articles = data;
      isLoading = false;
    });
  }

  //  pull to refresh
  Future<void> refreshData() async {
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Column(
        children: [
          //  MÃ SINH VIÊN
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '6451071077',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshData,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final item = articles[index];

                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.body),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}