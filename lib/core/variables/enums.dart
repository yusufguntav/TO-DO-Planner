enum MenuTitles {
  home,
  settings,
  calendar,
  allTasks,
  dbtc;

  String get getMenuHeroTag {
    switch (this) {
      case MenuTitles.home:
        return "Home";
      case MenuTitles.settings:
        return "Settings";
      case MenuTitles.calendar:
        return "Calendar";
      case MenuTitles.allTasks:
        return "AllTasks";
      case MenuTitles.dbtc:
        return "DBTC";
    }
  }
}
