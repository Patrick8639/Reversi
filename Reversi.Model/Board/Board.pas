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
    Board = Public Sealed Class

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

    {-- Constructor --}

      /// <summary>
      ///   Initializes a standard 8 x 8 board.
      /// </summary>
      Constructor;

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

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Constructor. *)

  // <summary>
  //   Initializes a standard 8 x 8 board.
  // </summary>

  Constructor Board;

  Begin
    _NbColumns := 8;
    _NbRows    := 8;

    {-- Initializes the board --}
    _Board := New BoardSquareStatus [(_NbColumns + 1) * (_NbRows + 2) - 1];

    With NbRows1 := _NbRows + 1 Do
      For NoColumn : Int32 := 1 To _NbColumns + 1 Do Begin
        _Board [GetIndex (0,       NoColumn    )] := BoardSquareStatus.Border;
        _Board [GetIndex (NbRows1, NoColumn - 1)] := BoardSquareStatus.Border
      End;

    For NoRow : Int32 := 1 To 7 Do
      _Board [GetIndex (NoRow, 9)] := BoardSquareStatus.Border
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
    Result := (_NbColumns + 1) * NoRow + NoColumn - 1
  End;

(*---------------------------------------------------------------------------------------------*)

End.