// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/ui/list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final dynamic id;
  const UpdateData({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deadlineController = TextEditingController();
  final createController = TextEditingController();
  final updateController = TextEditingController();

  String url = Platform.isAndroid
      ? 'https://responsi1b.dalhaqq.xyz'
      : 'https://responsi1b.dalhaqq.xyz';

  Future<dynamic> updateData(String id, String title,String description, DateTime deadline,DateTime created_at, DateTime update_at ) async {
    // print("updating");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"id":$id,"title": "$title", "description": "$description" ,"deadline":"$deadline","created_at": "$created_at", "update_at": "$update_at"}';
    var response = await http.put(Uri.parse("$url?id=$id"),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        titleController.text = data['title'];
        descriptionController.text= data['description'];
        deadlineController.text = data['deadline'];
        createController.text = data['create_at'];
        updateController.text = data['update_at'];
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Tugas'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Judul Tugas',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'description',
              ),
            ),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(
                hintText: 'deadline',
              ),
            ),
            TextField(
              controller: createController,
              decoration: const InputDecoration(
                hintText: 'Dibuat',
              ),
            ),
            TextField(
              controller: updateController,
              decoration: const InputDecoration(
                hintText: 'Diupdate',
              ),
            ),
            ElevatedButton(
              child: const Text('Edit Data'),
              onPressed: () {
                String title = titleController.text;
                String description = descriptionController.text;
                DateTime deadline = DateFormat("yyyy-MM-dd").parse(deadlineController.text);
                DateTime create = DateFormat("yyyy-MM-dd").parse(createController.text);
                DateTime update = DateFormat("yyyy-MM-dd").parse(updateController.text);

                // updateData(widget.id,title, deadline);

                updateData(widget.id, title, description, deadline, create, update).then((result) {
                  print(result);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Data berhasil di ubah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
