import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:technicaltest/product/addnewproduct.dart';
import 'package:technicaltest/product/detailproduct.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> dataList = [];
  bool isLoading = true;

  Future<void> fetchListAllData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.restful-api.dev/objects'),
      );

      if (response.statusCode == 200) {
        setState(() {
          dataList = List<Map<String, dynamic>>.from(
              json.decode(response.body) as List);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error, e.g., show a snackbar or an error widget
      Get.snackbar('Error', 'Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchListAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final item = dataList[index];
                  final data = item['data'] ?? {};
                  return GestureDetector(
                    onTap: (){
                      // print(item['id']);
                      Get.to(DetailProduct(productID: item['id']));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text(data.isNotEmpty
                            ? data.entries
                                .map((entry) =>
                                    '${entry.key}: ${entry.value.toString()}')
                                .join(', ')
                            : 'No additional data'),
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(const AddNewProduct());
          },
          backgroundColor: const Color(0xff4ec3fc),
          foregroundColor: const Color(0xFFFFFFFF),
          isExtended: true,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
