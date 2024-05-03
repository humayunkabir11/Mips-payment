import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
 static String finalPaymentUrl = "";

  @override
  void initState() {
    super.initState();
    fetchPaymentUrl();
  }

  Future<void> fetchPaymentUrl() async {
    // Replace these variables with your actual data
    String idOrder = 'ord_5125';
    double amount = 1.00;
    String currency = 'MUR';
    String idMerchant = '5s0aOiRIH43yqkffzpEbpddlqGzMCoyY';
    String idOperator = 'oeRH43c5RoQockXajPTo0TA5YW0KReio';
    String operatorPassword = 'NUvxccs0R0rzKPoLlIPeet21rarpX0rk';

    // Construct the request body
    Map<String, dynamic> requestBody = {
      // 'id_merchant': idMerchant,
      // "id_entity": "w3QAeoMtLJROmlIyXVgnx1R6y7BgNo8t",
      // 'id_operator': idOperator,
      // 'operator_password': operatorPassword,

      "authentify": {
        "id_merchant": "5s0aOiRIH43yqkffzpEbpddlqGzMCoyY",
        "id_entity": "w3QAeoMtLJROmlIyXVgnx1R6y7BgNo8t",
        "id_operator": "oeRH43c5RoQockXajPTo0TA5YW0KReio",
        "operator_password": "NUvxccs0R0rzKPoLlIPeet21rarpX0rk"
      },
      'order': {
        'id_order': idOrder,
        'amount': amount,
        'currency': currency,
      },
      'request_mode': 'simple',
      'touchpoint': 'native_app',
      'iframe_behavior': {
        'height': 508,
        'width': 450,
        'language': 'EN',
      }
    };

    print(requestBody);

    // Make the HTTP POST request to the MIPS API
    final response = await http.post(
      Uri.parse("https://stoplight.io/mocks/mips/merchant-api/36020489/load_payment_zone"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization' : "Basic datamation_8a9ft5:kqK1hvT5Mhwu7t0KavYaJctDW5M8xruW",
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.78 Safari/537.36',
        'Cache-Control': 'no-cache',
      },
      body: jsonEncode(requestBody),
    );
    print("=====================++>>> response.body${response.body}");
    print("=====================++>>> response.statusCode${response.statusCode}");


    // Handle the response
    if (response.statusCode == 200) {
      // Parse the JSON response and extract the payment URL
      finalPaymentUrl = jsonDecode(response.body)['answer']['payment_zone_data'];

      // Once you have the payment URL, you can load it into the WebView
      setState(() {}); // Refresh the UI to show the WebView
    } else {
      // Handle error
    }
  }

  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
  NavigationDelegate(
  onProgress: (int progress) {
  // Update loading bar.
  },
  onPageStarted: (String paymentUrl) {},
  onPageFinished: (String paymentUrl) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {

  return NavigationDecision.navigate;
  },
  ),
  )
// ..loadRequest(Uri.parse(finalPaymentUrl))

  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: finalPaymentUrl != null ? WebViewWidget(controller: controller):Center(child: CircularProgressIndicator()),);
  }
}
