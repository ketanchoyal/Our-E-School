import 'package:ourESchool/imports.dart';

class MessagingScreenPageModel extends BaseModel {
  ChatServices _chatServices = locator<ChatServices>();

  MessagingScreenPageModel();

  sendMessage({Message message, User student}) async {
    setState(ViewState.Busy);
    await _chatServices.sendMessage(message, student);
    setState(ViewState.Idle);
  }

  Map<String, Message> messages = Map<String, Message>();

  set addNewMessage(Message newMessage) {
    messages.putIfAbsent(newMessage.id, () => newMessage);
    notifyListeners();
  }

  getMessages(
      {User other,
      User student,
      User loggedIn,
      ScrollController scrollController}) async {
    setState2(ViewState.Busy);
    var messages = _chatServices.getMessages(other, student, loggedIn);
    // scrollController.addListener(() {});
    messages.listen((newMessages) {
      newMessages.forEach((newMessage) => {addNewMessage = newMessage});

      // scrollController.animateTo(
      //   scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    });
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   print('Message Screen Model Disposed');
  // }
}
