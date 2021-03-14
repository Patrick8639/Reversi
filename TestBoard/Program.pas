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

    ShowBoard (Board, 'Initial');

    Board.MarkMoves (SquareStatus.Dark);

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
            SquareStatus.Outside      : 'Z';
            SquareStatus.Dark         : 'X';
            SquareStatus.Light        : 'O';
            SquareStatus.Empty        : '.';
            SquareStatus.MoveableZone : '?';
          End);
        If NoColumn <> 8 Then
          Console.Write (' ')
      End;
      Console.WriteLine
    End
  End;

(*---------------------------------------------------------------------------------------------*)

End.            