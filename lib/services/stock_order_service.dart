import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rse/data/models/stock_order.dart';

class StockOrderService {
  // Replace this with your actual API endpoint or database connection
  final _apiEndpoint = 'https://localhost:7254/pricesR';

  // Future<List<StockOrder>> getStockOrders() async {
  //   // Make an HTTP request to fetch stock orders from the server
  //   // You can use packages like http or dio for handling HTTP requests
  //   // Parse the response and convert it into a list of StockOrder objects
  //   // Return the list of stock orders
  // }

  // Future<StockOrder> createStockOrder(StockOrder order) async {
  //   // Convert the StockOrder object into a JSON payload
  //   // Make an HTTP POST request to create a new stock order
  //   // Parse the response and convert it into a StockOrder object
  //   // Return the created stock order
  // }

  // Future<StockOrder> updateStockOrder(StockOrder order) async {
  //   // Convert the StockOrder object into a JSON payload
  //   // Make an HTTP PUT request to update the stock order
  //   // Parse the response and convert it into a StockOrder object
  //   // Return the updated stock order
  // }

  // Future<void> deleteStockOrder(String orderId) async {
  //   // Make an HTTP DELETE request to delete the stock order
  //   // Handle the response and error cases accordingly
  //   // You may choose to return a boolean or throw an exception based on the result
  // }

  Future<void> fetchPrices() async {
    try {
      final response = await http.get(Uri.parse(_apiEndpoint));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData.toString());
      } else {
        print('Failure fetchStockOrders');
      }
    } catch (e) {
      print('Error fetchStockOrders');
    }
  }
}
