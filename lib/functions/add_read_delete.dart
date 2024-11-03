import 'package:get_storage/get_storage.dart';

class NotesAddReadDelete {
  static GetStorage box = GetStorage();
  static void addNotes({
    required String title,
    required String content,
    required String date,
    required String time,
  }) {
    Map notesMap = {
      "title": title,
      "content": content,
      "date": date,
      "time": time,
    };
    List notesList = box.read("notes") ?? [];
    notesList.add(notesMap);
    box.write("notes", notesList);
  }

  static List<dynamic> readNotes() {
    List notesList = box.read("notes") ?? [];
    // Map mp = {
    //   "notes": [
    //     {"title": ""},
    //     {"title": ""},
    //     {"title": ""},
    //   ],
    // };
    return notesList;
  }

  static void deleteSelectedNotes({required String title}) {
    List notesList = box.read("notes") ?? [];
    for (int i = 0; i < notesList.length; i++) {
      if (notesList[i]["title"] == title) {
        List notesList = box.read("notes") ?? [];
        notesList.removeAt(i);
        box.write("notes", notesList);
      }
    }
  }

  static void deleteAllNotes() {
    box.remove("notes");
  }
}
