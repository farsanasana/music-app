import 'package:flutter/material.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/Screens/playlist/SinglePlayList.dart';
import 'package:newwwone/colors.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _playlistEditingController = TextEditingController();
  @override
  void initState() {
    setState(() {
      retrieveAllPlaylists();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getPlaylist();
    return ValueListenableBuilder(
      valueListenable: playlistnotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: KPprimary,
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: KBprimary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            title: const Text(
              'Playlists',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showAddToPlaylist();
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
                iconSize: 28,
              )
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: MixPrimary)),
            child: ValueListenableBuilder(
              valueListenable: playlistnotifier,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: playlistnotifier.value.isEmpty
                            ? const Center(
                                child: Text(
                                  'No playlists available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: KBprimary),
                                    height: 70,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SinglePlayListScreen(
                                                    playlistname: value[index]
                                                        .playListName!,
                                                    listIndex: playlistnotifier
                                                        .value[index],
                                                    idx: index),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text(
                                            playlistnotifier.value[index]
                                                    .playListName ??
                                                "playlist name",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                        trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  _editPlaylist(index);
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  deletePlaylist1(
                                                      context, index);
                                                },
                                                icon: const Icon(Icons.delete),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 8.0);
                                },
                                itemCount: playlistnotifier.value.length),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ignore: prefer_final_fields.
  TextEditingController playlistEditingController = TextEditingController();

  showAddToPlaylist() {
    _playlistEditingController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Create Playlist',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _playlistEditingController,
              decoration: const InputDecoration(
                labelText: 'Playlist name',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              style: const TextStyle(fontSize: 16),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a playlist name';
                } else if (playlistnotifier.value.isNotEmpty) {
                  for (var element in playlistnotifier.value) {
                    if (element.playListName == value) {
                      return 'Playlist name already exists';
                    }
                  }
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  createNewPlaylist(_playlistEditingController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editPlaylist(int index) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _editPlaylistcontroller =
        TextEditingController(text: playlistnotifier.value[index].playListName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Rename Playlist',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _editPlaylistcontroller,
              decoration: const InputDecoration(
                labelText: 'Playlist Name',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 213, 234, 23), width: 1.0),
                ),
              ),
              style: const TextStyle(fontSize: 16),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a playlist name';
                } else if (playlistnotifier.value.any((element) =>
                    element.playListName == value &&
                    element != playlistnotifier.value[index])) {
                  return 'Playlist name already exists';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String newName = _editPlaylistcontroller.text;
                  renamePlaylistByIndex(index, newName);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deletePlaylist1(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  deletePlaylistByIndex(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Playlist deleted successfully',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
