import '../../imports.dart';
import 'package:intl/intl.dart';

class MessagesListViewBuilder extends StatelessWidget {
  final Map<String, Message> messageModelMap;
  final ScrollController scrollController;
  // final List<String> documentIdList;

  MessagesListViewBuilder(this.messageModelMap, this.scrollController);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return ListView.builder(
      // reverse: true,
      // shrinkWrap: true,
      controller: scrollController,
      itemCount: messageModelMap.length,
      itemBuilder: (context, index) {
        var keyy = messageModelMap.keys.elementAt(index);
        if (messageModelMap[keyy].from == user.id) {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Material(
                  elevation: 3,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  // color: Theme.of(context).canvasColor.withOpacity(0.9),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 4,
                      maxWidth: 3 * MediaQuery.of(context).size.width / 4,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      messageModelMap[keyy].message,
                      textAlign: TextAlign.end,
                      style: ktitleStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    DateFormat("E").add_jm().format(DateTime.parse(
                        messageModelMap[keyy]
                            .timeStamp
                            .toDate()
                            .toLocal()
                            .toString())),
                    style: ksubtitleStyle.copyWith(fontSize: 10),
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // )
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  elevation: 3,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  // color: Theme.of(context).canvasColor.withOpacity(0.9),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 4,
                      maxWidth: 3 * MediaQuery.of(context).size.width / 4,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      messageModelMap[keyy].message,
                      textAlign: TextAlign.start,
                      style: ktitleStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    DateFormat("E").add_jm().format(DateTime.parse(
                        messageModelMap[keyy]
                            .timeStamp
                            .toDate()
                            .toLocal()
                            .toString())),
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
      },
    );
  }
}
