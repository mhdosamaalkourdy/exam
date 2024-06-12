// 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/modelofeasy.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<List<Easydata>> futureData;

  Future<List<Easydata>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://freetestapi.com/api/v1/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Easydata.fromMap(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a324d),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff0a324d),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff76bfbf),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'All projects',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(0xff0a324d),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(0xff0a324d),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: FutureBuilder<List<Easydata>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  List<Easydata> data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Easydata item = data[index];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/triangle.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    '9/15\n2024',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff0a324d),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 175,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Project name: ${item.name}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff0a324d),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Description: ${item.description}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
