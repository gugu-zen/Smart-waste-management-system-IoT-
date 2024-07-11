import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'), // Update with your image asset
            ),
            SizedBox(height: 16),
            Text(
              'Elvis Magugu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('maguguelvis@gmail.com'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to EditProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Personal Information'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Historical Data'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Report an Issue'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            Divider(),
            ListTile(
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Terms & Conditions'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('FAQ & Help'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Log out'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
      )
    );
  }
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'), // Update with your image asset
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle image edit
              },
              child: Text('Edit Image'),
            ),
            TextFormField(
              initialValue: 'maguguelvis@gmail.com',
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              initialValue: 'Elvis Magugu',
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Old Password',
              ),
              obscureText: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle save
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      )
    );
  }
}
