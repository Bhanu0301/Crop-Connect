// import 'package:flutter/material.dart';

// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Stay updated with the latest news!'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = '9f3a3b00ff2e96fa3b8c204874aa16ec';
    final topics = 'agri';
    final apiUrl =
        'https://gnews.io/api/v4/search?q=$topics&token=$apiKey&lang=en&country=in';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _articles = responseData['articles'];
          _isLoading = false;
        });
      } else {
        print('Failed to load news: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error fetching news: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                fetchNews();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = _articles[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description'] ?? ''),
                  onTap: () {
                    // Open article detail screen or navigate to article URL
                    // based on your app's navigation flow.
                  },
                );
              },
            ),
    );
  }
}
