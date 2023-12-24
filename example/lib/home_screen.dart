import 'package:example/apis/apis.dart';
import 'package:example/auth/login_screen.dart';
import 'package:example/helper/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kb_chat_module/kb_chat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size(40, 40),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return KbChatModule(
                    firebaseAuthUser: Apis.user,
                    pushNotificationKey:
                        'key=AAAA8S93Gpg:APA91bFTtnCu1OFq1KRPBSBrrG486abcpt5Xc9VkYItz5TYbz3tgMch1LochW4mu7Rx7de2F-wLO--gCrjOo8SB7gv3oLOXCG_Jti4TZMuhTRIkj7lKRbfpZeYq6u0aB6bcmLkNUfOyW',
                    notificationChannelId: 'chats',
                    theme: ThemeData.dark(
                      useMaterial3: true,
                    ),
                    recivesMsgBoxDesign: MessageBox(
                      messageBoxStyle: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                        fontSize: 12,
                      ),
                      dateTimeTextStyle: const TextStyle(
                        fontSize: 8,
                      ),
                      innerPadding: const EdgeInsets.all(10),
                      outerPadding: const EdgeInsets.all(10),
                    ),
                    sendMsgBoxDesign: MessageBox(
                      messageBoxStyle: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                        fontSize: 12,
                      ),
                      dateTimeTextStyle: const TextStyle(
                        fontSize: 8,
                      ),
                      innerPadding: const EdgeInsets.all(10),
                      outerPadding: const EdgeInsets.all(10),
                    ),
                  );
                },
              ),
            );
          },
          child: const Text(
            'Chat Screen',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          Dialogs.showProgressBar(context);
          await Apis.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            });
          });
        },
        label: const Text('Logout'),
        icon: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
