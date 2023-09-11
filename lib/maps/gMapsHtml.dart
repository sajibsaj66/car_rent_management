import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeScreen extends StatefulWidget {

  const YoutubeScreen({super.key});
  @override
  YoutubeScreenState createState() => YoutubeScreenState();
}

class YoutubeScreenState extends State<YoutubeScreen> {

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.google.com/maps/@23.8014904,90.4258735,17.75z?entry=ttu'));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       title: Text('Location'),
        centerTitle: true,
      ),
      body:  WebViewWidget(
        controller: controller,
      ),
    );
  }
}