import 'package:copartner_assignment_app/view/screen/subscription_screen.dart';
import 'package:copartner_assignment_app/view_model/home_screen_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyCopartnerApp());
}

class MyCopartnerApp extends StatelessWidget {
  const MyCopartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SubscriptionViewModel())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SubscriptionScreen(),
      ),
    );
  }
}
