import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mips_payment/payment_url_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
   PaymentUrlClass paymentUrlClass = PaymentUrlClass();
    String ?finalPaymentUrl;

   WebViewController controller = WebViewController();
   @override
   void initState() {
     super.initState();
     fetchPaymentUrl(); // Call fetchPaymentUrl before creating WebViewController
     controller = WebViewController()
       ..setJavaScriptMode(JavaScriptMode.unrestricted)
       ..setNavigationDelegate(
         NavigationDelegate(
           // ... delegate methods
         ),
       );
   }
   // Fetch payment URL and update finalPaymentUrl
   void fetchPaymentUrl() async {
     await paymentUrlClass.fetchPaymentUrl();
     setState(() {
       finalPaymentUrl = PaymentUrlClass.finalPaymentUrl;
       controller.loadRequest(Uri.parse(finalPaymentUrl??"")); // Update controller here
     });
   }

  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  // ..setNavigationDelegate(
  // NavigationDelegate(
  // onProgress: (int progress) {
  // // Update loading bar.
  // },
//   onPageStarted: (String finalPaymentUrl) {},
//   onPageFinished: (String finalPaymentUrl) {},
//   onWebResourceError: (WebResourceError error) {},
//   onNavigationRequest: (NavigationRequest request) {
//
//   return NavigationDecision.navigate;
//   },
//   ),
//   )
// //..loadRequest(Uri.parse(PaymentUrlClass.finalPaymentUrl))
// ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MIPS Payment Example')),
      body: WebViewWidget(controller: controller),);
  }
}
