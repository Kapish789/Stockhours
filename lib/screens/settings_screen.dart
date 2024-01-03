import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/screens/notification_settings_screen.dart';
import 'package:stock_hours/services/preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, dynamic>> mappedTimezones = [
    {
      "name": "UTC-12",
      "value": -12,
    },
    {
      "name": "UTC-11",
      "value": -11,
    },
    {
      "name": "UTC-10",
      "value": -10,
    },
    {
      "name": "UTC-9.5",
      "value": -9.5,
    },
    {
      "name": "UTC-9",
      "value": -9,
    },
    {
      "name": "UTC-8",
      "value": -8,
    },
    {
      "name": "UTC-7",
      "value": -7,
    },
    {
      "name": "UTC-6",
      "value": -6,
    },
    {
      "name": "UTC-5",
      "value": -5,
    },
    {
      "name": "UTC-4",
      "value": -4,
    },
    {
      "name": "UTC-3.5",
      "value": -3.5,
    },
    {
      "name": "UTC-3",
      "value": -3,
    },
    {
      "name": "UTC-2",
      "value": -2,
    },
    {
      "name": "UTC-2.5",
      "value": -2.5,
    },
    {
      "name": "UTC-1",
      "value": -1,
    },
    {
      "name": "UTC",
      "value": 0.0,
    },
    {
      "name": "UTC+1",
      "value": 1,
    },
    {
      "name": "UTC+2",
      "value": 2,
    },
    {
      "name": "UTC+3",
      "value": 3,
    },
    {
      "name": "UTC+3.5",
      "value": 3.5,
    },
    {
      "name": "UTC+4",
      "value": 4,
    },
    {
      "name": "UTC+4.5",
      "value": 4.5,
    },
    {
      "name": "UTC+5",
      "value": 5,
    },
    {
      "name": "UTC+5.5",
      "value": 5.5,
    },
    {
      "name": "UTC+5.75",
      "value": 5.75,
    },
    {
      "name": "UTC+6",
      "value": 6,
    },
    {
      "name": "UTC+6.5",
      "value": 6.5,
    },
    {
      "name": "UTC+7",
      "value": 7,
    },
    {
      "name": "UTC+8",
      "value": 8,
    },
    {
      "name": "UTC+8.75",
      "value": 8.75,
    },
    {
      "name": "UTC+9",
      "value": 9,
    },
    {
      "name": "UTC+9.5",
      "value": 9.5,
    },
    {
      "name": "UTC+10",
      "value": 10,
    },
    {
      "name": "UTC+10.5",
      "value": 10.5,
    },
    {
      "name": "UTC+11",
      "value": 11,
    },
    {
      "name": "UTC+11.5",
      "value": 11.5,
    },
    {
      "name": "UTC+12",
      "value": 12.0,
    },
    {
      "name": "UTC+12.75",
      "value": 12.75,
    },
    {
      "name": "UTC+13",
      "value": 13.0,
    },
    {
      "name": "UTC+13.75",
      "value": 13.75,
    },
    {
      "name": "UTC+14",
      "value": 14.0,
    },
  ];

  List<DropdownMenuItem<double>> dropdownItemsList = [];
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
              SwitchSettingCard(
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
                      onPressed: () {
                        PersistentNavBarNavigator.pushDynamicScreen(context,
                            withNavBar: false,
                            screen: MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsSettingsScreen(),
                            ));
                      },
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
              SwitchSettingCard(
                text: "Dark mode",
                enabled: prefs.themeMode == ThemeMode.dark,
                onValueChange: (value) async {
                  await prefs
                      .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownSettingCard(
                text: "Timezone",
                dropdownValue: prefs.timezoneFromUTC,
                dropdownItems:
                    mappedTimezones.map<DropdownMenuItem<double>>((timeZ) {
                  return DropdownMenuItem(
                    value: timeZ["value"].toDouble(),
                    child: Text(timeZ["name"]),
                  );
                }).toList(),
                onChange: (value) async {
                  debugPrint(value.toString());
                  await prefs.setTimezoneFromUTC(value!);
                },
              ),
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

class DropdownSettingCard extends StatefulWidget {
  const DropdownSettingCard({
    super.key,
    required this.text,
    required this.dropdownItems,
    required this.dropdownValue,
    required this.onChange,
  });
  final String text;
  final List<DropdownMenuItem<double>>? dropdownItems;
  final void Function(double? value)? onChange;
  final double dropdownValue;

  @override
  State<DropdownSettingCard> createState() => _DropdownSettingCardState();
}

class _DropdownSettingCardState extends State<DropdownSettingCard> {
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
              DropdownButton(
                value: widget.dropdownValue,
                items: widget.dropdownItems,
                onChanged: widget.onChange,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SwitchSettingCard extends StatefulWidget {
  final bool expandable;
  final String text;
  final Widget expandChild;
  final bool enabled;
  final void Function(bool value) onValueChange;
  const SwitchSettingCard({
    super.key,
    this.expandable = false,
    required this.text,
    this.expandChild = const SizedBox(),
    required this.enabled,
    required this.onValueChange,
  });

  @override
  State<SwitchSettingCard> createState() => _SwitchSettingCardState();
}

class _SwitchSettingCardState extends State<SwitchSettingCard> {
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
              CupertinoSwitch(
                thumbColor: Theme.of(context).colorScheme.background,
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
