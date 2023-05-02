import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_and_api/models/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  late final Future<List<UserModel>> _allUsers;

  @override
  void initState() {
    _allUsers = _getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _getUser();
    return Scaffold(
      appBar: AppBar(title: const Text('Remote Api')),
      body: FutureBuilder(
        future: _allUsers,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            List<UserModel> listUsers = snapshot.data!;
            return ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                UserModel currentUser = listUsers[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(currentUser.id.toString())),
                  title: Text(currentUser.name),
                  subtitle: Text(currentUser.email)
                );
              }
            );
          } else if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<UserModel>> _getUser() async {
    try {
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var jsonData = jsonDecode(response.body);
      List<UserModel> userList = [];
      if (response.statusCode == 200) {
        userList.addAll((jsonData as List)
          .map((currentUser) => UserModel.fromMap(currentUser))
          .toList()
        );
      }
      return userList;
    } on http.ClientException catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
