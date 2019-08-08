import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/imports.dart';

class MessagesListViewBuilder extends StatelessWidget {
  final Map<String, Message> messageModelMap;
  // final List<String> documentIdList;

  MessagesListViewBuilder(this.messageModelMap);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageModelMap.length,
      itemBuilder: (context, index) {
        var keyy = messageModelMap.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Text(
              //   messageModelMap[documentIdList[index]].sender,
              //   style: TextStyle(
              //     color: Colors.black26,
              //   ),
              // ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    messageModelMap[keyy].message,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key key, this.student, this.parentORteacher})
      : super(key: key);
  final User parentORteacher;
  final User student;

  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  TextEditingController _messageController;
  bool sendButtonEnable = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return BaseView<MessagingScreenPageModel>(onModelReady: (model) {
      ChatServices _chatServices = locator<ChatServices>();
      return _chatServices.getMessages(widget.parentORteacher, widget.student, user);
      return model.getMessages(
          loggedIn: user,
          other: widget.parentORteacher,
          student: widget.student);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: TopBar(
          title: widget.parentORteacher.displayName,
          child: kBackBtn,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Flexible(
                child: MessagesListViewBuilder(model.messages),
              ),
              _buildMessageSender(model, user),
            ],
          ),
        ),
      );
    });
  }

  sendButtonTapped(MessagingScreenPageModel model, User user) async {
    Message message = Message(
      to: widget.parentORteacher.id,
      for_: widget.student.id,
      from: user.id,
      message: """${_messageController.text}""",
      timeStamp: Timestamp.now(),
    );

    await model.sendMessage(message: message, student: widget.student);
    _messageController.clear();
    setState(() {
      sendButtonEnable = false;
    });
  }

  Widget _buildMessageSender(MessagingScreenPageModel model, User user) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 150,
                  // maxWidth: MediaQuery.of(context).size.width - 66,
                ),
                // width: MediaQuery.of(context).size.width - 65,
                child: TextField(
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (message) {
                    if (message.trim().length > 0) {
                      setState(() {
                        sendButtonEnable = true;
                      });
                    } else {
                      setState(() {
                        sendButtonEnable = false;
                      });
                    }
                  },
                  // maxLength: 1000,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Type here....',
                    hintStyle: TextStyle(
                      height: 1.5,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        sendButtonEnable
            ? Align(
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  elevation: 5,
                  shape: kCardCircularShape,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Stack(
                      children: <Widget>[
                        model.state == ViewState.Busy
                            ? SpinKitRing(
                                color: Colors.red,
                                // size: 50,
                                lineWidth: 4,
                              )
                            : Container(),
                        model.state == ViewState.Idle
                            ? MaterialButton(
                                height: 40,
                                shape: kCardCircularShape,
                                onPressed: () {
                                  sendButtonTapped(model, user);
                                },
                                child: Icon(
                                  Icons.send,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
