import '../../imports.dart';
import 'package:intl/intl.dart';

// List<String> messageDates = [];

class MessagesListViewBuilder extends StatelessWidget {
  final List<Message> messagesList;
  final ScrollController scrollController;
  // List<String> messageDates = [];

  MessagesListViewBuilder({this.messagesList, this.scrollController});
  String previusDate = '';

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context, listen: false);
    return ListView.builder(
      reverse: true,
      controller: scrollController,
      itemCount: messagesList.length,
      itemBuilder: (context, index) {
        bool showDate = false;
        print(messagesList.length.toString() + " " + index.toString());

        String currentDate = '';
        if (index == messagesList.length - 1) {
          if (previusDate == '') {
            previusDate = DateFormat("d MMM y").format(
              DateTime.parse(
                messagesList[index].timeStamp.toDate().toLocal().toString(),
              ),
            );
          }
          currentDate = DateFormat("d MMM y").format(
            DateTime.parse(
              messagesList[index].timeStamp.toDate().toLocal().toString(),
            ),
          );
          showDate = true;
          // if (previusDate != currentDate) {
          //   messageDates.add(
          //     DateFormat("d MMM y").format(
          //       DateTime.parse(
          //         messagesList[index].timeStamp.toDate().toLocal().toString(),
          //       ),
          //     ),
          //   );
          //   showDate = true;
          //   previusDate = currentDate;
          // }
        } else {
          if (previusDate == '') {
            previusDate = DateFormat("d MMM y").format(
              DateTime.parse(
                messagesList[index + 1].timeStamp.toDate().toLocal().toString(),
              ),
            );
          }
          currentDate = DateFormat("d MMM y").format(
            DateTime.parse(
              messagesList[index + 1].timeStamp.toDate().toLocal().toString(),
            ),
          );
          if (previusDate != currentDate) {
            // messageDates.add(
            //   DateFormat("d MMM y").format(
            //     DateTime.parse(
            //       messagesList[index + 1]
            //           .timeStamp
            //           .toDate()
            //           .toLocal()
            //           .toString(),
            //     ),
            //   ),
            // );
            showDate = true;
            previusDate = currentDate;
          }
        }

        // print(messageDates);
        // print(showDate);

        if (messagesList[index].from == user.id) {
          return MyMessageWidget(
            message: messagesList[index],
            showDate: showDate,
          );
        } else {
          return OtherMessageWidget(
            message: messagesList[index],
            showDate: showDate,
          );
        }
      },
    );
  }
}

class OtherMessageWidget extends StatelessWidget {
  const OtherMessageWidget(
      {Key key, @required this.message, this.showDate = false})
      : super(key: key);

  final Message message;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          showDate ? _buildDateHeader(message.timeStamp) : SizedBox(),
          Material(
            elevation: 3,
            shape: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width / 4,
                maxWidth: 3 * MediaQuery.of(context).size.width / 4,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                message.message,
                textAlign: TextAlign.start,
                style: ktitleStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              DateFormat("E").add_jm().format(
                    DateTime.parse(
                      message.timeStamp.toDate().toLocal().toString(),
                    ),
                  ),
              style: ksubtitleStyle.copyWith(fontSize: 10),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget(
      {Key key, @required this.message, this.showDate = false})
      : super(key: key);

  final Message message;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          showDate ? _buildDateHeader(message.timeStamp) : SizedBox(),
          Material(
            elevation: 3,
            shape: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            // color: Theme.of(context).canvasColor.withOpacity(0.9),
            child: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                message.message,
                textAlign: TextAlign.end,
                style: ktitleStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              DateFormat("E").add_jm().format(DateTime.parse(
                  message.timeStamp.toDate().toLocal().toString())),
              style: ksubtitleStyle.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDateHeader(Timestamp timeStamp) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Card(
        elevation: 0,
        child: Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          height: 30,
          // width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              DateFormat("d MMM y").format(
                DateTime.parse(
                  timeStamp.toDate().toLocal().toString(),
                ),
              ),
              style: ksubtitleStyle.copyWith(fontSize: 10),
            ),
          ),
        ),
      ),
    ],
  );
}
