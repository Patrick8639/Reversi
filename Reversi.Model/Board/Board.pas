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

    {-- Fields --}

      /// <summary>
      ///   The internal board.
      /// </summary>
      /// <remarks>
      ///   The index is calculated with the <see cref="GetIndex(Int32;Int32)" /> method.
      /// </remarks>
      _Board : Array Of SquareStatus;
        ReadOnly;

      /// <summary>
      ///   The border of the position.
      /// </summary>
      /// <remarks>
      ///   This is the list of all the empty squares near a disc.
      /// </remarks>
      _Border : HashSet < Int32>;
        ReadOnly;

    {-- Method --}

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

    Assembly

    {-- Method --}

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
      ///   Gets the opponent of a player.
      /// </summary>
      /// <param name="Player">The player.</param>
      /// <returns>The opponent.</returns>
      /// <exception cref="ArgumentException">
      ///   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
      ///   <see cref="SquareStatus.Light">Light</see>.
      /// </exception>
      Class Method GetOpponent (Player : SquareStatus) : SquareStatus;

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

      /// <summary>
      ///   Plays a disc to a position.
      /// </summary>
      /// <param name="Player">The player.</param>
      /// <param name="Row">The row where the disc is played.</param>
      /// <param name="Column">The column where the disc is played.</param>
      /// <returns>The number of discs returned by the player. See the remarks</returns>
      /// <exception cref="ArgumentException">
      ///   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
      ///   <see cref="SquareStatus.Light">Light</see>.<br />
      ///   -or-<br />
      ///   <paramref name="Row" /> is less than 1 or greater then <see cref="NbRows" />.<br />
      ///   -or-<br />
      ///   <paramref name="Column" /> is less than 1 or greater then <see cref="NbColumns" />.
      /// </exception>
      /// <exception cref="InvalidOperationException">
      ///   The specified position is not a valid move for <paramref name="Player" />.
      /// </exception>
      Method Play (Player : SquareStatus; Row, Column : Int32) : Int32;

      /// <summary>
      ///   Plays a disc to a position.
      /// </summary>
      /// <param name="Player">The player.</param>
      /// <param name="Position">The position where the disc is played.</param>
      /// <returns>The number of discs returned by the player. See the remarks</returns>
      /// <exception cref="ArgumentException">
      ///   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
      ///   <see cref="SquareStatus.Light">Light</see>.<br />
      ///   <paramref name="Position" /> is not a position on the board.
      /// </exception>
      /// <exception cref="InvalidOperationException">
      ///   The specified position is not a valid move for <paramref name="Player" />.
      /// </exception>
      Method Play (Player : SquareStatus; Position : Int32) : Int32;

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

    {-- Board --}
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

    {-- Border --}
    _Border := New HashSet <Int32> (32);
    _Border.UnionWith ([
      GetIndex (3, 3),
      GetIndex (3, 4),
      GetIndex (3, 5),
      GetIndex (3, 6),
      GetIndex (4, 3),
      GetIndex (4, 6),
      GetIndex (5, 3),
      GetIndex (5, 6),
      GetIndex (6, 3),
      GetIndex (6, 4),
      GetIndex (6, 5),
      GetIndex (6, 6)
    ]);

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
    _NbDarkDiscs   := Board._NbDarkDiscs;
    _NbLightDiscs  := Board._NbLightDiscs;
    _NbRows        := Board._NbRows;
    _StartPosition := Board._StartPosition;

    _Board := New SquareStatus [(_NbColumns + 1) * (_NbRows + 2) + 1];
    Board._Board.CopyTo (_Board, 0);

    _Border := New HashSet <Int32> (Board._Border)
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
      Var Opponent := GetOpponent (Player);

      For StartPos In _Border Do Begin
        Var Finished := False;

        For Move In Moves Do Begin
          Var Pos := StartPos + Move;

          If (_Board [Pos] And SquareStatus.ContentMask) = Opponent Then
            Loop Begin
              Pos := Pos + Move;

              Var Content := (_Board [Pos] And SquareStatus.ContentMask);

              If Content <> Opponent Then Begin
                If Content = Player Then Begin
                  Result.Add (StartPos);
                  Finished := True
                End;
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
(* Playing. *)

  // <summary>
  //   Plays a disc to a position.
  // </summary>
  // <param name="Player">The player.</param>
  // <param name="Row">The row where the disc is played.</param>
  // <param name="Column">The column where the disc is played.</param>
  // <returns>The number of discs returned by the player. See the remarks</returns>
  // <exception cref="ArgumentException">
  //   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
  //   <see cref="SquareStatus.Light">Light</see>.<br />
  //   -or-<br />
  //   <paramref name="Row" /> is less than 1 or greater then <see cref="NbRows" />.<br />
  //   -or-<br />
  //   <paramref name="Column" /> is less than 1 or greater then <see cref="NbColumns" />.
  // </exception>
  // <exception cref="InvalidOperationException">
  //   The specified position is not a valid move for <paramref name="Player" />.
  // </exception>

  Method Board.Play (
    Player : SquareStatus;
    Row,
    Column : Int32
  ) : Int32;

  Begin
    If Not (1 <= Row <= NbRows) Then
      Raise New ArgumentException ($'Must be between 1 and {NbRows}.', NameOf (Row));

    If Not (1 <= Column <= NbColumns) Then
      Raise New ArgumentException ($'Must be between 1 and {NbColumns}.', NameOf (Column));

    Result := Play (Player, GetIndex (Row, Column))
  End;



  // <summary>
  //   Plays a disc to a position.
  // </summary>
  // <param name="Player">The player.</param>
  // <param name="Position">The position where the disc is played.</param>
  // <returns>The number of discs returned by the player. See the remarks</returns>
  // <exception cref="ArgumentException">
  //   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
  //   <see cref="SquareStatus.Light">Light</see>.<br />
  //   <paramref name="Position" /> is not a position on the board.
  // </exception>
  // <exception cref="InvalidOperationException">
  //   The specified position is not a valid move for <paramref name="Player" />.
  // </exception>

  Method Board.Play (
    Player   : SquareStatus;
    Position : Int32
  ) : Int32;

  Begin
    If Not (0 <= Position < _Board.Length) Then
      Raise New ArgumentException ($'Must be between 0 and {_Board.Length}.', NameOf (Position));
    If Not _Border.Contains (Position) Then
      Raise New InvalidOperationException ('This is not a valid move.');

    Var Opponent := GetOpponent (Player);  // also checks the value

    ClearMarks;

    Result := 0;

    {-- Turns the discs --}
    For Move In Moves Do Begin
      Var Pos := Position + Move;

      If _Board [Pos] = Opponent Then
        Loop Begin
          Pos := Pos + Move;

          Case _Board [Pos] Of
            Opponent : ;  // continue

            Player : Begin  // discs to return
              Loop Begin
                Pos := Pos - Move;
                If _Board [Pos] <> Opponent Then
                  Break;
                _Board [Pos] := Player;
                Inc (Result)
              End;
              Break
            End;

          Else
            Break
          End;
        End

    End;

    _Board [Position] := Player;

    {-- Updates NbXxxDiscs --}
    If Player = SquareStatus.Dark Then Begin
      NbDarkDiscs  := _NbDarkDiscs  + Result + 1;
      NbLightDiscs := _NbLightDiscs - Result
    End
    Else Begin
      NbLightDiscs := _NbDarkDiscs  + Result + 1;
      NbDarkDiscs  := _NbLightDiscs - Result
    End;

    {-- Updates the border --}
    _Border.Remove (Position);

    For Move In Moves Do Begin
      Var Pos := Position + Move;
      If _Board [Pos] = SquareStatus.Empty Then
        _Border.Add (Pos)
    End

  End;

(*---------------------------------------------------------------------------------------------*)
(* Tools. *)

  // <summary>
  //   Gets the opponent of a player.
  // </summary>
  // <param name="Player">The player.</param>
  // <returns>The opponent.</returns>
  // <exception cref="ArgumentException">
  //   <paramref name="Player" /> is neither <see cref="SquareStatus.Dark">Dark</see>, nor
  //   <see cref="SquareStatus.Light">Light</see>.
  // </exception>

  Class Method Board.GetOpponent (
    Player : SquareStatus
  ) : SquareStatus;

  Begin
    Case Player Of
      SquareStatus.Dark  : Exit SquareStatus.Light;
      SquareStatus.Light : Exit SquareStatus.Dark;
    Else
      Raise New ArgumentException ('Must be Dark or Light.', NameOf (Player))
    End
  End;



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