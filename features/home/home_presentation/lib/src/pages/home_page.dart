import 'package:flutter/material.dart';
import 'package:home_presentation/src/pages/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .symmetric(horizontal: 40),
          child: Center(
            child: HomeView(),
          ),
        ),
      ),
    );
  }
}
