﻿Namespace Reversi.Model;


(* A board.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: February 2, 2021
*)


Interface


  Uses
    OrdinaSoft.Aspects;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   A board.
    /// </summary>
    Board = Public Sealed Class

    Private Const

      /// <summary>
      ///   The first playable index.
      /// </summary>
      FirstPlayableIx = 10;

      /// <summary>
      ///   The last playable index.
      /// </summary>
      LastPlayableIx = 80;

    Private Class

    {-- Field --}

      /// <summary>
      ///   The legal moves.
      /// </summary>
      /// <remarks>
      ///   As the internal board is represented as a one-dimension array, the moves are
      ///   expressed as a single number.
      /// </remarks>
      Moves := [
          1,  // left
         -1,  // right
         -9,  // top
          9,  // bottom
        -10,  // top left
         -8,  // top right
         10,  // bottom right
          8   // bottom left
        ];
        ReadOnly;

    Private

    {-- Field --}

      /// <summary>
      ///   The internal board.
      /// </summary>
      /// <remarks>
      ///   The index is calculated as 
      /// </remarks>
      _Board : Array Of BoardSquareStatus;
        ReadOnly;

    {-- Methods --}

      /// <summary>
      ///   Checks and gets the index of a square.
      /// </summary>
      /// <param name="NoRow">The row number.</param>
      /// <param name="NoColumn">The column number.</param>
      /// <returns>The index.</returns>
      /// <exception cref="IndexOutOfRangeException">
      ///   <paramref name="NoRow" /> is less than 1 or greater than <see cref="NbRows" />.<br />
      ///   -or-<br />
      ///   <paramref name="NoColumn" /> is less than 1 or greater than <see cref="NbColumns" />.
      /// </exception>
      /// <remarks>
      ///   The outside rows are reserved for <see cref="BoardSquareStatus">Border</see>
      ///   squares, so the playable indexes are 1 to <see cref="NbRows" /> for
      ///   <paramref name="NoRow" /> and 1 to <see cref="NbColumns" /> for
      ///   <paramref name="NoColumn" />.
      /// </remarks>
      Method CheckAndGetIndex (NoRow, NoColumn : Int32) : Int32;

      /// <summary>
      ///   Gets the index of a square.
      /// </summary>
      /// <param name="NoRow">The row number.</param>
      /// <param name="NoColumn">The column number.</param>
      /// <returns>The index.</returns>
      /// <remarks>
      ///   The outside rows are reserved for <see cref="BoardSquareStatus">Border</see>
      ///   squares, so the playable indexes are 1 to <see cref="NbRows" /> for
      ///   <paramref name="NoRow" /> and 1 to <see cref="NbColumns" /> for
      ///   <paramref name="NoColumn" />.
      /// </remarks>
      Method GetIndex (NoRow, NoColumn : Int32) : Int32;

    Public

    {-- Constructors --}

      /// <summary>
      ///   Initializes a standard 8 x 8 board.
      /// </summary>
      Constructor;

      /// <summary>
      ///   Initializes a board from an existing one.
      /// </summary>
      /// <param name="Board">The new board.</param>
      Constructor (Board : Board);

    {-- Properties --}

      /// <summary>
      ///   Gets the number of columns.
      /// </summary>
      /// <value>The number of columns.</value>
      [Aspect: OsProperty]
      Property NbColumns : Int32
        Read;

      /// <summary>
      ///   Gets the number of rows.
      /// </summary>
      /// <value>The number of rows.</value>
      [Aspect: OsProperty]
      Property NbRows : Int32
        Read;

      /// <summary>
      ///   Gets or sets the status of a square.
      /// </summary>
      /// <param name="NoRow">The row number.</param>
      /// <param name="NoColumn">The column number.</param>
      /// <value>The status of the specified square</value>
      /// <exception cref="IndexOutOfRangeException">
      ///   <paramref name="NoRow" /> is less than 1 or greater than <see cref="NbRows" />.<br />
      ///   -or-<br />
      ///   <paramref name="NoColumn" /> is less than 1 or greater than <see cref="NbColumns" />.
      /// </exception>
      /// <remarks>
      ///   <para>
      ///     This is the default indexed property.
      ///   </para>
      ///   <para>
      ///     The outside rows are reserved for <see cref="BoardSquareStatus">Border</see>
      ///     squares, so the playable indexes are 1 to <see cref="NbRows" /> for
      ///     <paramref name="NoRow" /> and 1 to <see cref="NbColumns" /> for
      ///     <paramref name="NoColumn" />.
      ///   </para>
      /// </remarks>
      Property Square [NoRow, NoColumn : Int32] : BoardSquareStatus
        Read  _Board [CheckAndGetIndex (NoRow, NoColumn)]
        Write _Board [CheckAndGetIndex (NoRow, NoColumn)];
        Default;

    {-- Methods --}

      /// <summary>
      ///   Clears all the marks on the board.
      /// </summary>
      Method ClearMarks;

      /// <summary>
      ///   Gets the legal moves for a player.
      /// </summary>
      /// <param name="Player">The player that has to play.</param>
      /// <returns>The moves.</returns>
      /// <remarks>
      ///   If there is no move for the player, the result is an empty list.
      /// </remarks>
      Method GetMoves (Player : BoardSquareStatus) : List <Int32>;

      /// <summary>
      ///   Merks the legal moves for a player.
      /// </summary>
      /// <param name="Player">The player that has to play.</param>
      /// <returns>The moves.</returns>
      /// <remarks>
      ///   <para>
      ///     This method removes the current marks and sets marks for the legal moves.
      ///   </para>
      ///   <para>
      ///     If there is no move for the player, the result is an empty list.
      ///   </para>
      /// </remarks>
      Method MarkMoves (Player : BoardSquareStatus) : List <Int32>;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Constructors. *)

  // <summary>
  //   Initializes a standard 8 x 8 board.
  // </summary>

  Constructor Board;

  Begin
    _NbColumns := 8;
    _NbRows    := 8;

    {-- Initializes the board --}
    _Board := New BoardSquareStatus [(_NbColumns + 1) * (_NbRows + 2) + 1];

    With NbRows1 := _NbRows + 1 Do
      For NoColumn : Int32 := 1 To _NbColumns + 1 Do Begin
        _Board [GetIndex (0,       NoColumn    )] := BoardSquareStatus.Border;
        _Board [GetIndex (NbRows1, NoColumn - 1)] := BoardSquareStatus.Border
      End;

    For NoRow : Int32 := 1 To 7 Do
      _Board [GetIndex (NoRow, 9)] := BoardSquareStatus.Border;

    _Board [GetIndex (0, 0)] := BoardSquareStatus.Border;
    _Board [GetIndex (9, 9)] := BoardSquareStatus.Border

  End;



  // <summary>
  //   Initializes a board from an existing one.
  // </summary>
  // <param name="Board">The new board.</param>

  Constructor Board (
    Board : Board
  );

  Begin
    _NbColumns := Board._NbColumns;
    _NbRows    := Board._NbRows;

    Board._Board.CopyTo (_Board, 0)
  End;

(*---------------------------------------------------------------------------------------------*)
(* Index calculations. *)

  // <summary>
  //   Checks and gets the index of a square.
  // </summary>
  // <param name="NoRow">The row number.</param>
  // <param name="NoColumn">The column number.</param>
  // <returns>The index.</returns>
  // <exception cref="IndexOutOfRangeException">
  //   <paramref name="NoRow" /> is less than 1 or greater than <see cref="NbRows" />.<br />
  //   -or-<br />
  //   <paramref name="NoColumn" /> is less than 1 or greater than <see cref="NbColumns" />.
  // </exception>
  // <remarks>
  //   The outside rows are reserved for <see cref="BoardSquareStatus">Border</see>
  //   squares, so the playable indexes are 1 to <see cref="NbRows" /> for
  //   <paramref name="NoRow" /> and 1 to <see cref="NbColumns" /> for
  //   <paramref name="NoColumn" />.
  // </remarks>

  Method Board.CheckAndGetIndex (
    NoRow,
    NoColumn : Int32
  ) : Int32;

  Begin
    If Not (1 <= NoRow <= _NbRows) Then
      Raise New IndexOutOfRangeException ($'{NameOf (NoRow)} must be between 1 and {_NbRows}');
    If Not (1 <= NoColumn <= _NbColumns) Then
      Raise
        New IndexOutOfRangeException ($'{NameOf (NoColumn)} must be between 1 and {_NbColumns}');

    Result := GetIndex (NoRow, NoColumn)
  End;



  // <summary>
  //   Gets the index of a square.
  // </summary>
  // <param name="NoRow">The row number.</param>
  // <param name="NoColumn">The column number.</param>
  // <returns>The index.</returns>
  // <remarks>
  //   The outside rows are reserved for <see cref="BoardSquareStatus">Border<y/see>
  //   squares, so the playable indexes are 1 to <see cref="NbRows" /> for
  //   <paramref name="NoRow" /> and 1 to <see cref="NbColumns" /> for
  //   <paramref name="NoColumn" />.
  // </remarks>

  Method Board.GetIndex (
    NoRow,
    NoColumn : Int32
  ) : Int32;

  Begin
    Result := (_NbColumns + 1) * NoRow + NoColumn
  End;

(*---------------------------------------------------------------------------------------------*)
(* Moves. *)

  // <summary>
  //   Gets the legal moves for a player.
  // </summary>
  // <param name="Player">The player that has to play.</param>
  // <returns>The moves.</returns>
  // <remarks>
  //   If there is no move for the player, the result is an empty list.
  // </remarks>

  Method Board.GetMoves (
    Player : BoardSquareStatus
  ) : List <Int32>;

  Begin
    Result := New List <Int32>;

    Var Opponent :=
          If Player = BoardSquareStatus.Black Then
            BoardSquareStatus.White
          Else BoardSquareStatus.Black;

    For ix : Int32 := FirstPlayableIx To LastPlayableIx Do
      If (_Board [ix] And BoardSquareStatus.ContentMask) = BoardSquareStatus.Empty Then Begin
        Var Finished := False;

        For Move In Moves Do Begin
          Var Pos := ix + Move;

          If (_Board [Pos] And BoardSquareStatus.ContentMask) = Opponent Then
            Loop Begin
              Pos := Pos + Move;

              Var Content := (_Board [Pos] And BoardSquareStatus.ContentMask);

              If Content <> Opponent Then Begin
                If Content = Player Then
                  Result.Add (ix);
                Finished := True;
                Break
              End
            End;

          If Finished Then
            Break
        End
      End
  End;



  // <summary>
  //   Merks the legal moves for a player.
  // </summary>
  // <param name="Player">The player that has to play.</param>
  // <returns>The moves.</returns>
  // <remarks>
  //   <para>
  //     This method removes the current marks and sets marks for the legal moves.
  //   </para>
  //   <para>
  //     If there is no move for the player, the result is an empty list.
  //   </para>
  // </remarks>

  Method Board.MarkMoves (
    Player : BoardSquareStatus
  ) : List <Int32>;

  Begin
    ClearMarks;

    Result := GetMoves (Player);

    For ix In Result Do
      _Board [ix] := BoardSquareStatus.MoveableZone
  End;

(*---------------------------------------------------------------------------------------------*)
(* Tools. *)

  // <summary>
  //   Clears all the marks on the board.
  // </summary>

  Method Board.ClearMarks;

  Begin
    For ix : Int32 := FirstPlayableIx To LastPlayableIx Do
      _Board [ix] := _Board [ix] And BoardSquareStatus.ContentMask;
  End;

(*---------------------------------------------------------------------------------------------*)

End.