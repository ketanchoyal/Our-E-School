import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/resources/custom_expansion_panel.dart';
import 'package:ourESchool/UI/resources/months_color.dart';
import 'package:ourESchool/core/Models/holiday_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HolidayDetailsPage extends StatefulWidget {
  final int monthIndex;
  final List<List<Holiday>> listOfHolidayList;
  final String countryName;

  HolidayDetailsPage(
      {Key key,
      @required this.countryName,
      @required this.monthIndex,
      @required this.listOfHolidayList})
      : super(key: key);

  @override
  HolidayDetailsPageState createState() {
    return new HolidayDetailsPageState();
  }
}

class HolidayDetailsPageState extends State<HolidayDetailsPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int initialMonthIndex;
  int currentMonthIndex;
  double screenWidth;
  List<List<Holiday>> listOfHolidayLists;
  List<Holiday> currentMonthHolidayList;
  Animation<double> dividerIndentAnimation;
  AnimationController animationController;
  String month;

  @override
  void initState() {
    super.initState();
    initialMonthIndex = widget.monthIndex;
    currentMonthIndex = initialMonthIndex;
    listOfHolidayLists = widget.listOfHolidayList;
    currentMonthHolidayList = listOfHolidayLists[currentMonthIndex];
    month = monthToColorMap.keys.toList()[currentMonthIndex];

    _pageController = PageController(initialPage: initialMonthIndex);

    animationController =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);

    dividerIndentAnimation = Tween<double>(begin: 5000.0, end: 0.0)
        //Chose 5000.0 as arbitrary begin value
        .animate(animationController)
          ..addListener(() {
            setState(() {
              //This animates the divider indent by update its state
            });
          });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: month,
      ),
      body: PageView.builder(
        onPageChanged: (pageId) {
          setState(() {
            currentMonthIndex = pageId;
            currentMonthHolidayList = listOfHolidayLists[currentMonthIndex];
            month = monthToColorMap.keys.toList()[pageId];
          });
        },
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: monthToColorMap.length,
        itemBuilder: (context, position) {
          month = monthToColorMap.keys.toList()[position];
          return Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.black,
                  ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: ListTile(
                  leading: Text(""),
                  title: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${currentMonthHolidayList.length == 0 ? "No" : currentMonthHolidayList.length} ${currentMonthHolidayList.length == 1 ? "holiday" : "holidays"}",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Divider(
                        indent: dividerIndentAnimation.value,
                        height: 2,
                        color: Theme.of(context).dividerColor,
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              flex: 11,
              child: currentMonthHolidayList.isEmpty
                  ? Center(
                      child: Text(
                        "No holidays this month",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: SafeArea(
                          child: Container(
                            child: CustomExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  currentMonthHolidayList[index].isExpanded =
                                      !currentMonthHolidayList[index]
                                          .isExpanded;
                                });
                              },
                              children: currentMonthHolidayList
                                  .map((Holiday holiday) {
                                return CustomExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      // dense: true,
                                      title: Text(
                                        holiday.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),

                                      subtitle: Text(
                                        // 'DateFormat',
                                        DateFormat.EEEE()
                                            .format(DateTime.parse(
                                                holiday.date.iso))
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            // .subhead
                                            .subtitle
                                            .copyWith(
                                              fontWeight: FontWeight.w300,
                                            ),
                                        // style: TextStyle(

                                        // ),
                                      ),
                                      leading: Text(
                                        holiday.date.datetime.day.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                                fontWeight: FontWeight.w300),
                                      ),
                                    );
                                  },
                                  body: Container(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: ListTile(
                                        // dense: true,
                                        leading: Text(""),
                                        title: Text(
                                          holiday.description ??
                                              "No description available",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isExpanded: holiday.isExpanded,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ]);
        },
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight + 20,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: monthToColorMap.keys.map((String month) {
              int monthIndex = monthToColorMap.keys.toList().indexOf(month);
              return Hero(
                tag: 'hero-tag' + month,
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return Flex(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(child: fromHeroContext.widget),
                    ],
                    direction: Axis.horizontal,
                  );
                },
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 00.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width / 30,
                      height: currentMonthIndex == monthIndex
                          ? (kBottomNavigationBarHeight / 1.2) + 20
                          : (kBottomNavigationBarHeight / 2.0) + 15,
                      color: monthToColorMap.values.toList()[monthIndex],
                      // child: Text("kk"),
                    ),
                  ),
                ),
              );
            }).toList()),
      ), // ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
