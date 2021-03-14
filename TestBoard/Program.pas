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

    {-- Methods --}

      /// <summary>
      ///   Makes a benchmark of the move generator.
      /// </summary>
      /// <param name="NbLevels">The number of levels.</param>
      Class Method BenchmarkGenerator (NbLevels : Int32);

      /// <summary>
      ///   Generate all the boards at a specified level.
      /// </summary>
      /// <param name="Board">The board.</param>
      /// <param name="Player">The player who must play.</param>
      /// <param name="NbLevels">The number of levels.</param>
      /// <returns>The number of boards.</returns>
      Class Method GenerateBoards (Board : Board; Player : SquareStatus; NbLevels : Int32)
        : Int32;

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

    BenchmarkGenerator (7);

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
(* Move generator benchmark. *)

  // <summary>
  //   Makes a benchmark of the move generator.
  // </summary>
  // <param name="NbLevels">The number of levels.</param>

  Class Method &Program.BenchmarkGenerator (
    NbLevels : Int32
  );

  Begin
    For Level : Int32 := 1 To NbLevels Do Begin
      Var sw := New Stopwatch;
      sw.Start;
      Var Board   := New Board;
      Var NbMoves := GenerateBoards (Board, SquareStatus.Dark, Level);
      sw.Stop;

      Var NbMilliseconds := Double (1000 * sw.ElapsedTicks) / sw.Frequency;

      Console.WriteLine (
        'Level ' + Level.ToString + ': '
        + NbMoves.ToString + ' positions in ' + NbMilliseconds.ToString ('0.000') + 'ms ('
        + (NbMilliseconds / NbMoves).ToString ('0.000000') + 'ms per position)'
      )
    End
  End;



  // <summary>
  //   Generate all the boards at a specified level.
  // </summary>
  // <param name="Board">The board.</param>
  // <param name="Player">The player who must play.</param>
  // <param name="NbLevels">The number of levels.</param>
  // <returns>The number of boards.</returns>

  Class Method &Program.GenerateBoards (
    Board    : Board;
    Player   : SquareStatus;
    NbLevels : Int32
  ) : Int32;

  Begin
    Var Moves := Board.GetMoves (Player);

    If NbLevels = 1 Then
      Exit Moves.Count;

    Dec (NbLevels);

    Result := 0;

    Var Opponent := 
          If Player = SquareStatus.Dark Then
            SquareStatus.Light
          Else SquareStatus.Dark;

    For Move In Moves Do Begin
      Var NewBoard := New Board (Board);
      NewBoard.Play (Player, Move);
      Inc (Result, GenerateBoards (NewBoard, Opponent, NbLevels))
    End
  End;

(*---------------------------------------------------------------------------------------------*)

End.            