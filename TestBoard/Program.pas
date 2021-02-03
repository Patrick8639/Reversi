Namespace TestBoard;


(* Console application to test the reversi board..

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
    &Program = Class

    Public

      Class Method Main (Args : Array Of String);

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)

  class method &Program.Main (
    Args : Array Of String
  );

  Begin
    Var Board := New Board;

    For NoRow : Int32 := 1 To 8 Do Begin
      For NoColumn : Int32 := 1 To 8 Do Begin
        Console.Write (
          Case Board [NoRow, NoColumn] Of
            BoardSquareStatus.Border       : 'Z';
            BoardSquareStatus.Black        : 'X';
            BoardSquareStatus.White        : 'O';
            BoardSquareStatus.Empty        : '.';
            BoardSquareStatus.MoveableZone : '.';
          End);
        If NoColumn <> 8 Then
          Console.Write (' ')
      End;

      Console.WriteLine
    End;

    Console.ReadLine
  End;

(*---------------------------------------------------------------------------------------------*)

End.