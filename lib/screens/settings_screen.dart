import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            children: [
              SwitchSettingsCard(
                text: "App notifications",
                expandable: true,
                expandChildren: [
                  TextButton(
                    onPressed: () {},
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
              SizedBox(
                height: 10,
              ),
              SwitchSettingsCard(
                text: "Theme mode",
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

class SwitchSettingsCard extends StatefulWidget {
  final bool expandable;
  final String text;
  final List<Widget> expandChildren;
  const SwitchSettingsCard({
    super.key,
    this.expandable = false,
    required this.text,
    this.expandChildren = const [],
  });

  @override
  State<SwitchSettingsCard> createState() => _SwitchSettingsCardState();
}

class _SwitchSettingsCardState extends State<SwitchSettingsCard> {
  ExpansionTileController tileController = ExpansionTileController();
  bool optionValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: widget.expandable
          ? Theme(
              data: ThemeData().copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && !optionValue) {
                    tileController.collapse();
                  }
                  if (!value && optionValue) {
                    tileController.expand();
                  }
                },
                title: const Text("App notifications"),
                backgroundColor: Colors.transparent,
                controller: tileController,
                trailing: Switch.adaptive(
                  value: optionValue,
                  onChanged: (value) {
                    setState(() {
                      optionValue = value;
                    });
                    if (value) tileController.expand();
                    if (!value) tileController.collapse();
                  },
                ),
                children: widget.expandChildren,
              ),
            )
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.text),
                  Switch.adaptive(
                    value: optionValue,
                    onChanged: (value) {
                      setState(() {
                        optionValue = value;
                      });
                      if (value) tileController.expand();
                      if (!value) tileController.collapse();
                    },
                  ),
                ],
              ),
          ),
    );
  }
}
