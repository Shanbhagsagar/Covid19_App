class CovidModelDaily {
  double confirmedJan = 0,
      confirmedFeb = 0,
      confirmedMar = 0,
      confirmedApr = 0,
      confirmedMay = 0,
      confirmedJun = 0,
      confirmedJul = 0,
      confirmedAug = 0,
      confirmedSep = 0,
      confirmedOct = 0,
      confirmedNov = 0,
      confirmedDec = 0,
      recoveredJan = 0,
      recoveredFeb = 0,
      recoveredMar = 0,
      recoveredApr = 0,
      recoveredMay = 0,
      recoveredJun = 0,
      recoveredJul = 0,
      recoveredAug = 0,
      recoveredSep = 0,
      recoveredOct = 0,
      recoveredNov = 0,
      recoveredDec = 0,
      deceasedJan = 0,
      deceasedFeb = 0,
      deceasedMar = 0,
      deceasedApr = 0,
      deceasedMay = 0,
      deceasedJun = 0,
      deceasedJul = 0,
      deceasedAug = 0,
      deceasedSep = 0,
      deceasedOct = 0,
      deceasedNov = 0,
      deceasedDec = 0,
      totalConfirmed = 0,
      totalRecovered = 0,
      totalDeceased = 0;

  CovidModelDaily({
    this.confirmedJan,
    this.confirmedFeb,
    this.confirmedMar,
    this.confirmedApr,
    this.confirmedMay,
    this.confirmedJun,
    this.confirmedJul,
    this.confirmedAug,
    this.confirmedSep,
    this.confirmedOct,
    this.confirmedNov,
    this.confirmedDec,
    this.recoveredJan,
    this.recoveredFeb,
    this.recoveredMar,
    this.recoveredApr,
    this.recoveredMay,
    this.recoveredJun,
    this.recoveredJul,
    this.recoveredAug,
    this.recoveredSep,
    this.recoveredOct,
    this.recoveredNov,
    this.recoveredDec,
    this.deceasedJan,
    this.deceasedFeb,
    this.deceasedMar,
    this.deceasedApr,
    this.deceasedMay,
    this.deceasedJun,
    this.deceasedJul,
    this.deceasedAug,
    this.deceasedSep,
    this.deceasedOct,
    this.deceasedNov,
    this.deceasedDec,
    this.totalConfirmed,
    this.totalRecovered,
    this.totalDeceased,
  });

  CovidModelDaily.covidTotal(final json) {
    for (var i = 0; i < json.length; i++) {
      String currentDate = json[i]["date"];
      String month = currentDate.substring(3, 6);
      switch (month) {
        case "Jan":
          {
            confirmedJan += double.parse(json[i]["dailyconfirmed"]);
            recoveredJan += double.parse(json[i]["dailyrecovered"]);
            deceasedJan += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Feb":
          {
            confirmedFeb += double.parse(json[i]["dailyconfirmed"]);
            recoveredFeb += double.parse(json[i]["dailyrecovered"]);
            deceasedFeb += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Mar":
          {
            confirmedMar += double.parse(json[i]["dailyconfirmed"]);
            recoveredMar += double.parse(json[i]["dailyrecovered"]);
            deceasedMar += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Apr":
          {
            confirmedApr += double.parse(json[i]["dailyconfirmed"]);
            recoveredApr += double.parse(json[i]["dailyrecovered"]);
            deceasedApr += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "May":
          {
            confirmedMay += double.parse(json[i]["dailyconfirmed"]);
            recoveredMay += double.parse(json[i]["dailyrecovered"]);
            deceasedMay += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Jun":
          {
            confirmedJun += double.parse(json[i]["dailyconfirmed"]);
            recoveredJun += double.parse(json[i]["dailyrecovered"]);
            deceasedJun += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Jul":
          {
            confirmedJul += double.parse(json[i]["dailyconfirmed"]);
            recoveredJul += double.parse(json[i]["dailyrecovered"]);
            deceasedJul += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Aug":
          {
            confirmedAug += double.parse(json[i]["dailyconfirmed"]);
            recoveredAug += double.parse(json[i]["dailyrecovered"]);
            deceasedAug += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Sep":
          {
            confirmedSep += double.parse(json[i]["dailyconfirmed"]);
            recoveredSep += double.parse(json[i]["dailyrecovered"]);
            deceasedSep += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Oct":
          {
            confirmedOct += double.parse(json[i]["dailyconfirmed"]);
            recoveredOct += double.parse(json[i]["dailyrecovered"]);
            deceasedOct += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Nov":
          {
            confirmedNov += double.parse(json[i]["dailyconfirmed"]);
            recoveredNov += double.parse(json[i]["dailyrecovered"]);
            deceasedNov += double.parse(json[i]["dailydeceased"]);
          }
          break;

        case "Dec":
          {
            confirmedDec += double.parse(json[i]["dailyconfirmed"]);
            recoveredDec += double.parse(json[i]["dailyrecovered"]);
            deceasedDec += double.parse(json[i]["dailydeceased"]);
          }
          break;
      }
    }
    totalConfirmed = double.parse(json.last["totalconfirmed"]);
    totalRecovered = double.parse(json.last["totalrecovered"]);
    totalDeceased = double.parse(json.last["totaldeceased"]);

    confirmedNov = null;
    recoveredNov = null;
    deceasedNov = null;
    confirmedDec = null;
    recoveredDec = null;
    deceasedDec = null;
  }
}

class CovidModelStately {
  List<String> stateList = [];
  Map<String, String> stateMap = {'': ''};

  CovidModelStately({this.stateList});

  CovidModelStately.covidTotalState(final json) {
    for (var i = 1; i < json.length; i++) {
      stateList.add(json[i]["state"]);
      stateMap[json[i]["state"]] = json[i]["confirmed"] +
          " " +
          json[i]["recovered"] +
          " " +
          json[i]["deaths"];
    }
    stateList.remove("State Unassigned");
    stateMap.remove("State Unassigned");
    stateList.sort();
  }
}

class CovidModelCountry {
  List<String> countryList = [];

  double confirmedJan ,
      confirmedFeb ,
      confirmedMar ,
      confirmedApr ,
      confirmedMay ,
      confirmedJun ,
      confirmedJul ,
      confirmedAug ,
      confirmedSep ,
      confirmedOct ,
      confirmedNov ,
      confirmedDec ,
      recoveredJan ,
      recoveredFeb ,
      recoveredMar ,
      recoveredApr ,
      recoveredMay ,
      recoveredJun ,
      recoveredJul ,
      recoveredAug ,
      recoveredSep ,
      recoveredOct ,
      recoveredNov ,
      recoveredDec ,
      deceasedJan ,
      deceasedFeb ,
      deceasedMar ,
      deceasedApr ,
      deceasedMay ,
      deceasedJun ,
      deceasedJul ,
      deceasedAug ,
      deceasedSep ,
      deceasedOct ,
      deceasedNov ,
      deceasedDec ,
      totalConfirmed ,
      totalRecovered ,
      totalDeceased ;

  CovidModelCountry({
    this.confirmedJan,
    this.confirmedFeb,
    this.confirmedMar,
    this.confirmedApr,
    this.confirmedMay,
    this.confirmedJun,
    this.confirmedJul,
    this.confirmedAug,
    this.confirmedSep,
    this.confirmedOct,
    this.confirmedNov,
    this.confirmedDec,
    this.recoveredJan,
    this.recoveredFeb,
    this.recoveredMar,
    this.recoveredApr,
    this.recoveredMay,
    this.recoveredJun,
    this.recoveredJul,
    this.recoveredAug,
    this.recoveredSep,
    this.recoveredOct,
    this.recoveredNov,
    this.recoveredDec,
    this.deceasedJan,
    this.deceasedFeb,
    this.deceasedMar,
    this.deceasedApr,
    this.deceasedMay,
    this.deceasedJun,
    this.deceasedJul,
    this.deceasedAug,
    this.deceasedSep,
    this.deceasedOct,
    this.deceasedNov,
    this.deceasedDec,
    this.totalConfirmed,
    this.totalRecovered,
    this.totalDeceased,
    this.countryList,
  });

  CovidModelCountry.covidTotalCountry(final json, String country) {
    try{
      for (int i = 0; i < json[country].length; i++) {
        String currentDate = json[country][i]["date"];
        int month = int.parse(currentDate.split("-")[1]);
        switch (month) {
          case 1:
            {
              confirmedJan = double.parse(json[country][i]["confirmed"].toString());
              recoveredJan = double.parse(json[country][i]["recovered"].toString());
              deceasedJan = double.parse(json[country][i]["deaths"].toString());
            }
            break;

          case 2:
            {
              confirmedFeb = double.parse(json[country][i]["confirmed"].toString())-confirmedJan;
              recoveredFeb = double.parse(json[country][i]["recovered"].toString())-recoveredJan;
              deceasedFeb = double.parse(json[country][i]["deaths"].toString())-recoveredJan;
            }
            break;

          case 3:
            {
              confirmedMar = double.parse(json[country][i]["confirmed"].toString())-confirmedFeb-confirmedJan;
              recoveredMar = double.parse(json[country][i]["recovered"].toString())-recoveredFeb-recoveredJan;
              deceasedMar = double.parse(json[country][i]["deaths"].toString())-deceasedFeb-deceasedJan;
            }
            break;

          case 4:
            {
              confirmedApr = double.parse(json[country][i]["confirmed"].toString())-confirmedMar-confirmedFeb-confirmedJan;
              recoveredApr = double.parse(json[country][i]["recovered"].toString())-recoveredMar-recoveredFeb-recoveredJan;
              deceasedApr = double.parse(json[country][i]["deaths"].toString())-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 5:
            {
              confirmedMay = double.parse(json[country][i]["confirmed"].toString())-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredMay = double.parse(json[country][i]["recovered"].toString())-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedMay = double.parse(json[country][i]["deaths"].toString())-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 6:
            {
              confirmedJun = double.parse(json[country][i]["confirmed"].toString())-confirmedMay-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredJun = double.parse(json[country][i]["recovered"].toString())-recoveredMay-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedJun = double.parse(json[country][i]["deaths"].toString())-deceasedMay-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 7:
            {
              confirmedJul = double.parse(json[country][i]["confirmed"].toString())-confirmedJun-confirmedMay-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredJul = double.parse(json[country][i]["recovered"].toString())-recoveredJun-recoveredMay-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedJul = double.parse(json[country][i]["deaths"].toString())-deceasedJun-deceasedMay-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 8:
            {
              confirmedAug = double.parse(json[country][i]["confirmed"].toString())-confirmedJul-confirmedJun-confirmedMay-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredAug = double.parse(json[country][i]["recovered"].toString())-recoveredJul-recoveredJun-recoveredMay-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedAug = double.parse(json[country][i]["deaths"].toString())-deceasedJul-deceasedJun-deceasedMay-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 9:
            {
              confirmedSep = double.parse(json[country][i]["confirmed"].toString())-confirmedAug-confirmedJul-confirmedJun-confirmedMay-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredSep = double.parse(json[country][i]["recovered"].toString())-recoveredAug-recoveredJul-recoveredJun-recoveredMay-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedSep = double.parse(json[country][i]["deaths"].toString())-deceasedAug-deceasedJul-deceasedJun-deceasedMay-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 10:
            {
              confirmedOct = double.parse(json[country][i]["confirmed"].toString())-confirmedSep-confirmedAug-confirmedJul-confirmedJun-confirmedMay-confirmedApr-confirmedMar-confirmedFeb-confirmedJan;
              recoveredOct = double.parse(json[country][i]["recovered"].toString())-recoveredSep-recoveredAug-recoveredJul-recoveredJun-recoveredMay-recoveredApr-recoveredMar-recoveredFeb-recoveredJan;
              deceasedOct = double.parse(json[country][i]["deaths"].toString())-deceasedSep-deceasedAug-deceasedJul-deceasedJun-deceasedMay-deceasedApr-deceasedMar-deceasedFeb-deceasedJan;
            }
            break;

          case 11:
            {
              confirmedNov = double.parse(json[country][i]["confirmed"].toString());
              recoveredNov = double.parse(json[country][i]["recovered"].toString());
              deceasedNov = double.parse(json[country][i]["deaths"].toString());
            }
            break;

          case 12:
            {
              confirmedDec = double.parse(json[country][i]["confirmed"].toString());
              recoveredDec = double.parse(json[country][i]["recovered"].toString());
              deceasedDec = double.parse(json[country][i]["deaths"].toString());
            }
            break;
        }
        totalConfirmed = double.parse(json[country].last["confirmed"].toString());
        totalRecovered = double.parse(json[country].last["recovered"].toString());
        totalDeceased = double.parse(json[country].last["deaths"].toString());
      }

    }
    catch(e){
      print('ExceptionHere');
    }
  }
  CovidModelCountry.covidTotalCountryList(final json){
    countryList.addAll(json.keys);
  }

}
