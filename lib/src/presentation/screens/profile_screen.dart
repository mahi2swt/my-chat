import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/utils/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  List<ChatUserModel> userList = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5000.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.user.image,
                            placeholder: (context, url) =>
                                const Icon(CupertinoIcons.person),
                            errorWidget: (context, url, error) =>
                                const Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {},
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => Apis.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'eg. Happy Singh',
                      label: const Text('Name'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => Apis.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.info_outline, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'eg. Feeling Happy',
                      label: const Text('About'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size(40, 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Apis.updateUserInfo().then(
                          (value) {
                            Dialogs.showSnackbar(
                              context,
                              'Profile Updated Successfully!',
                              MsgType.sucess,
                            );
                          },
                        );
                      }
                    },
                    icon: const Icon(Icons.edit, size: 28),
                    label: const Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: Colors.redAccent,
        //   onPressed: () async {
        //     Dialogs.showProgressBar(context);
        //     await Apis.auth.signOut().then((value) async {
        //       await GoogleSignIn().signOut().then((value) {
        //         Navigator.pop(context);
        //         Navigator.pop(context);
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => const LoginScreen(),
        //           ),
        //         );
        //       });
        //     });
        //   },
        //   label: const Text('Logout'),
        //   icon: const Icon(Icons.logout_outlined),
        // ),
      ),
    );
  }
}
