import 'package:advande_apkstatmangement/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NewsProvider>().fetchNews();
    });
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.inAppWebView);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();

    return Scaffold(
      appBar: AppBar(
        title:RichText(text: TextSpan(
          text:"World",style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          children: [
             TextSpan(
              text: "News",style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
             ),
          ]
        ),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.news.length,
              itemBuilder: (context, index) {
                final item = provider.news[index];

                String title = item['title'] ?? "";
                String description = item['text'] ?? "";
                String image = item['image'] ?? "";
                String url = item['url'] ?? "";

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => openUrl(url),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image.isNotEmpty
                            ? Image.network(
                                image,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 200,
                                color: Colors.grey,
                                child: const Center(
                                  child: Text("No Image"),
                                ),
                              ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NewsProvider>().fetchNews();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}