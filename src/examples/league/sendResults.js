var sheet = Freesheet.sheets('League');
function sendResult(homeTeam, homeGoals, awayTeam, awayGoals) {
    sheet.input('results', {homeTeam: homeTeam, homeGoals: homeGoals, awayTeam: awayTeam, awayGoals: awayGoals});
}

function sendResults() {
    sendResult("Arsenal", 1, "Aston Villa", 3);
    sendResult("Liverpool", 1, "Stoke", 0);
    sendResult("Norwich", 2, "Everton", 2);
    sendResult("Sunderland", 0, "Fulham", 1);
    sendResult("Swansea", 1, "Man United", 4);
    sendResult("West Brom", 0, "Southampton", 1);
    sendResult("West Ham", 2, "Cardiff", 0);
    sendResult("Chelsea", 2, "Hull", 0);
    sendResult("Crystal Palace", 0, "Tottenham", 1);
    sendResult("Man City", 4, "Newcastle", 0);
    sendResult("Chelsea", 2, "Aston Villa", 1);
    sendResult("Aston Villa", 0, "Liverpool", 1);
    sendResult("Everton", 0, "West Brom", 0);
    sendResult("Fulham", 1, "Arsenal", 3);
    sendResult("Hull", 1, "Norwich", 0);
    sendResult("Newcastle", 0, "West Ham", 0);
    sendResult("Southampton", 1, "Sunderland", 1);
    sendResult("Stoke", 2, "Crystal Palace", 1);
    sendResult("Cardiff", 3, "Man City", 2);
    sendResult("Tottenham", 1, "Swansea", 0);
    sendResult("Man United", 0, "Chelsea", 0);
    sendResult("Cardiff", 0, "Everton", 0);
    sendResult("Crystal Palace", 3, "Sunderland", 1);
    sendResult("Man City", 2, "Hull", 0);
    sendResult("Newcastle", 1, "Fulham", 0);
    sendResult("Norwich", 1, "Southampton", 0);
    sendResult("West Ham", 0, "Stoke", 1);
    sendResult("Arsenal", 1, "Tottenham", 0);
    sendResult("Liverpool", 1, "Man United", 0);
    sendResult("West Brom", 0, "Swansea", 2);
    sendResult("Aston Villa", 1, "Newcastle", 2);
    sendResult("Everton", 1, "Chelsea", 0);
    sendResult("Fulham", 1, "West Brom", 1);
    sendResult("Hull", 1, "Cardiff", 1);
    sendResult("Man United", 2, "Crystal Palace", 0);
    sendResult("Stoke", 0, "Man City", 0);
    sendResult("Sunderland", 1, "Arsenal", 3);
    sendResult("Tottenham", 2, "Norwich", 0);
    sendResult("Southampton", 0, "West Ham", 0);
    sendResult("Swansea", 2, "Liverpool", 2);
    sendResult("Chelsea", 2, "Fulham", 0);
    sendResult("Liverpool", 0, "Southampton", 1);
    sendResult("Newcastle", 2, "Hull", 3);
    sendResult("Norwich", 0, "Aston Villa", 1);
    sendResult("West Brom", 3, "Sunderland", 0);
    sendResult("West Ham", 2, "Everton", 3);
    sendResult("Arsenal", 3, "Stoke", 1);
    sendResult("Cardiff", 0, "Tottenham", 1);
    sendResult("Crystal Palace", 0, "Swansea", 2);
    sendResult("Man City", 4, "Man United", 1);
    sendResult("Man United", 3, "Stoke", 2);
    sendResult("Norwich", 0, "Cardiff", 0);
    sendResult("Aston Villa", 3, "Man City", 2);
    sendResult("Fulham", 1, "Cardiff", 2);
    sendResult("Hull", 1, "West Ham", 0);
    sendResult("Man United", 1, "West Brom", 2);
    sendResult("Southampton", 2, "Crystal Palace", 0);
    sendResult("Swansea", 1, "Arsenal", 2);
    sendResult("Tottenham", 1, "Chelsea", 1);
    sendResult("Stoke", 0, "Norwich", 1);
    sendResult("Sunderland", 1, "Liverpool", 3);
    sendResult("Everton", 3, "Newcastle", 2);
    sendResult("Cardiff", 1, "Newcastle", 2);
    sendResult("Fulham", 1, "Stoke", 0);
    sendResult("Hull", 0, "Aston Villa", 0);
    sendResult("Liverpool", 3, "Crystal Palace", 1);
    sendResult("Man City", 3, "Everton", 1);
    sendResult("Sunderland", 1, "Man United", 2);
    sendResult("Norwich", 1, "Chelsea", 3);
    sendResult("Southampton", 2, "Swansea", 0);
    sendResult("Tottenham", 0, "West Ham", 3);
    sendResult("West Brom", 1, "Arsenal", 1);
    sendResult("Arsenal", 4, "Norwich", 1);
    sendResult("Chelsea", 4, "Cardiff", 1);
    sendResult("Everton", 2, "Hull", 1);
    sendResult("Man United", 1, "Southampton", 1);
    sendResult("Newcastle", 2, "Liverpool", 2);
    sendResult("Stoke", 0, "West Brom", 0);
    sendResult("Swansea", 4, "Sunderland", 0);
    sendResult("West Ham", 1, "Man City", 3);
    sendResult("Aston Villa", 0, "Tottenham", 2);
    sendResult("Crystal Palace", 1, "Fulham", 4);
    sendResult("Aston Villa", 0, "Everton", 2);
    sendResult("Crystal Palace", 0, "Arsenal", 2);
    sendResult("Liverpool", 4, "West Brom", 1);
    sendResult("Southampton", 2, "Fulham", 0);
    sendResult("Chelsea", 2, "Man City", 1);
    sendResult("Sunderland", 2, "Newcastle", 1);
    sendResult("Swansea", 0, "West Ham", 0);
    sendResult("Tottenham", 1, "Hull", 0);
    sendResult("Arsenal", 2, "Liverpool", 0);
    sendResult("Fulham", 1, "Man United", 3);
    sendResult("Hull", 1, "Sunderland", 0);
    sendResult("Man City", 7, "Norwich", 0);
    sendResult("Newcastle", 2, "Chelsea", 0);
    sendResult("Stoke", 1, "Southampton", 1);
    sendResult("West Brom", 2, "Crystal Palace", 0);
    sendResult("West Ham", 0, "Aston Villa", 0);
    sendResult("Cardiff", 1, "Swansea", 0);
    sendResult("Everton", 0, "Tottenham", 0);
    sendResult("Aston Villa", 2, "Cardiff", 0);
    sendResult("Chelsea", 2, "West Brom", 2);
    sendResult("Crystal Palace", 0, "Everton", 0);
    sendResult("Liverpool", 4, "Fulham", 0);
    sendResult("Norwich", 3, "West Ham", 1);
    sendResult("Southampton", 4, "Hull", 1);
    sendResult("Man United", 1, "Arsenal", 0);
    sendResult("Sunderland", 1, "Man City", 0);
    sendResult("Swansea", 3, "Stoke", 3);
    sendResult("Tottenham", 0, "Newcastle", 1);
    sendResult("Arsenal", 2, "Southampton", 0);
    sendResult("Everton", 3, "Liverpool", 3);
    sendResult("Fulham", 1, "Swansea", 2);
    sendResult("Hull", 0, "Crystal Palace", 1);
    sendResult("Newcastle", 2, "Norwich", 1);
    sendResult("Stoke", 2, "Sunderland", 0);
    sendResult("West Ham", 0, "Chelsea", 3);
    sendResult("Cardiff", 2, "Man United", 2);
    sendResult("Man City", 6, "Tottenham", 0);
    sendResult("West Brom", 2, "Aston Villa", 2);
    sendResult("Aston Villa", 0, "Sunderland", 0);
    sendResult("Cardiff", 0, "Arsenal", 3);
    sendResult("Everton", 4, "Stoke", 0);
    sendResult("Newcastle", 2, "West Brom", 1);
    sendResult("Norwich", 1, "Crystal Palace", 0);
    sendResult("West Ham", 3, "Fulham", 0);
    sendResult("Chelsea", 3, "Southampton", 1);
    sendResult("Hull", 3, "Liverpool", 1);
    sendResult("Man City", 3, "Swansea", 0);
    sendResult("Tottenham", 2, "Man United", 2);
    sendResult("Crystal Palace", 1, "West Ham", 0);
    sendResult("Arsenal", 2, "Hull", 0);
    sendResult("Fulham", 1, "Tottenham", 2);
    sendResult("Liverpool", 5, "Norwich", 1);
    sendResult("Man United", 0, "Everton", 1);
    sendResult("Southampton", 2, "Aston Villa", 3);
    sendResult("Stoke", 0, "Cardiff", 0);
    sendResult("Sunderland", 3, "Chelsea", 4);
    sendResult("Swansea", 3, "Newcastle", 0);
    sendResult("West Brom", 2, "Man City", 3);
    sendResult("Crystal Palace", 2, "Cardiff", 0);
    sendResult("Liverpool", 4, "West Ham", 1);
    sendResult("Man United", 0, "Newcastle", 1);
    sendResult("Southampton", 1, "Man City", 1);
    sendResult("Stoke", 3, "Chelsea", 2);
    sendResult("Sunderland", 1, "Tottenham", 2);
    sendResult("West Brom", 0, "Norwich", 2);
    sendResult("Arsenal", 1, "Everton", 1);
    sendResult("Fulham", 2, "Aston Villa", 0);
    sendResult("Swansea", 1, "Hull", 1);
    sendResult("Cardiff", 1, "West Brom", 0);
    sendResult("Chelsea", 2, "Crystal Palace", 1);
    sendResult("Everton", 4, "Fulham", 1);
    sendResult("Hull", 0, "Stoke", 0);
    sendResult("Man City", 6, "Arsenal", 3);
    sendResult("Newcastle", 1, "Southampton", 1);
    sendResult("West Ham", 0, "Sunderland", 0);
    sendResult("Aston Villa", 0, "Man United", 3);
    sendResult("Norwich", 1, "Swansea", 1);
    sendResult("Tottenham", 0, "Liverpool", 5);
    sendResult("Crystal Palace", 0, "Newcastle", 3);
    sendResult("Fulham", 2, "Man City", 4);
    sendResult("Liverpool", 3, "Cardiff", 1);
    sendResult("Man United", 3, "West Ham", 1);
    sendResult("Stoke", 2, "Aston Villa", 1);
    sendResult("Sunderland", 0, "Norwich", 0);
    sendResult("West Brom", 1, "Hull", 1);
    sendResult("Southampton", 2, "Tottenham", 3);
    sendResult("Swansea", 1, "Everton", 2);
    sendResult("Arsenal", 0, "Chelsea", 0);
    sendResult("Aston Villa", 0, "Crystal Palace", 1);
    sendResult("Cardiff", 0, "Southampton", 3);
    sendResult("Chelsea", 1, "Swansea", 0);
    sendResult("Everton", 0, "Sunderland", 1);
    sendResult("Hull", 2, "Man United", 3);
    sendResult("Man City", 2, "Liverpool", 1);
    sendResult("Newcastle", 5, "Stoke", 1);
    sendResult("Norwich", 1, "Fulham", 2);
    sendResult("Tottenham", 1, "West Brom", 1);
    sendResult("West Ham", 1, "Arsenal", 3);
    sendResult("Aston Villa", 1, "Swansea", 1);
    sendResult("Cardiff", 2, "Sunderland", 2);
    sendResult("Hull", 6, "Fulham", 0);
    sendResult("Man City", 1, "Crystal Palace", 0);
    sendResult("Norwich", 0, "Man United", 1);
    sendResult("West Ham", 3, "West Brom", 3);
    sendResult("Chelsea", 2, "Liverpool", 1);
    sendResult("Everton", 2, "Southampton", 1);
    sendResult("Newcastle", 0, "Arsenal", 1);
    sendResult("Tottenham", 3, "Stoke", 0);
    sendResult("Arsenal", 2, "Cardiff", 0);
    sendResult("Crystal Palace", 1, "Norwich", 1);
    sendResult("Fulham", 2, "West Ham", 1);
    sendResult("Liverpool", 2, "Hull", 0);
    sendResult("Man United", 1, "Tottenham", 2);
    sendResult("Southampton", 0, "Chelsea", 3);
    sendResult("Stoke", 1, "Everton", 1);
    sendResult("Sunderland", 0, "Aston Villa", 1);
    sendResult("Swansea", 2, "Man City", 3);
    sendResult("West Brom", 1, "Newcastle", 0);
    sendResult("Cardiff", 0, "West Ham", 2);
    sendResult("Everton", 2, "Norwich", 0);
    sendResult("Fulham", 1, "Sunderland", 4);
    sendResult("Hull", 0, "Chelsea", 2);
    sendResult("Man United", 2, "Swansea", 0);
    sendResult("Southampton", 1, "West Brom", 0);
    sendResult("Tottenham", 2, "Crystal Palace", 0);
    sendResult("Newcastle", 0, "Man City", 2);
    sendResult("Stoke", 3, "Liverpool", 5);
    sendResult("Aston Villa", 1, "Arsenal", 2);
    sendResult("Arsenal", 2, "Fulham", 0);
    sendResult("Crystal Palace", 1, "Stoke", 0);
    sendResult("Liverpool", 2, "Aston Villa", 2);
    sendResult("Man City", 4, "Cardiff", 2);
    sendResult("Norwich", 1, "Hull", 0);
    sendResult("Sunderland", 2, "Southampton", 2);
    sendResult("West Ham", 1, "Newcastle", 3);
    sendResult("Chelsea", 3, "Man United", 1);
    sendResult("Swansea", 1, "Tottenham", 3);
    sendResult("West Brom", 1, "Everton", 1);
    sendResult("Crystal Palace", 1, "Hull", 0);
    sendResult("Liverpool", 4, "Everton", 0);
    sendResult("Man United", 2, "Cardiff", 0);
    sendResult("Norwich", 0, "Newcastle", 0);
    sendResult("Southampton", 2, "Arsenal", 2);
    sendResult("Swansea", 2, "Fulham", 0);
    sendResult("Aston Villa", 4, "West Brom", 3);
    sendResult("Chelsea", 0, "West Ham", 0);
    sendResult("Sunderland", 1, "Stoke", 0);
    sendResult("Tottenham", 1, "Man City", 5);
    sendResult("Cardiff", 2, "Norwich", 1);
    sendResult("Everton", 2, "Aston Villa", 1);
    sendResult("Fulham", 0, "Southampton", 3);
    sendResult("Hull", 1, "Tottenham", 1);
    sendResult("Newcastle", 0, "Sunderland", 3);
    sendResult("Stoke", 2, "Man United", 1);
    sendResult("West Ham", 2, "Swansea", 0);
    sendResult("Arsenal", 2, "Crystal Palace", 0);
    sendResult("West Brom", 1, "Liverpool", 1);
    sendResult("Man City", 0, "Chelsea", 1);
    sendResult("Aston Villa", 0, "West Ham", 2);
    sendResult("Chelsea", 3, "Newcastle", 0);
    sendResult("Crystal Palace", 3, "West Brom", 1);
    sendResult("Liverpool", 5, "Arsenal", 1);
    sendResult("Norwich", 0, "Man City", 0);
    sendResult("Southampton", 2, "Stoke", 2);
    sendResult("Sunderland", 0, "Hull", 2);
    sendResult("Swansea", 3, "Cardiff", 0);
    sendResult("Man United", 2, "Fulham", 2);
    sendResult("Tottenham", 1, "Everton", 0);
    sendResult("Cardiff", 0, "Aston Villa", 0);
    sendResult("Hull", 0, "Southampton", 1);
    sendResult("West Brom", 1, "Chelsea", 1);
    sendResult("West Ham", 2, "Norwich", 0);
    sendResult("Arsenal", 0, "Man United", 0);
    sendResult("Fulham", 2, "Liverpool", 3);
    sendResult("Newcastle", 0, "Tottenham", 4);
    sendResult("Stoke", 1, "Swansea", 1);
    sendResult("Arsenal", 4, "Sunderland", 1);
    sendResult("Cardiff", 0, "Hull", 4);
    sendResult("Chelsea", 1, "Everton", 0);
    sendResult("Crystal Palace", 0, "Man United", 2);
    sendResult("Man City", 1, "Stoke", 0);
    sendResult("West Brom", 1, "Fulham", 1);
    sendResult("West Ham", 3, "Southampton", 1);
    sendResult("Liverpool", 4, "Swansea", 3);
    sendResult("Newcastle", 1, "Aston Villa", 0);
    sendResult("Norwich", 1, "Tottenham", 0);
    sendResult("Everton", 1, "West Ham", 0);
    sendResult("Fulham", 1, "Chelsea", 3);
    sendResult("Hull", 1, "Newcastle", 4);
    sendResult("Southampton", 0, "Liverpool", 3);
    sendResult("Stoke", 1, "Arsenal", 0);
    sendResult("Aston Villa", 4, "Norwich", 1);
    sendResult("Swansea", 1, "Crystal Palace", 1);
    sendResult("Tottenham", 1, "Cardiff", 0);
    sendResult("Cardiff", 3, "Fulham", 1);
    sendResult("Chelsea", 4, "Tottenham", 0);
    sendResult("Crystal Palace", 0, "Southampton", 1);
    sendResult("Norwich", 1, "Stoke", 1);
    sendResult("West Brom", 0, "Man United", 3);
    sendResult("Aston Villa", 1, "Chelsea", 0);
    sendResult("Everton", 2, "Cardiff", 1);
    sendResult("Fulham", 1, "Newcastle", 0);
    sendResult("Hull", 0, "Man City", 2);
    sendResult("Southampton", 4, "Norwich", 2);
    sendResult("Stoke", 3, "West Ham", 1);
    sendResult("Sunderland", 0, "Crystal Palace", 0);
    sendResult("Swansea", 1, "West Brom", 2);
    sendResult("Man United", 0, "Liverpool", 3);
    sendResult("Tottenham", 0, "Arsenal", 1);
    sendResult("Cardiff", 3, "Liverpool", 6);
    sendResult("Chelsea", 6, "Arsenal", 0);
    sendResult("Everton", 3, "Swansea", 2);
    sendResult("Hull", 2, "West Brom", 0);
    sendResult("Man City", 5, "Fulham", 0);
    sendResult("Newcastle", 1, "Crystal Palace", 0);
    sendResult("Norwich", 2, "Sunderland", 0);
    sendResult("West Ham", 0, "Man United", 2);
    sendResult("Aston Villa", 1, "Stoke", 4);
    sendResult("Tottenham", 3, "Southampton", 2);
    sendResult("Arsenal", 2, "Swansea", 2);
    sendResult("Man United", 0, "Man City", 3);
    sendResult("Newcastle", 0, "Everton", 3);
    sendResult("Liverpool", 2, "Sunderland", 1);
    sendResult("West Ham", 2, "Hull", 1);
    sendResult("Arsenal", 1, "Man City", 1);
    sendResult("Crystal Palace", 1, "Chelsea", 0);
    sendResult("Man United", 4, "Aston Villa", 1);
    sendResult("Southampton", 4, "Newcastle", 0);
    sendResult("Stoke", 1, "Hull", 0);
    sendResult("Swansea", 3, "Norwich", 0);
    sendResult("West Brom", 3, "Cardiff", 3);
    sendResult("Fulham", 1, "Everton", 3);
    sendResult("Liverpool", 4, "Tottenham", 0);
    sendResult("Sunderland", 1, "West Ham", 2);
    sendResult("Aston Villa", 1, "Fulham", 2);
    sendResult("Cardiff", 0, "Crystal Palace", 3);
    sendResult("Chelsea", 3, "Stoke", 0);
    sendResult("Hull", 1, "Swansea", 0);
    sendResult("Man City", 4, "Southampton", 1);
    sendResult("Newcastle", 0, "Man United", 4);
    sendResult("Norwich", 0, "West Brom", 1);
    sendResult("Everton", 3, "Arsenal", 0);
    sendResult("West Ham", 1, "Liverpool", 2);
    sendResult("Tottenham", 5, "Sunderland", 1);
    sendResult("Crystal Palace", 1, "Aston Villa", 0);
    sendResult("Fulham", 1, "Norwich", 0);
    sendResult("Southampton", 0, "Cardiff", 1);
    sendResult("Stoke", 1, "Newcastle", 0);
    sendResult("Sunderland", 0, "Everton", 1);
    sendResult("West Brom", 3, "Tottenham", 3);
    sendResult("Liverpool", 3, "Man City", 2);
    sendResult("Swansea", 0, "Chelsea", 1);
    sendResult("Arsenal", 3, "West Ham", 1);
    sendResult("Everton", 2, "Crystal Palace", 3);
    sendResult("Man City", 2, "Sunderland", 2);
    sendResult("Aston Villa", 0, "Southampton", 0);
    sendResult("Cardiff", 1, "Stoke", 1);
    sendResult("Chelsea", 1, "Sunderland", 2);
    sendResult("Newcastle", 1, "Swansea", 2);
    sendResult("Tottenham", 3, "Fulham", 1);
    sendResult("West Ham", 0, "Crystal Palace", 1);
    sendResult("Everton", 2, "Man United", 0);
    sendResult("Hull", 0, "Arsenal", 3);
    sendResult("Norwich", 2, "Liverpool", 3);
    sendResult("Man City", 3, "West Brom", 1);
    sendResult("Fulham", 2, "Hull", 2);
    sendResult("Man United", 4, "Norwich", 0);
    sendResult("Southampton", 2, "Everton", 0);
    sendResult("Stoke", 0, "Tottenham", 1);
    sendResult("Swansea", 4, "Aston Villa", 1);
    sendResult("West Brom", 1, "West Ham", 0);
    sendResult("Crystal Palace", 0, "Man City", 2);
    sendResult("Liverpool", 0, "Chelsea", 2);
    sendResult("Sunderland", 4, "Cardiff", 0);
    sendResult("Arsenal", 3, "Newcastle", 0);
    sendResult("Aston Villa", 3, "Hull", 1);
    sendResult("Man United", 0, "Sunderland", 1);
    sendResult("Newcastle", 3, "Cardiff", 0);
    sendResult("Stoke", 4, "Fulham", 1);
    sendResult("Swansea", 0, "Southampton", 1);
    sendResult("West Ham", 2, "Tottenham", 0);
    sendResult("Everton", 2, "Man City", 3);
    sendResult("Arsenal", 1, "West Brom", 0);
    sendResult("Chelsea", 0, "Norwich", 0);
    sendResult("Crystal Palace", 3, "Liverpool", 3);
    sendResult("Man United", 3, "Hull", 1);
    sendResult("Man City", 4, "Aston Villa", 0);
    sendResult("Sunderland", 2, "West Brom", 0);
    sendResult("Cardiff", 1, "Chelsea", 2);
    sendResult("Fulham", 2, "Crystal Palace", 2);
    sendResult("Hull", 0, "Everton", 2);
    sendResult("Liverpool", 2, "Newcastle", 1);
    sendResult("Man City", 2, "West Ham", 0);
    sendResult("Norwich", 0, "Arsenal", 2);
    sendResult("Southampton", 1, "Man United", 1);
    sendResult("Sunderland", 1, "Swansea", 3);
    sendResult("Tottenham", 3, "Aston Villa", 0);
    sendResult("West Brom", 1, "Stoke", 2);
}