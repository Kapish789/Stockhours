import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/services/preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Preferences prefs = Provider.of<Preferences>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SwitchSettingsCard(
                text: "App notifications",
                enabled: prefs.notifications,
                onValueChange: (value) async {
                  await prefs.setNotifications(value);
                },
                expandable: true,
                expandChild: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () async {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Text(
                        "Customize notifications",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SwitchSettingsCard(
                text: "Dark mode",
                enabled: prefs.themeMode == ThemeMode.dark,
                onValueChange: (value) async {
                  await prefs
                      .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
              Text(prefs.notifications.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Options in settings:
// - timezone
// - app notifications overall switch
//  - notifications preferences for each market

class SwitchSettingsCard extends StatefulWidget {
  final bool expandable;
  final String text;
  final Widget expandChild;
  final bool enabled;
  final void Function(bool value) onValueChange;
  const SwitchSettingsCard({
    super.key,
    this.expandable = false,
    required this.text,
    this.expandChild = const SizedBox(),
    required this.enabled,
    required this.onValueChange,
  });

  @override
  State<SwitchSettingsCard> createState() => _SwitchSettingsCardState();
}

class _SwitchSettingsCardState extends State<SwitchSettingsCard> {
  ExpansionTileController tileController = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Switch.adaptive(
                thumbColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.background),
                  activeColor: Theme.of(context).colorScheme.primary,
                value: widget.enabled,
                onChanged: widget.onValueChange,
              )
            ],
          ),
          if (widget.expandable && widget.enabled) widget.expandChild
        ],
      ),
    );
  }
}
