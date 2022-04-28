import List "mo:base/List";
import Debug "mo:base/Debug";

//canister
actor DKeeper {

  //object
  public type Note = {
    title: Text;
    content: Text;
  };

  //note array, prepend on the top of list
  stable var notes: List.List<Note> = List.nil<Note>();

  //Motoko CRUD on ICP blockchain
  public func createNote(titleText: Text, contentText: Text) {

      
      let newNote: Note= {
        title = titleText;
        content = contentText;
      };

      notes := List.push(newNote, notes);
      Debug.print(debug_show(notes));
  };

  //query make it faster, only read
  public query func readNotes(): async [Note] {
    return List.toArray(notes);
  };

  public func removeNote(id: Nat) {
    //take drop append
    let listFront = List.take(notes, id);
    let listBack = List.drop(notes, id + 1);
    notes := List.append(listFront, listBack);
  };
}