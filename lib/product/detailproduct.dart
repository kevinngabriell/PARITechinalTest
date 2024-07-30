// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:technicaltest/home.dart';
import 'package:technicaltest/product/updateproduct.dart';

class DetailProduct extends StatefulWidget {
  final String productID;
  const DetailProduct({super.key, required this.productID});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  Map<String, dynamic>? productData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.restful-api.dev/objects?id=${widget.productID}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        setState(() {
          productData = responseData.first;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error','Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> deleteItem() async {
    final response = await http.delete(
      Uri.parse('https://api.restful-api.dev/objects/${widget.productID}'),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      showDialog(
        context: context, 
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  const Text('Sucess', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  Text('Data has been deleted with responses ${response.body}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Get.to(const Home());
                        }, 
                        child: const Text('Back to Home')
                      )
                        ],
                      )
                ],
              ),
            ),
          );
        }
      );
    } else {
      showDialog(
        context: context, 
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  Text('Error ${response.statusCode}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  Text('Error while deleting data with responses : ${response.body}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Get.back();
                        }, 
                        child: const Text('Back')
                      )
                        ],
                      )
                ],
              ),
            ),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLoading ? const Center(child: CircularProgressIndicator(),) : productData != null ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              const Text('Product Detail', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Product Name'),
                  Text(productData!['name']),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Price'),
                  Text('${productData?['data']?['price'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Generation'),
                  Text('${productData?['data']?['generation'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Color'),
                  Text('${productData!['data']?['color'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Capacity'),
                  Text('${productData!['data']?['Capacity'] ?? productData!['data']?['capacity GB'] ?? productData!['data']?['Hard disk size'] ?? productData!['data']?['capacity'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Year'),
                  Text('${productData!['data']?['year'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CPU Model'),
                  Text('${productData!['data']?['CPU model'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Strap Colour'),
                  Text('${productData!['data']?['Strap Colour'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Case Size / Screen Size'),
                  Text('${productData!['data']?['Case Size'] ?? productData!['data']?['Screen size'] ?? '-'}')
                ],
              ),
              const SizedBox(height: 10,),
              const Text('Description'),
              const SizedBox(height: 8,),
              Text('${productData!['data']?['Description'] ?? '-'}'),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: (){
                        deleteItem();
                      }, 
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFFFFFFF),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Delete Item')
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: ElevatedButton(
                      onPressed: (){
                        Get.to(UpdateProduct(productID: widget.productID,));
                      }, 
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFFFFFFF),
                        backgroundColor: const Color(0xff4ec3fc),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Update Item')
                    ),
                  )
                ],
              )
            ],
          ),
        ) : const Center(child: Text('No data available')),
      ),
    );
  }
}