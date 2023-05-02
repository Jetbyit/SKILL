import 'package:flutter/material.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';
import 'package:job_portal/src/presentation/screens/saved_job.dart';

class Sidebar extends StatelessWidget {
  AuthRepository _authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the Profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.nights_stay),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false, // Replace with the actual dark mode value
                onChanged: (value) {
                  // Implement the dark mode functionality here
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Remove Account'),
              onTap: () {
                // Implement the remove account functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Saved Jobs'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedJob()));
                // Navigate to the Saved Jobs screen
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the Payment screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: const Text('Logout'),
              onTap: () async {
                // Implement the logout functionality here
                await _authRepository.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
