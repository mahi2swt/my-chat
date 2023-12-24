import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/kb_chat.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/controller/inbox_provider.dart';
import 'package:kb_chat_module/src/presentation/widgets/chat_user_card.dart';
import 'package:kb_chat_module/src/presentation/widgets/inbox_appbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final MessageBox recivesMsgBoxDesign;
  final MessageBox sendMsgBoxDesign;
  const HomeScreen({
    super.key,
    required this.recivesMsgBoxDesign,
    required this.sendMsgBoxDesign,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InboxProvider _provider;
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<InboxProvider>(context, listen: false);
    Apis.getSelfInfo();
    _provider.checkLastStatus();
  }

  //? WillPopScopd Function
  Future<bool> onBack() {
    if (_isSearching.value) {
      _isSearching.value = !_isSearching.value;
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          return onBack();
        },
        child: Scaffold(
          appBar: InboxAppbarWidget(
            isSearching: _isSearching,
            onCancel: () {
              _isSearching.value = !_isSearching.value;
            },
            onChanged: (val) {
              _provider.searchListData(val);
            },
          ),
          body: StreamBuilder(
            stream: Apis.getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
              }
              _provider.setAllUser(snapshot.data.docs);
              return ValueListenableBuilder<bool>(
                valueListenable: _isSearching,
                builder: (context, value, child) {
                  if (_provider.userList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value
                          ? _provider.searchList.length
                          : _provider.userList.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return ChatUserCard(
                          recivesMsgBoxDesign: widget.recivesMsgBoxDesign,
                          sendMsgBoxDesign: widget.sendMsgBoxDesign,
                          user: value
                              ? _provider.searchList[index]
                              : _provider.userList[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {},
            child: const Icon(CupertinoIcons.add),
          ),
        ),
      ),
    );
  }
}
