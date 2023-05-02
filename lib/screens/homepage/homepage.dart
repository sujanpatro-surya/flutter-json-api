import 'package:flutter/material.dart';
import 'package:json_and_api/screens/remote_api/remote_api.dart';

import '../local_json/local_json.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http Json'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LocalJson()
                ));
              },
              child: const Text('Local Json')
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RemoteApi()
                ));
              },
              child: const Text('Remote Api')
            ),
          ],
        ),
      ),
    );
  }
}
