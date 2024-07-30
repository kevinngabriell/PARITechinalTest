// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:technicaltest/home.dart';

class UpdateProduct extends StatefulWidget {
  final String productID;
  const UpdateProduct({super.key, required this.productID});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  Map<String, dynamic>? productData;
  bool isLoading = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController generationController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController cpuModelController = TextEditingController();
  final TextEditingController strapColorController = TextEditingController();
  final TextEditingController caseSizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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

          // Set initial values to the controllers
          nameController.text = productData?['name'] ?? '';
          priceController.text = productData?['data']?['price']?.toString() ?? '';
          generationController.text = productData?['data']?['generation']?.toString() ?? '';
          colorController.text = productData?['data']?['color'] ?? '';
          capacityController.text = productData?['data']?['Capacity']?.toString() ??
              productData?['data']?['capacity GB']?.toString() ??
              productData?['data']?['Hard disk size']?.toString() ??
              productData?['data']?['capacity']?.toString() ?? '';
          yearController.text = productData?['data']?['year']?.toString() ?? '';
          cpuModelController.text = productData?['data']?['CPU model'] ?? '';
          strapColorController.text = productData?['data']?['Strap Colour'] ?? '';
          caseSizeController.text = productData?['data']?['Case Size']?.toString() ??
              productData?['data']?['Screen size']?.toString() ?? '';
          descriptionController.text = productData?['data']?['Description'] ?? '';
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error','Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> updateProduct() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.put(
      Uri.parse('https://api.restful-api.dev/objects/${widget.productID}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": nameController.text,
        "data": {
          "year": int.tryParse(yearController.text) ?? 2019,
          "price": double.tryParse(priceController.text) ?? 0.0,
          "CPU model": cpuModelController.text,
          "Hard disk size": capacityController.text,
          "color": colorController.text,
          "generation": generationController.text,
          "Strap Colour": strapColorController.text,
          "Case Size": caseSizeController.text,
          "Description": descriptionController.text,
        }
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context, 
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  const Text('Success', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  Text('Data has been success inserted with responses ${response.body}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Get.back();
                        }, 
                        child: const Text('Close & New')
                      ),
                      TextButton(
                        onPressed: (){
                          Get.to(const Home());
                        }, 
                        child: const Text('Close')
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
      setState(() {
        isLoading = false;
      });
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
                  const SizedBox(height: 20,),
                  Text('Insert data error with response ${response.body}'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: isLoading 
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  const Text('Update Product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 20,),
                  const Text('Product Name'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter product name'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Price'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter price'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Generation'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: generationController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter generation'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Color'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: colorController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter color'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Capacity'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: capacityController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter capacity'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Year'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: yearController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter year'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('CPU Model'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: cpuModelController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter CPU model'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Strap Color'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: strapColorController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter strap color'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Case Size/ Screen Size'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: caseSizeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter case/screen size'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Description'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter description'
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: (){
                            // deleteItem();
                            Get.back();
                          }, 
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Back')
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: ElevatedButton(
                          onPressed: (){
                            updateProduct();
                          }, 
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF),
                            backgroundColor: const Color(0xff4ec3fc),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Update')
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30,)
                ],
              ),
            ),
        ),
      ),
    );
  }
}
