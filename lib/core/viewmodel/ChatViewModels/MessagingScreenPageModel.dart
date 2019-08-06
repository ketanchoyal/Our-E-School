import 'package:ourESchool/imports.dart';

class MessagingScreenPageModel extends BaseModel {
  ChatServices _chatServices = locator<ChatServices>();

  MessagingScreenPageModel();

  sendMessage({Message message, User student}) async {
    setState(ViewState.Busy);
    await _chatServices.sendMessage(message, student);
    setState(ViewState.Idle);
  }

  getMessages() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }
}
