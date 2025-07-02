import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/reward_section.dart';
import '../widgets/menu_grid.dart';

class HomePage extends StatelessWidget {
  final bool isLoggedIn;

  const HomePage({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(isLoggedIn: isLoggedIn),
          expandedHeight: 80,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const HeroSection(),
              const RewardSection(),
              KantinMenuGrid(
                isLoggedIn: isLoggedIn,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    ));
  }
}
