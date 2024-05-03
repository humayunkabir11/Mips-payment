import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JavaScriptInterface {
  final BuildContext context;

  JavaScriptInterface(this.context);

  // Method to handle redirection to success page
  void resultFromWebview(bool toast) {
    if (toast) {
      // Redirect to success page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    }
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
      ),
      body: Center(
        child: Text('Payment successful!'),
      ),
    );
  }
}
