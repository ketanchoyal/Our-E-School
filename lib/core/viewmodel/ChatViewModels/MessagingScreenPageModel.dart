import 'package:ourESchool/imports.dart';

class MessagingScreenPageModel extends BaseModel {
  ChatServices _chatServices = locator<ChatServices>();

  MessagingScreenPageModel();

  sendMessage({Message message, AppUser student}) async {
    setState(ViewState.Busy);
    await _chatServices.sendMessage(message, student);
    setState(ViewState.Idle);
  }

  Map<String, Message> messages = Map<String, Message>();

  set addNewMessage(Message newMessage) {
    messages.putIfAbsent(newMessage.id, () => newMessage);
    notifyListeners();
  }

  ChatServices get chatServices => _chatServices;

  // getMessages(
  //     {User other,
  //     User student,
  //     User loggedIn,
  //     ScrollController scrollController}) async* {
  //   setState2(ViewState.Busy);
  //   Stream<List<Message>> messages =
  //       _chatServices.getMessages(other, student, loggedIn);

  //   messages.listen((newMessages) {
  //     newMessages.forEach((newMessage) => {addNewMessage = newMessage});
  //   });
  // }
}
