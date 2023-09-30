import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stack square'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool isUpdate = false;
  int updateIndex = 0;

  List<UserHorizontal> listHoriziontal = [
    UserHorizontal(
        avatar: "https://picsum.photos/100/100?image=92",
        name: "Lorem",
        title: "Day la tin nhan"),
    UserHorizontal(
        avatar: "https://picsum.photos/100/100?image=90",
        name: "Lorem",
        title: "Day la tin nhan")
  ];

  List<UserHorizontal> listFull = [
    UserHorizontal(
        avatar: "https://picsum.photos/100/100?image=92",
        name: "Lorem",
        title: "Day la tin nhan"),
    UserHorizontal(
        avatar: "https://picsum.photos/100/100?image=90",
        name: "Lorem",
        title: "Day la tin nhan")
  ];

  void addUserHandle() {
    if (_userController.text.isEmpty) {
      print('Vui lòng điền tên tài khoản');
    } else {
      final userAdd = UserHorizontal(
          avatar: "https://picsum.photos/100/100?image=92",
          name: _userController.text,
          title: _messageController.text);

      if (isUpdate) {
        setState(() {
          listHoriziontal[updateIndex] = userAdd;
          listFull[updateIndex] = userAdd;
          isUpdate = false;
          updateIndex = 0;
        });
      } else {
        setState(() {
          listHoriziontal.add(userAdd);
          listFull.add(userAdd);
        });
      }
      //clear text
      _userController.clear();

      _messageController.clear();
      //ẩn bàn phím sau khi thêm user
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void deleteUserHandle(index) {
    setState(() {
      listHoriziontal.removeAt(index);
      listFull.removeAt(index);
    });
  }

  void editUserHandle(index) {
    setState(() {
      _userController.text = listHoriziontal[index].name ?? '';
      _messageController.text = listHoriziontal[index].title ?? '';
      isUpdate = true;
      updateIndex = index;
    });
  }

  void searchHandle(text) {
    setState(() {
      if (text.isEmpty) {
        listHoriziontal.clear();
        listHoriziontal.addAll(listFull);
      } else {
        listHoriziontal = listHoriziontal
            .where((element) =>
                element.name
                    ?.toLowerCase()
                    .contains(text.toString().toLowerCase()) ??
                false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: AppBar(
          title: const Center(child: Text('Messenger')),
          backgroundColor: Colors.purple,
        ),
        body: Container(
            color: const Color.fromARGB(255, 227, 226, 226),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25, top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 1.0),
                            ),
                            contentPadding: EdgeInsets.only(left: 40)),
                        style: const TextStyle(height: 0.5, fontSize: 22),
                        onChanged: (text) {
                          searchHandle(text);
                        },
                      ),
                      const Positioned(
                          left: 10,
                          child: Icon(Icons.search, color: Colors.purple))
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: listHoriziontal.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                              listHoriziontal[index].avatar ??
                                                  "")),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(listHoriziontal[index].name ?? ""),
                                        Text(listHoriziontal[index].title ?? "")
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.purple),
                                      onPressed: () {
                                        editUserHandle(index);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        deleteUserHandle(index);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        })),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 1.0),
                            ),
                            hintText: 'Username'),
                        style: const TextStyle(height: 0.5),
                        controller: _userController,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 1.0),
                              ),
                              hintText: 'Message12121212'),
                          style: const TextStyle(height: 0.5),
                          controller: _messageController,
                        ),
                      ),
                      InkWell(
                        child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.purple),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: double.infinity,
                            child: Center(
                                child: Text(isUpdate ? 'Sửa' : 'Thêm',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)))),
                        onTap: () {
                          addUserHandle();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class UserHorizontal {
  String? avatar;
  String? name;
  String? title;
  UserHorizontal({required this.avatar, required this.name, this.title});
}
