import '../model/user.dart';
import '../services/shared.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

var styleText = const TextStyle(fontSize: 25, color: Colors.white);

class MySharedPrefsPage extends StatefulWidget {
  const MySharedPrefsPage({Key? key}) : super(key: key);

  @override
  State<MySharedPrefsPage> createState() => _MySharedPrefsPageState();
}

class _MySharedPrefsPageState extends State<MySharedPrefsPage> {
  String background = "";
  late SharedPref sharedPref; // = SharedPref();
  User? userSave = User(nome: "", idade: "", location: "");
  User? userLoad = User(nome: "", idade: "", location: "");

  @override
  void initState() {
    super.initState();
  }

  loadImageBackground() async {
    var imageBackground = await sharedPref.readBackground();
    debugPrint(imageBackground.toString());
    if (imageBackground != null) {
      setState(() {
        background = imageBackground.toString();
      });
    } else {
      setState(() {
        background = "imagem3.jpg";
      });
    }
  }

  loadPreferences() async {
    try {
      var result = await sharedPref.read("user");
      if (result != null) {
        User user = User.fromMap(jsonDecode(result));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Loaded!"), duration: Duration(milliseconds: 500)));
        setState(() {
          userLoad!.nome = user.nome;
          userLoad!.idade = user.idade;
          userLoad!.location = user.location;
          debugPrint(userLoad.toString());
        });
      } else {
        setState(() {
          userLoad!.nome = "";
          userLoad!.idade = "";
          userLoad!.location = "";
        });
      }
    } catch (exception) {
      debugPrint(exception.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nothing found!"),
          duration: Duration(milliseconds: 500)));
    }
  }

  updatePreferences(User? userSave) {
    setState(() {
      userLoad!.nome = userSave!.nome;
      userLoad!.idade = userSave.idade;
      userLoad!.location = userSave.location;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, SharedPref>;
    if (args != null) {
      sharedPref = args["prefs"] ?? SharedPref();
    } else {
      sharedPref = SharedPref();
    }

    loadPreferences();
    loadImageBackground();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return userLoad!.nome != 'Maria'
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(253, 148, 124, 1),
              centerTitle: true,
              title: const Text("Shared Preferences - Example"),
              actions: [
                IconButton(
                    onPressed: () async {
                      bool a = await sharedPref.saveBackground("imagem2.jpg");
                      if (a) {
                        setState(() {
                          background = "imagem2.jpg";
                        });
                      }
                    },
                    icon: const Icon(Icons.image)),
                IconButton(
                    onPressed: () async {
                      bool a = await sharedPref.removeBackground("background");
                      if (a) {
                        setState(() {
                          background = "imagem1.jpg";
                        });
                      }
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$background'),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: const BoxConstraints.expand(),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildTextField(size, "Nome", "nome", userSave),
                          buildTextField(size, "Idade", "idade", userSave),
                          buildTextField(
                              size, "Location", "location", userSave),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: () {
                              sharedPref.save("user", userSave!.toJson());

                              sharedPref.saveLogin(userSave!.nome);

                              updatePreferences(userSave);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Saved!"),
                                      duration: Duration(milliseconds: 500)));
                            },
                            style: styleButton(),
                            child: const Text('Save',
                                style: TextStyle(fontSize: 25)),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              loadPreferences();
                            },
                            style: styleButton(),
                            child: const Text('Load',
                                style: TextStyle(fontSize: 25)),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              sharedPref.remove("user");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Cleared!"),
                                      duration: Duration(milliseconds: 500)));
                              setState(() {
                                userLoad!.nome = "";
                                userLoad!.idade = "";
                                userLoad!.location = "";
                              });
                            },
                            style: styleButton(),
                            child: const Text('Clear',
                                style: TextStyle(fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                    buildInformation(),
                  ],
                ),
              ),
            ))
        : Scaffold(
            appBar: AppBar(title: const Text("Segunda tela")),
            body: Center(
                child: OutlinedButton(
              onPressed: () {
                userLoad!.nome = "";
                sharedPref.save('user', userLoad!.toJson());
              },
              child: const Text("Tela inicial"),
            )),
          );
  }

  ButtonStyle styleButton() {
    return OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(255, 152, 127, 1));
  }

  SizedBox buildTextField(
      Size size, String? hintText, String props, User? userSave) {
    return SizedBox(
        height: 50.0,
        width: size.width * 0.9,
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() {
              if (userSave != null) {
                switch (props) {
                  case "nome":
                    userSave.nome = value;
                    break;
                  case "idade":
                    userSave.idade = value;
                    break;
                  case "location":
                    userSave.location = value;
                    break;
                  default:
                }
              }
            });
          },
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,
          ),
        ));
  }

  Widget buildInformation() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0),
      child: SizedBox(
        height: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildRowInformation("Name : ", userLoad!.nome),
            buildRowInformation("Age  : ", userLoad!.idade),
            buildRowInformation("Location: ", userLoad!.location),
          ],
        ),
      ),
    );
  }

  Row buildRowInformation(String titulo, String dado) {
    return Row(children: [
      Text(titulo, style: styleText),
      Text(dado, style: styleText),
    ]);
  }
}
