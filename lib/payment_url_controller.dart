
import 'dart:convert';
import 'package:http/http.dart' as http;
class PaymentUrlClass {
static String  finalPaymentUrl ="";
   Future<void> fetchPaymentUrl() async {
    Map<String, dynamic> requestBody = {
      "authentify": {
        "id_merchant": "5s0aOiRIH43yqkffzpEbpddlqGzMCoyY",
        "id_entity": "w3QAeoMtLJROmlIyXVgnx1R6y7BgNo8t",
        "id_operator": "oeRH43c5RoQockXajPTo0TA5YW0KReio",
        "operator_password": "NUvxccs0R0rzKPoLlIPeet21rarpX0rk"
      },
      "order": {
        "id_order": "INV5034",
        "currency": "MUR",
        "amount": 500
      },
      "iframe_behavior": {
        "height": 400,
        "width": 350,
        "custom_redirection_url": "https://sparktech.agency",
        "language": "EN"
      },
      "request_mode": "simple",
      "touchpoint": "native_app"
    };

    print(requestBody);

    // Make the HTTP POST request to the MIPS API
    final response = await http.post(Uri.parse("https://api.mips.mu/api/load_payment_zone"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ZGF0YW1hdGlvbl84YTlmdDU6a3FLMWh2VDVNaHd1N3QwS2F2WWFKY3REVzVNOHhydVc=',
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

      print("=======Url $finalPaymentUrl");
      // Once you have the payment URL, you can load it into the WebView
     // Refresh the UI to show the WebView
    } else {
      // Handle error
    }
  }

}