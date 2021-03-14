Namespace Reversi.Model;


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
    /// <seealso cref="SquareStatus" />
    /// <seealso cref="StartPosition" />

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
      _Board : Array Of SquareStatus;
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
      ///   The outside rows are reserved for <see cref="SquareStatus">Outside</see> squares, so
      ///   the playable indexes are 1 to <see cref="NbRows" /> for <paramref name="NoRow" /> and
      ///   1 to <see cref="NbColumns" /> for <paramref name="NoColumn" />.
      /// </remarks>
      Method CheckAndGetIndex (NoRow, NoColumn : Int32) : Int32;

      /// <summary>
      ///   Gets the index of a square.
      /// </summary>
      /// <param name="NoRow">The row number.</param>
      /// <param name="NoColumn">The column number.</param>
      /// <returns>The index.</returns>
      /// <remarks>
      ///   The outside rows are reserved for <see cref="SquareStatus">Outside</see> squares, so
      ///   the playable indexes are 1 to <see cref="NbRows" /> for <paramref name="NoRow" /> and
      ///   1 to <see cref="NbColumns" /> for <paramref name="NoColumn" />.
      /// </remarks>
      Method GetIndex (NoRow, NoColumn : Int32) : Int32;

    Public

    {-- Constructors --}

      /// <summary>
      ///   Initializes an 8 x 8 board, with the
      ///   <see cref="Reversi.Model.StartPosition.Standard">standard start position</see>.
      /// </summary>
      Constructor;

      /// <summary>
      ///   Initializes an 8 x 8 board, with the specified start position.
      /// </summary>
      /// <param name="StartPosition">The start position.</param>
      /// <exception cref="ArgumentNullException">
      ///   <paramref name="StartPosition" /> is <b>null</b>.
      /// </exception>
      Constructor (StartPosition : StartPosition);

      /// <summary>
      ///   Initializes a board from an existing one.
      /// </summary>
      /// <param name="Board">The new board.</param>
      /// <exception cref="ArgumentNullException">
      ///   <paramref name="Board" /> is <b>null</b>.
      /// </exception>
      Constructor (Board : Board);

    {-- Properties --}

      /// <summary>
      ///   Gets the number of columns.
      /// </summary>
      /// <value>The number of columns.</value>
      [Aspect: OsProperty]
      Property NbColumns : Int32;
        ReadOnly;

      /// <summary>
      ///   Gets the number of dark discs.
      /// </summary>
      /// <value>The number of dark discs.</value>
      [Aspect: OsNotifyPropertyChanged]
      Property NbDarkDiscs : Int32
        Read Private Write;

      /// <summary>
      ///   Gets the number of light discs.
      /// </summary>
      /// <value>The number of light discs.</value>
      [Aspect: OsNotifyPropertyChanged]
      Property NbLightDiscs : Int32
        Read Private Write;

      /// <summary>
      ///   Gets the number of rows.
      /// </summary>
      /// <value>The number of rows.</value>
      [Aspect: OsProperty]
      Property NbRows : Int32;
        ReadOnly;

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
      ///     The outside rows are reserved for <see cref="SquareStatus">Outer</see> squares, so
      ///     the playable indexes are 1 to <see cref="NbRows" /> for <paramref name="NoRow" />
      ///     and 1 to <see cref="NbColumns" /> for <paramref name="NoColumn" />.
      ///   </para>
      /// </remarks>
      Property Square [NoRow, NoColumn : Int32] : SquareStatus
        Read  _Board [CheckAndGetIndex (NoRow, NoColumn)]
        Write _Board [CheckAndGetIndex (NoRow, NoColumn)];
        Default;

      /// <summary>
      ///   Gets the start position.
      /// </summary>
      /// <value>The start position.</value>
      [Aspect: OsProperty]
      Property StartPosition : StartPosition;
        ReadOnly;

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
      Method GetMoves (Player : SquareStatus) : List <Int32>;

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
      Method MarkMoves (Player : SquareStatus) : List <Int32>;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Constructors. *)

  // <summary>
  //   Initializes an 8 x 8 board, with the
  //   <see cref="Reversi.Model.StartPosition.Standard">standard start position</see>.
  // </summary>

  Constructor Board;

  Begin
    Constructor (StartPosition.Standard)
  End;



  // <summary>
  //   Initializes an 8 x 8 board, with the specified start position.
  // </summary>
  // <param name="StartPosition">The start position.</param>
  // <exception cref="ArgumentNullException">
  //   <paramref name="StartPosition" /> is <b>null</b>.
  // </exception>

  Constructor Board (
    StartPosition : StartPosition
  );

  Begin
    If Not Assigned (StartPosition) Then
      Raise New ArgumentNullException (NameOf (StartPosition));

    _NbColumns     := 8;
    _NbRows        := 8;
    _StartPosition := StartPosition;

    {-- Initializes the board --}
    _Board := New SquareStatus [(_NbColumns + 1) * (_NbRows + 2) + 1];

    With NbRows1 := _NbRows + 1 Do
      For NoColumn : Int32 := 1 To _NbColumns + 1 Do Begin
        _Board [GetIndex (0,       NoColumn    )] := SquareStatus.Outside;
        _Board [GetIndex (NbRows1, NoColumn - 1)] := SquareStatus.Outside
      End;

    For NoRow : Int32 := 1 To 7 Do
      _Board [GetIndex (NoRow, 9)] := SquareStatus.Outside;

    _Board [GetIndex (0, 0)] := SquareStatus.Outside;
    _Board [GetIndex (9, 9)] := SquareStatus.Outside;

    {-- Start position --}
    Case StartPosition Of

      StartPosition.LightBottom : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Dark;
        _Board [GetIndex (4, 5)] := SquareStatus.Dark;
        _Board [GetIndex (5, 4)] := SquareStatus.Light;
        _Board [GetIndex (5, 5)] := SquareStatus.Light
      End;

      StartPosition.LightLeft : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Light;
        _Board [GetIndex (4, 5)] := SquareStatus.Dark;
        _Board [GetIndex (5, 4)] := SquareStatus.Light;
        _Board [GetIndex (5, 5)] := SquareStatus.Dark
      End;

      StartPosition.LightRight : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Dark;
        _Board [GetIndex (4, 5)] := SquareStatus.Light;
        _Board [GetIndex (5, 4)] := SquareStatus.Dark;
        _Board [GetIndex (5, 5)] := SquareStatus.Light
      End;

      StartPosition.LightTop : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Light;
        _Board [GetIndex (4, 5)] := SquareStatus.Light;
        _Board [GetIndex (5, 4)] := SquareStatus.Dark;
        _Board [GetIndex (5, 5)] := SquareStatus.Dark
      End;

      StartPosition.Standard : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Light;
        _Board [GetIndex (4, 5)] := SquareStatus.Dark;
        _Board [GetIndex (5, 4)] := SquareStatus.Dark;
        _Board [GetIndex (5, 5)] := SquareStatus.Light
      End;

      StartPosition.StandardInverted : Begin
        _Board [GetIndex (4, 4)] := SquareStatus.Dark;
        _Board [GetIndex (4, 5)] := SquareStatus.Light;
        _Board [GetIndex (5, 4)] := SquareStatus.Light;
        _Board [GetIndex (5, 5)] := SquareStatus.Dark
      End;

    End;

    {-- NbXxxDiscs --}
    If StartPosition <> StartPosition.Empty Then Begin
      _NbDarkDiscs  := 2;
      _NbLightDiscs := 2
    End

  End;



  // <summary>
  //   Initializes a board from an existing one.
  // </summary>
  // <param name="Board">The new board.</param>
  // <exception cref="ArgumentNullException">
  //   <paramref name="Board" /> is <b>null</b>.
  // </exception>

  Constructor Board (
    Board : Board
  );

  Begin
    If Not Assigned (Board) Then
      Raise New ArgumentNullException (NameOf (Board));

    _NbColumns     := Board._NbColumns;
    _NbRows        := Board._NbRows;
    _StartPosition := Board._StartPosition;

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
  //   The outside rows are reserved for <see cref="SquareStatus">Outside</see> squares, so
  //   the playable indexes are 1 to <see cref="NbRows" /> for <paramref name="NoRow" /> and
  //   1 to <see cref="NbColumns" /> for <paramref name="NoColumn" />.
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
  //   The outside rows are reserved for <see cref="SquareStatus">Outside</see> squares, so
  //   the playable indexes are 1 to <see cref="NbRows" /> for <paramref name="NoRow" /> and
  //   1 to <see cref="NbColumns" /> for <paramref name="NoColumn" />.
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
    Player : SquareStatus
  ) : List <Int32>;

  Begin
    Result := New List <Int32> (32);

    {-- Special case for the first 4 discs of an empty position --}
    If (_NbDarkDiscs + _NbLightDiscs) < 4 Then Begin

      With Pos := GetIndex (4, 4) Do
        If _Board [Pos] And SquareStatus.ContentMask = SquareStatus.Empty Then
          Result.Add (Pos);

      With Pos := GetIndex (4, 5) Do
        If _Board [Pos] And SquareStatus.ContentMask = SquareStatus.Empty Then
          Result.Add (Pos);

      With Pos := GetIndex (5, 4) Do
        If _Board [Pos] And SquareStatus.ContentMask = SquareStatus.Empty Then
          Result.Add (Pos);

      With Pos := GetIndex (5, 5) Do
        If _Board [Pos] And SquareStatus.ContentMask = SquareStatus.Empty Then
          Result.Add (Pos);

    End

    {-- Normal case --}
    Else Begin
      Var Opponent :=
            If Player = SquareStatus.Dark Then
              SquareStatus.Light
            Else SquareStatus.Dark;

      For ix : Int32 := FirstPlayableIx To LastPlayableIx Do
        If (_Board [ix] And SquareStatus.ContentMask) = SquareStatus.Empty Then Begin
          Var Finished := False;

          For Move In Moves Do Begin
            Var Pos := ix + Move;

            If (_Board [Pos] And SquareStatus.ContentMask) = Opponent Then
              Loop Begin
                Pos := Pos + Move;

                Var Content := (_Board [Pos] And SquareStatus.ContentMask);

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
    Player : SquareStatus
  ) : List <Int32>;

  Begin
    ClearMarks;

    Result := GetMoves (Player);

    For ix In Result Do
      _Board [ix] := SquareStatus.MoveableZone
  End;

(*---------------------------------------------------------------------------------------------*)
(* Tools. *)

  // <summary>
  //   Clears all the marks on the board.
  // </summary>

  Method Board.ClearMarks;

  Begin
    For ix : Int32 := FirstPlayableIx To LastPlayableIx Do
      _Board [ix] := _Board [ix] And SquareStatus.ContentMask;
  End;

(*---------------------------------------------------------------------------------------------*)

End.