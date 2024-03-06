import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController _controller;
  late final PlatformWebViewControllerCreationParams params;

  int loadingProgress = 0;
  bool _pageLoaded = false;

  Future<void> _canPop() async {
    final NavigatorState navigator = Navigator.of(context);
    if (await _controller.canGoBack()) {
      _controller.goBack();
    } else {
      navigator.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() => loadingProgress = progress);
          },
          onPageFinished: (String url) {
            setState(() => _pageLoaded = true);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) return;
          await _canPop();
        },
        child: Column(
          children: [
            Visibility(
              visible: !_pageLoaded,
              child: LinearProgressIndicator(
                value: loadingProgress.toDouble(),
              ),
            ),
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
