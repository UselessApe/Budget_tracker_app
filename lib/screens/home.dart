import 'package:budgettrackerapp/pages/history/budget_history_page.dart';
import 'package:budgettrackerapp/pages/home/home_page.dart';
import 'package:budgettrackerapp/services/budget_view_model.dart';
import 'package:budgettrackerapp/services/theme_service.dart';
import 'package:budgettrackerapp/widgets/add_budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: true);
    List<BottomNavigationBarItem> bottomNavItems = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      //TODO implement currency change option / Settingspage
      // TODO implement Login UI
      //TODO save data to firebase
    ];

    List<Widget> pages = const [
      HomePage(),
      BudgetHistoryPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddBudgetDialog(
                      budgetToAdd: (budget) {
                        final budgetService = Provider.of<BudgetViewModel>(
                            context,
                            listen: false);
                        budgetService.budget = budget;
                      },
                    );
                  },
                );
                setState(() {});
              },
              icon: const Icon(Icons.attach_money))
        ],
        title: const Text("BUDGET TRACKER"),
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(
            () {
              _currentPageIndex = index;
            },
          );
        },
      ),
    );
  }
}
