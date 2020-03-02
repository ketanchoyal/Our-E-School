import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Widgets/custom_country_code_picker/custom_country_code_picker.dart';
import 'package:ourESchool/UI/resources/months_color.dart';
import 'package:ourESchool/core/Models/holiday_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/HolidayModel.dart';
import 'package:provider/provider.dart';
import '../../BaseView.dart';
import 'holiday_details_page.dart';

class HolidayPage extends StatefulWidget {
  HolidayPage({
    Key key,
  }) : super(key: key);

  @override
  _HolidayPageState createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  String currentYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HolidayModel>(
        onModelReady: (model) => model.getHolidays(),
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: TopBar(
              onTitleTapped: () {
                model.refreshHolidays();
              },
              child: kBackBtn,
              onPressed: () {
                kbackBtn(context);
              },
              title: string.holidays,
            ),
            body: AnimatedSwitcher(
              duration: Duration(
                milliseconds: 500,
              ),
              child: HomeTab(),
            ),
          );
        });
  }

  // Widget buildRefreshButton() {
  //   return IconButton(
  //     key: ValueKey(5),
  //     icon: Icon(
  //       Icons.refresh,
  //     ),
  //     onPressed: () {
  //       holidayBloc.refreshHolidays();
  //     },
  //   );
  // }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HolidayModel>(context, listen: false);
    return Column(children: <Widget>[
      CountryTitle(),
      Expanded(
        flex: 4,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CountryCodePicker(
                initialSelection: model.currentSelectedCountryCode,
                onChanged: (countryCode) async {
                  if (countryCode != null) {
                    model.setCurrentCountryDetails(
                      countryCode: countryCode.toCountryCode(),
                      countryName: countryCode.toCountryString(),
                    );
                  }
                },
              ),
              Text(
                'Select Country',
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.display2.color),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(),
        flex: 1,
      ),
      MonthCards(
        countryCode: model.currentSelectedCountryCode,
        countryName: model.currentSelectedCountryName,
      ),
      Expanded(
        child: Container(),
        flex: 1,
      ),
    ]);
  }
}

class MonthCards extends StatefulWidget {
  final String countryCode;
  final String countryName;

  const MonthCards({
    this.countryCode,
    this.countryName,
    Key key,
  }) : super(key: key);

  @override
  MonthCardsState createState() {
    return new MonthCardsState();
  }
}

class MonthCardsState extends State<MonthCards> {
  ScrollController controller = ScrollController();

  Widget getMonthCard(BuildContext context, String month) {
    var model = Provider.of<HolidayModel>(context, listen: false);
    int monthIndex = monthToColorMap.keys.toList().indexOf(month);

    if (model.state == ViewState.Idle) {
      Map<String, List<Holiday>> monthToHolidayListMap =
          model.getMapOfMonthToHolidayList(model.holidaysValue);

      if (monthToHolidayListMap.isNotEmpty) {
        var listOfHolidayLists = monthToHolidayListMap.values.toList();
        List<Holiday> holidayList = listOfHolidayLists[monthIndex];
        List<int> holidayDates = [];
        for (var holiday in holidayList) {
          if (holidayDates.isEmpty) {
            holidayDates.add(holiday.date.datetime.day);
          } else if(!holidayDates.contains(holiday.date.datetime.day)) {
            holidayDates.add(holiday.date.datetime.day);
          }
        }

        if (holidayList.isEmpty) {
          return Align(
            alignment: Alignment(0.0, 0.0),
            child: Text(
              "No holidays \nfor this month",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  holidayList.isEmpty ? "N/A" : holidayList.elementAt(0).name,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  holidayList.length < 2 ? "" : holidayList.elementAt(1).name,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  holidayList.length < 3 ? "" : holidayList.elementAt(2).name,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${holidayList.length >= 3 ? "..." : ""}',
                      style: TextStyle(color: Colors.white70))),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: holidayDates.length.toString(),
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '${holidayList.length == 1 ? ' holiday' : " holidays"}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (monthToHolidayListMap.isEmpty) {
        return Align(
          alignment: Alignment(0.0, 0.0),
          child: Text(
            "Not available",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        );
      }
    }
// By default, show a loading spinner
    else if (model.state == ViewState.Busy || model.state2 == ViewState.Busy) {
      return kBuzyPage();
    }
    return kBuzyPage();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HolidayModel>(context, listen: false);
    return Expanded(
      flex: 10,
      child: Container(
        child: GridView.count(
          mainAxisSpacing: 2,
          controller: controller,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          padding: EdgeInsets.only(left: kFloatingActionButtonMargin),
          childAspectRatio: 1.5,
          children: monthToColorMap.keys.map(
            (String month) {
              int monthIndex = monthToColorMap.keys.toList().indexOf(month);
              return Hero(
                tag: 'hero-tag' + month,
                child: Material(
                  color: Colors.transparent,
                  child: Card(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(right: 10),
                    child: Material(
                      color: monthToColorMap[month],
                      child: InkWell(
                        onTap: () async {
                          Map<String, List<Holiday>> monthToHolidayListMap =
                              model.getMapOfMonthToHolidayList(
                                  model.holidaysValue);
                          if (monthToHolidayListMap.isNotEmpty) {
                            List<List<Holiday>> listOfHolidayLists =
                                monthToHolidayListMap.values.toList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HolidayDetailsPage(
                                      monthIndex: monthIndex,
                                      listOfHolidayList: listOfHolidayLists,
                                      countryName: widget.countryName,
                                    ),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment(-1.0, 0.5),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(month,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              indent: 16,
                              color: Colors.white54,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Align(
                                  alignment: Alignment(0.0, -0.4),
                                  child: getMonthCard(context, month),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class CountryTitle extends StatelessWidget {
  const CountryTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HolidayModel>(context, listen: false);

    return Expanded(
      flex: 6,
      child: Container(
        // color: Colors.blue,
        width: double.infinity,
        child: Align(
          alignment: Alignment(0.0, 0.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Divider(
                      indent: 30,
                      color: Theme.of(context).dividerColor,
                    )),
              ),
              Expanded(
                flex: 3,
                child: model.state2 == ViewState.Busy
                    ? Center(
                        child: SpinKitThreeBounce(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          size: 20.0,
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: model.currentSelectedCountryName,
                          style: Theme.of(context).textTheme.headline.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  indent: 30,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
