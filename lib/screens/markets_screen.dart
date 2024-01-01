import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/models/fs_models.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MarketList marketList = Provider.of<MarketList>(context);
    DateTime now = DateTime.now().toUtc();
    int currentHour = now.hour;
    int currentMinute = now.minute;

    List<Market> openMarkets = [];
    List<Market> closeMarkets = [];

    for (Market market in marketList.markets) {
      int marketOpenHour = int.parse(market.open.split(":").first);
      int marketOpenMinute = int.parse(market.open.split(":").last);
      int marketCloseHour = int.parse(market.close.split(":").first);
      int marketCloseMinute = int.parse(market.close.split(":").last);

      bool afterOpen = false;
      bool beforeClose = false;

      if (currentHour > marketOpenHour) {
        afterOpen = true;
      } else if (currentHour == marketOpenHour) {
        if (currentMinute > marketOpenMinute) {
          afterOpen = true;
        }
      }

      if (currentHour < marketCloseHour) {
        beforeClose = true;
      } else if (currentHour == marketCloseHour) {
        if (currentMinute < marketCloseMinute) {
          beforeClose = true;
        }
      }

      if (afterOpen && beforeClose) {
        openMarkets.add(market);
      } else {
        closeMarkets.add(market);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: marketList.markets.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        ListMarkets(
                          marketsList: openMarkets,
                          areOpen: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListMarkets(
                          marketsList: closeMarkets,
                          areOpen: false,
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text("Loading..."),
                )),
    );
  }
}

class ListMarkets extends StatelessWidget {
  const ListMarkets({
    super.key,
    required this.marketsList,
    required this.areOpen,
  });

  final List<Market> marketsList;
  final bool areOpen;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: marketsList.length,
      itemBuilder: (context, index) {
        return MarketCard(isOpen: areOpen, market: marketsList[index]);
      },
    );
  }
}

class MarketCard extends StatelessWidget {
  const MarketCard({
    super.key,
    required this.isOpen,
    required this.market,
  });

  final bool isOpen;
  final Market market;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOpen
            ? CupertinoColors.activeGreen.withOpacity(0.5)
            : Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CountryFlag.fromCountryCode(
                  market.flag,
                  height: 15,
                  width: 15,
                  borderRadius: 5,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  market.name,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: isOpen
                ? Text(
                    "Open",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )
                : Text(
                    "Close",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: isOpen
                ? Text(
                    "Closes at: ${market.close}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )
                : Text(
                    "Opens at: ${market.open}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
