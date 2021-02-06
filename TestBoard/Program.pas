Namespace TestBoard;


(* Console application to test the Reversi board.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: February 3, 2021
*)


Interface


  Uses
    Reversi.Model;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   Console application to test the Reversi board.
    /// </summary>
    &Program = Class

    Private

    {-- Method --}

      /// <summary>
      ///   Shows a board on the the console.
      /// </summary>
      /// <param name="Board">The board.</param>
      /// <param name="Title">The title.</param>
      Class Method ShowBoard (Board : Board; Title : String);

    Public

      /// <summary>
      ///   Program entry point.
      /// </summary>
      Class Method Main;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Program. *)

  // <summary>
  //   Program entry point.
  // </summary>

  class method &Program.Main;

  Begin
    Var Board := New Board;

    Board [4, 4] := BoardSquareStatus.Black;
    Board [5, 5] := BoardSquareStatus.Black;
    Board [4, 5] := BoardSquareStatus.White;
    Board [5, 4] := BoardSquareStatus.White;

    ShowBoard (Board, 'Initial');

    Board.MarkMoves (BoardSquareStatus.Black);

    ShowBoard (Board, 'Moves marked');

    Console.ReadLine
  End;

(*---------------------------------------------------------------------------------------------*)
(* Tools. *)

  // <summary>
  //   Shows a board on the the console.
  // </summary>
  // <param name="Board">The board.</param>
  // <param name="Title">The title.</param>

  Class Method &Program.ShowBoard (
    Board : Board;
    Title : String
  );

  Begin
    Console.WriteLine (Title);

    For NoRow : Int32 := 1 To Board.NbRows Do Begin
      For NoColumn : Int32 := 1 To Board.NbColumns Do Begin
        Console.Write (
          Case Board [NoRow, NoColumn] Of
            BoardSquareStatus.Border       : 'Z';
            BoardSquareStatus.Black        : 'X';
            BoardSquareStatus.White        : 'O';
            BoardSquareStatus.Empty        : '.';
            BoardSquareStatus.MoveableZone : '?';
          End);
        If NoColumn <> 8 Then
          Console.Write (' ')
      End;
      Console.WriteLine
    End
  End;

(*---------------------------------------------------------------------------------------------*)

End.            