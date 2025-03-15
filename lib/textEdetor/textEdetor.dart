import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:AI_editor_app/Api/loging_api.dart';

class TextEdetor extends StatefulWidget {
  @override
  _TextEdetorState createState() => _TextEdetorState();
}

class _TextEdetorState extends State<TextEdetor> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  bool _showAllChats = false;
  String name = "hi";
  String email = "hi";
  String responce = '';

  final code = r"""
function myFunction() {
    let x = 10;
    if (x > 5) {
        console.log("X is greater than 5");
    } else {
        console.log("X is not greater than 5");
    }

    const obj = {
        key: "value",
        anotherKey: "value2"
    };

    obj.newKey = 'newValue';
    console.log(obj);

    for (let i = 0; i < 10; i++) {
        console.log(`Count is: ${i}`);
    }

    return x;
}
""";
  List<String?> _chats = [];
  String _selectedMode = "gemini";
  bool _isCodeMode = false;
  List<String> _aiModes = ["gemini", "chat gpt"];

  @override
  void initState() {
    super.initState();
    print("Widget Initialized");
    fetchUserProfile();
    fetchUserchats(); // Force a rebuild
  }

  Future<void> fetchUserProfile() async {
    final userData = await profile(context);
    if (userData != null) {
      setState(() {
        name = userData['name']!;
        email = userData['email']!;
      });
      print("Fetched Name: $name");
      print("Fetched Email: $email");
    } else {
      print("Failed to fetch user profile.");
    }
  }

  Future<void> fetchUserchats() async {
    final chatnams = await chats(context);
    if (chatnams != null) {
      setState(() {
        _chats = chatnams;
      });
    } else {
      print("Failed to fetch user chats.");
    }
  }

  Future<void> _sendMessage() async {
    final response = await sendToAPI(_messageController.text, context);
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {"text": _messageController.text, "isMe": true});
        _messageController.clear();
        _isTyping = false;
      });
      if (response != null) {
        setState(() {
          _messages.insert(0, {"text": response, "isMe": false});
        });
      }
    }
  }

  Future<void> _sendMessageCod() async {
    final response =
        await sendToAPIcode(_messageController.text, code, context);
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {"text": _messageController.text, "isMe": true});
        _messageController.clear();
        _isTyping = false;
      });
      if (response != null) {
        setState(() {
          responce = response['response']!;
          _messages.insert(0, {"text": responce, "isMe": false});
        });
      }
    }
  }

  bool _isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: GestureDetector(
        onTap: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen; 
          });
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            'assets/icons/sidebar.svg',
            height: 18,
            width: 18,
            fit: BoxFit.cover,
          ),
        ),
      )),
      body: Stack(
        children: [
        
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Align(
                      alignment: message["isMe"]
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message["isMe"]
                              ? Color.fromARGB(255, 234, 230, 230)
                              : const Color.fromARGB(255, 255, 250, 250),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message["text"],
                          style: TextStyle(
                            color:
                                message["isMe"] ? Colors.black : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 156, 156, 160)),
                        color: Color.fromARGB(255, 237, 236, 236),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10),
                          value: _selectedMode,
                          dropdownColor: Color.fromARGB(255, 237, 236, 236),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMode = newValue!;
                            });
                          },
                          items: _aiModes
                              .map<DropdownMenuItem<String>>((String mode) {
                            return DropdownMenuItem<String>(
                              value: mode,
                              child: Text(mode),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 156, 156, 160)),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCodeMode = true;
                              });
                            },
                            child: CircleAvatar(
                                maxRadius: 15,
                                backgroundColor: _isCodeMode
                                    ? Color.fromARGB(255, 211, 210, 210)
                                    : Colors.transparent,
                                child: SvgPicture.asset(
                                  'assets/icons/code.svg',
                                  width: 15,
                                  height: 15,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCodeMode = false;
                              });
                            },
                            child: CircleAvatar(
                                maxRadius: 15,
                                backgroundColor: !_isCodeMode
                                    ? Color.fromARGB(255, 211, 210, 210)
                                    : Colors.transparent,
                                child: SvgPicture.asset(
                                  'assets/icons/terminal.svg',
                                  width: 15,
                                  height: 15,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildMessageInput(),
            ],
          ),
          _buildSideMenu(),
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMenuOpen = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {},
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(_isMenuOpen ? 0 : -280, 0, 0),
        width: 280,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Recent chats",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Expanded(
            child: _chats.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: _chats.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _showAllChats
                                          ? _chats.length
                                          : (_chats.length > 4
                                              ? 4
                                              : _chats.length),
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            _chats[index]!,
                                            style: TextStyle(fontSize: 10),
                                            overflow: TextOverflow
                                                .ellipsis, // Truncate long names
                                          ),
                                          trailing: Icon(Icons.more_vert),
                                        );
                                      },
                                    ),
                                  ),
                                  if (_chats.length > 4)
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _showAllChats =
                                              !_showAllChats; 
                                        });
                                      },
                                      child: Text(
                                        _showAllChats
                                            ? "Show Less"
                                            : "View All (${_chats.length})",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.all(-10),
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/icons/person.png",
                            height: 10,
                            width: 10,
                          ),
                        ),
                        title: Text(name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle:
                            Text(email, style: TextStyle(color: Colors.black)),
                        trailing: GestureDetector(
                          onTap: () {
                            _showBottomMenu(context);
                            print("Icon tapped!");
                          },
                          child: SvgPicture.asset(
                            'assets/icons/up-down.svg',
                            height: 35,
                            width: 35,
                          ), 
                        ),
                      ),
                    ],
                  ),
          )
        ]));
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        height: 50.h,
        child: TextField(
          controller: _messageController,
          onSubmitted: (value) {
            _sendMessage();
          },
          onChanged: (text) {
            setState(() {
              _isTyping = text.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: "Type a message...",
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 156, 156, 160), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 156, 156, 160), width: 1.0),
            ),
            filled: true,
            suffixIcon: _isTyping
                ? GestureDetector(
                    onTap: () {
                      if (!_isCodeMode) {
                        _sendMessage();
                      } else {
                        _sendMessageCod();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          'assets/icons/send1.svg',
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}

void _showBottomMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
