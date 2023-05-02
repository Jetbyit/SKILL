import 'package:flutter/material.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';
import 'package:job_portal/src/presentation/screens/my_employer_jobs.dart';
import 'package:job_portal/src/presentation/screens/my_jobs_applys_users.dart';
import 'package:job_portal/src/presentation/screens/saved_job.dart';
import 'package:job_portal/src/presentation/screens/users_applys.dart';
import 'package:job_portal/src/utils/colors.dart';

class SidebarEmployer extends StatelessWidget {
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
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text('My Jobs'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyJobPosted()));
                // Navigate to the Saved Jobs screen
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: jobportalBrownColor,
              ),
              title: const Text('Users applys'),
              onTap: () {
                // todo: go to see users applys for this job
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyJobsApplys()));//UsersApplys(jobId: '7juRcXKgCHJXoOBARd9d',)));

                },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment'),
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
