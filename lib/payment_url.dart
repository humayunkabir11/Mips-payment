import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentUrlClass{

  paymentUrl()async{

    // These variables are placeholders, replace them with actual values
    String idOrder = 'ord_5125';
    double amount = 1.00;
    String currency = 'MUR';
    String idMerchant = 'YOUR_ID_MERCHANT';
    String idOperator = 'YOUR_OPERATOR_ID';
    String operatorPassword = 'YOUR_OPERATOR_PASSWORD';

    Map<String, dynamic> requestBody = {
      'id_merchant': idMerchant,
      'id_operator': idOperator,
      'operator_password': operatorPassword,
      'request_mode': 'simple',
      'touchpoint': 'native_app',
      'order': {
        'id_order': idOrder,
        'amount': amount,
        'currency': currency,
      },
      'iframe_behavior': {
        'custom_redirection_url': '',
        'height': 508,
        'width': 450,
        'language': 'EN',
      }
    };

// Make HTTP request to MIPS API to load payment zone
    final String apiUrl = 'https://api.mips.mu/api/load_payment_zone';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$idMerchant:$operatorPassword'))}',
        'Cache-Control': 'no-cache',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      String finalUrl = jsonDecode(response.body)['answer']['payment_zone_data'];
    } else {
      // Handle error
    }


  }

}