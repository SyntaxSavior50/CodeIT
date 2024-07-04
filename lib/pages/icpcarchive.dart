import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/pages/competitive.dart';

class Icpcarchive extends StatefulWidget {
  const Icpcarchive({super.key});

  @override
  State<Icpcarchive> createState() => _IcpcarchiveState();
}

class _IcpcarchiveState extends State<Icpcarchive> {
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
                MaterialPageRoute(builder: (context) => const Competitive()),
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
    );
  }
}
