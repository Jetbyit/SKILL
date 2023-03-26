import 'package:flutter/material.dart';

class WalkthroughPage extends StatelessWidget {
  final e;

  const WalkthroughPage({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Image
          Image.asset(
            e.image.toString(),
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.35),
            colorBlendMode: BlendMode.darken,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          // DataEntry
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 16),
                  Text((e.heading ?? ""), style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.field.toString(), style: const TextStyle(color: Colors.white, fontSize: 45, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 16),
                    Text(e.subtitle.toString(), style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
