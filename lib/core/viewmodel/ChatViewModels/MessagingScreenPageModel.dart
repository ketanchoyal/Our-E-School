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

  getMessages({User other, User student, User loggedIn}) {
    var messages = _chatServices.getMessages(other, student, loggedIn);
    messages.listen((newMessage) {
      addNewMessage = newMessage;
    });
  }
}
