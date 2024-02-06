import 'package:flutter/material.dart';
import 'package:soulmateapk/services/chats/chat_services.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatServices.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> user = users[index];

                // Check if 'images' is not null and has at least one element
                String imageUrl =
                    user['images'] != null && user['images'].isNotEmpty
                        ? user['images'][0]
                        : 'https://example.com/default-image.jpg';

                // Display user information (name, age, image at index 0)
                return ListTile(
                  title: Text('Name: ${user['name']}'),
                  subtitle: Text('Age: ${user['age']}'),
                  leading: Image.network(imageUrl),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
