import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/screens/welecom_screen.dart';
import 'package:job_portal/src/presentation/widgets/walkthrough_page.dart';
import 'package:job_portal/src/data/models/walktrough.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkthroughScreen extends StatefulWidget {
  final VoidCallback onDismiss;
  WalkthroughScreen({required this.onDismiss});
  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int initialValue = 0;
  int progressIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    super.initState();
    pageController = PageController(initialPage: 0);
    progressIndex = 0;
  }

  double containerWidth() {
    return (150 / modal.length) * (progressIndex + 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              initialValue = value;
              progressIndex = value;
              debugPrint("$value");
            }),
            children: modal.map((e){
              return WalkthroughPage(e:e);
            }).toList(),
          ),
          //Determinate LinearProgressIndicator & FAB
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    AnimatedContainer(
                      duration: 1.seconds,
                      width: containerWidth(),
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 50,
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      if (initialValue < 2) {
                        setState(() => pageController.jumpToPage(initialValue + 1));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AWelcomeScreen())).then((value) {
                          widget.onDismiss();
                        });
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
