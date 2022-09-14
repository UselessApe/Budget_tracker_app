# budget_tracker_app

I created this project to learn more about actions, state, and UI updates in Flutter. This budget tracker application keeps track of your expenses. To visualize your expenses percent_indicator package was used. Also Provider Package was used. For saving light/dark mode 'shared preferences package' was used and for saving the budget 'Hive' was used as a local DB.


pages/UI:
- home
  - appbar, contains headline 
  - Light/Dark Mode
  - bottom navigation bar, used to navigate through pages
  - percent indicator which shows balance/budget and how much you already spent
  - set budget possibility through dialog
  - item/expenses
    - delete expenses option through swipe
    - add expenses/income through second dialog
      - toogle to decide if it's an expense
- history
  - appbar, contains headline and backbutton
- theme, based on ColorScheme.fromSeed

