import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/pages/competitive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/base_screen.dart';
import '../Screens/chatPage.dart';
import 'package:icons_plus/icons_plus.dart';

import '../constant/icons.dart';

  void launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

class ICPCranking extends StatefulWidget {
  const ICPCranking({super.key});
  @override
  State<ICPCranking> createState() => _ICPCranking();
}

class _ICPCranking extends State<ICPCranking> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            'ICPC Ranking',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.dark_mode_outlined,
                color: Theme.of(context).brightness == Brightness.dark
                    ?Colors.white.withOpacity(.8)
                    :Colors.grey[800],
              ),
            ),
          ],
          leading: IconButton(
            icon: (
                Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.arrow_back_ios_rounded
                      : Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                )
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen(selectedIndex: 2)),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContestSection(
                title: 'Top 4 winners of',
                subtitle: 'ICPC World Final 2022',
                contests:[
                  ContestItem(
                    solve: 'United States',
                    teamName: 'Massachusetts Institute of Technology',
                    rank: '1st',
                  ),
                  ContestItem(
                    solve: 'China',
                    teamName: 'Peking University',
                    rank: '2nd',
                  ),
                  ContestItem(
                    solve: 'Japan',
                    teamName: 'The University of Tokyo',
                    rank: '3rd',
                  ),
                  ContestItem(
                    solve: 'South Korea',
                    teamName: 'Seoul National University',
                    rank: '4th',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ContestSection(
                title: 'Top 4 winners of',
                subtitle: 'ICPC World Final 2021',
                contests: [
                  ContestItem(
                    solve: 'Russia',
                    teamName: 'Nizhny Novgorod State University',
                    rank: '1st',
                  ),
                  ContestItem(
                    solve: 'South Korea',
                    teamName: 'Seoul National University',
                    rank: '2nd',
                  ),
                  ContestItem(
                    solve: 'Russia',
                    teamName: 'St. Petersburg ITMO University',
                    rank: '3rd',
                  ),
                  ContestItem(
                    solve: 'Russia',
                    teamName: 'Moscow Institute of Physics and Technology',
                    rank: '4th',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContestSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ContestItem> contests;

  const ContestSection({required this.title, required this.subtitle, required this.contests});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 19,
              //fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color(0xff075e34),
              fontFamily: 'Comfortaa'
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 23,
              //fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Comfortaa'
          ),
        ),
        const SizedBox(height: 10),
        for (var contest in contests) ContestTile(item: contest),
      ],
    );
  }
}

class ContestItem {
  final String teamName;
  final String solve;
  final String rank;

  ContestItem({
    required this.teamName,
    required this.solve,
    required this.rank,
  });
}

class ContestTile extends StatefulWidget {
  final ContestItem item;

  const ContestTile({required this.item});

  @override
  _ContestTileState createState() => _ContestTileState();
}

class _ContestTileState extends State<ContestTile> {

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading:
      Image.asset(
        trophy,
        height: 20,
        width: 20,
      ),
      title: Text(
        widget.item.teamName,
        style: TextStyle(
          fontSize: 19,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Comfortaa',
        ),
      ),
      subtitle: Text(
        widget.item.solve,
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color(0xff075e34),
          fontFamily: 'Comfortaa',
        ),
      ),
      trailing:Text(
            "Ranked: "+widget.item.rank,
            style: TextStyle(
            fontSize: 19,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color(0xff075e34),
            fontFamily: 'Comfortaa',
        ),
      ),
    );
  }
}