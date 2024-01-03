import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/models/fs_models.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColors = Theme.of(context).colorScheme;
    MarketList marketList = Provider.of<MarketList>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors.background,
        foregroundColor: themeColors.primary,
        title: const Text("Notification Settings"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: marketList.markets.length,
            itemBuilder: (context, index) {
              return NotificationsSettingCard(
                market: marketList.markets[index],
                dropdownCloseValue: 0,
                dropdownOpenValue: 0,
                onCloseChange: (value) {},
                onOpenChange: (value) {},
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationsSettingCard extends StatelessWidget {
  const NotificationsSettingCard(
      {super.key,
      required this.market,
      this.onOpenChange,
      this.onCloseChange,
      required this.dropdownOpenValue,
      required this.dropdownCloseValue});
  final Market market;
  final void Function(int? value)? onOpenChange;
  final void Function(int? value)? onCloseChange;
  final int dropdownOpenValue;
  final int dropdownCloseValue;

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          market.getLabel(themeColors.inversePrimary),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Opening time: ${market.open}",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              DropdownButton(
                value: dropdownOpenValue,
                items: const [
                  DropdownMenuItem(
                    value: -15,
                    child: Text("15min before"),
                  ),
                  DropdownMenuItem(
                    value: -5,
                    child: Text("5min before"),
                  ),
                  DropdownMenuItem(
                    value: 0,
                    child: Text("At opening"),
                  ),
                ],
                onChanged: onOpenChange,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Closing time: ${market.close}",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              DropdownButton(
                value: dropdownCloseValue,
                items: const [
                  DropdownMenuItem(
                    value: -15,
                    child: Text("15min before"),
                  ),
                  DropdownMenuItem(
                    value: -5,
                    child: Text("5min before"),
                  ),
                  DropdownMenuItem(
                    value: 0,
                    child: Text("At closing"),
                  ),
                ],
                onChanged: onCloseChange,
              )
            ],
          ),
        ],
      ),
    );
  }
}
