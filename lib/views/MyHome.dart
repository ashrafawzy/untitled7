import "package:flutter/material.dart";
import 'package:untitled7/models/user_model.dart';
import 'package:untitled7/services/user_model_service.dart';

class MyHome extends StatelessWidget {
  UserModelApi userApi = UserModelApi();
  @override
  Widget build(BuildContext context) {
    userApi.getUserList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("API"),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: userApi.getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userList = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                var user = userList[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.address.city.toString()),
                      leading: Text(user.id.toString()),
                      trailing: Text(user.email.toString()),
                    ),
                    Divider(
                      color: Colors.purple,
                      thickness: 3,
                    )
                  ]),
                );
              },
              itemCount: userList.length,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
