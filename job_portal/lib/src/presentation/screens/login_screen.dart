import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';
import 'package:job_portal/src/data/services/auth_service.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
import 'package:job_portal/src/presentation/screens/forget_password.dart';
import 'package:job_portal/src/presentation/screens/register_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:job_portal/src/utils/colors.dart';


class ALoginScreen extends StatefulWidget {
  const ALoginScreen({Key? key}) : super(key: key);

  @override
  _ALoginScreenState createState() => _ALoginScreenState();
}

class _ALoginScreenState extends State<ALoginScreen> {
  var viewPassword = true;
  //late AuthRepository _authRepository;
  //final AuthService _authRepository = AuthService(FirebaseAuth.instance);
  final AuthRepository _authRepository = AuthRepository();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _signInWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    final UserModel? user = await _authRepository.signInWithEmailAndPassword(email, password);
    print("user from UserModel is : ${user!.id}");

    if (user == null) {
      // handle sign in failure
      print("handle sign in failure : ${user!.email} and ${user.id}");
    } else {
      // handle sign in success
      print("handle sign in success : ${user!.email} and ${user.id}");
    }
  }

  Future<void> _resetPassword() async {
    final String email = _emailController.text.trim();
    await _authRepository.resetPassword(email);
    // handle password reset email sent
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         color: jobportalAppContainerColor,
            //         // appStore.isDarkModeOn
            //         //     ? context.cardColor
            //         //     : appetitAppContainerColor,
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //       width: 50,
            //       height: 50,
            //       child: InkWell(
            //         borderRadius: BorderRadius.circular(25),
            //         child: Icon(Icons.arrow_back_ios_outlined,
            //             color: jobportalBrownColor),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () => Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ARegisterScreen(),
            //         ),
            //       ),
            //       child: Text('Register',
            //           style: TextStyle(fontSize: 20, color: context.iconColor)),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 60),
            const Text(
              'Login',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome back! Please enter your email and password to continue.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
            Form(
              key: mykey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          labelText: 'Enter E-mail',
                          hintText: 'Enter your E-mail',
                          filled: true,
                          fillColor: jobportalAppContainerColor,
                          // appStore.isDarkModeOn
                          //     ? context.cardColor
                          //     : appetitAppContainerColor,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Enter valid e-mail';
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        obscureText: viewPassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          labelText: 'Enter Password',
                          hintText: 'Enter your Password',
                          filled: true,
                          fillColor: jobportalAppContainerColor,
                          // appStore.isDarkModeOn
                          //     ? context.cardColor
                          //     : appetitAppContainerColor,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => viewPassword = !viewPassword),
                            icon: viewPassword
                                ? Icon(Icons.visibility_off, color: Colors.grey)
                                : Icon(Icons.visibility, color: Colors.grey),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Enter valid Password';
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _resetPassword();
                          /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AForgetPasswordScreen(),
                              //TODO: AForgetPasswordScreen(),
                            ),
                          );
                          */
                        },
                        child: const Text(
                          'forget password?',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _signInWithEmailAndPassword();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ADashboardSkillerScreen(),
                  //   ), // TODO: ADashboardScreen(),
                  // );
                },
                child: Text('Login', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
