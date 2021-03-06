import 'package:flutter/material.dart';
import 'package:projet_flutter/data/models/character.dart';
import 'package:projet_flutter/data/providers/remote/authentication_firebase.dart';
import 'package:projet_flutter/pages/display_details_got/mobile/details_got_character_mobile.dart';
import 'package:projet_flutter/data/providers/remote/storage_firestore.dart';
import 'package:projet_flutter/pages/got_game/mobile/got_api_mobile.dart';
import 'package:projet_flutter/pages/sign_in/web/auth_web.dart';
import '../got_bloc.dart';

class ListGotApiMobile extends StatefulWidget {
  const ListGotApiMobile({Key? key}) : super(key: key);

  @override
  _ListGotApiState createState() => _ListGotApiState();
}

class _ListGotApiState extends State<ListGotApiMobile> {
  List<Character> _characters = [];
  late double width;
  final List<TextEditingController> _controllers = [];
  List _game = List.empty();

  Future<void> getAllCharacters() async {
    var characterList = await apiBloc.getCharacters();
    setState(() {
      _characters = characterList;
    });
  }

  Widget _getBuddy() {
    if (_characters.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _characters.length,
            itemBuilder: (context, index) {
              _controllers.add(TextEditingController());
              return displayName(index);
            }),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    StorageHelper().getGame().then((value) => {
          setState(() {
            _game = value.toList();
          })
        });
    width = MediaQuery.of(context).size.width;

    getAllCharacters();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Game of thrones"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.quiz),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GotApiMobile()));
                },
              )),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AuthWeb()));
                  AuthenticationHelper().signOut();
                },
              )),
        ],
      ),
      body: _getBuddy(),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rules of the game'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    "To print an opinion, you must to find the correct character's name"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool checkListGame(String character) {
    return _game.map((item) => item["character"] == character).contains(true);
  }

  Widget displayName(int index) {
    return Center(
      child: SizedBox(
        width: width,
        child: ListTile(
          title: Text(_characters[index].fullName),
          leading: Hero(
            tag: _characters[index],
            child: CircleAvatar(
              backgroundImage: NetworkImage(_characters[index].imageUrl),
              radius: 30,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DetailsGotCharacterMobile(character: _characters[index])));
          },
        ),
      ),
    );
  }
}
