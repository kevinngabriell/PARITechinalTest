// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:technicaltest/home.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController txtNamaProduk = TextEditingController();
  TextEditingController txtTahunProduk = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  TextEditingController txtCPUModel = TextEditingController();
  TextEditingController txtHardDisk = TextEditingController();
  bool isLoading = true;

  Future<void> submitData() async {
    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> data = {
      "name": txtNamaProduk.text,
      "data": {
        "year": int.tryParse(txtTahunProduk.text),
        "price": double.tryParse(txtHarga.text),
        "CPU model": txtCPUModel.text,
        "Hard disk size": txtHardDisk.text
      }
    };

    final response = await http.post(
      Uri.parse('https://api.restful-api.dev/objects'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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
                  Text('Insert data error with response ${response.body}'),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                const Text('Add New Product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                const SizedBox(height: 20,),
                const Text('Product Name'),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: txtNamaProduk,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Insert Product Name'
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Year'),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: txtTahunProduk,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Insert Product Year'
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Price'),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: txtHarga,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Insert Product Price'
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('CPU Model'),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: txtCPUModel,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Insert CPU Model'
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Hard Disk Size'),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: txtHardDisk,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Insert Hard Disk Size'
                  ),
                ),
                const SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        submitData();
                      }, 
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFFFFFFF),
                        backgroundColor: const Color(0xff4ec3fc),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Submit')
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}