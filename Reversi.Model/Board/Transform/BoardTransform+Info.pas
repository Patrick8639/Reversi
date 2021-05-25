Namespace Reversi.Model;


(* Information about a board transformation.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: March 20, 2021
*)


Interface


(*---------------------------------------------------------------------------------------------*)

  Type
    BoardTransform = Public Partial Sealed Class End;


    /// <summary>
    ///   Information about a board transformation.
    /// </summary>
    /// <remarks>
    ///   Each information contains a start position and the number of squares to add for an
    ///   horizontal and a vertical move.
    /// </remarks>

    Info Nested In BoardTransform = Public Sealed Class

    Public

    {-- Constructor --}

      /// <summary>
      ///   Initializes an instance of the class.
      /// </summary>
      /// <param name="Board">The board.</param>
      /// <param name="Transform">The transform.</param>
      Constructor (Board : Board; Transform : BoardTransform);

    {-- Fields --}

      /// <summary>
      ///   The horizontal move.
      /// </summary>
      HorizontalMove : Int32;
        ReadOnly;

      /// <summary>
      ///   The start position.
      /// </summary>
      /// <remarks>
      ///   This is the index of the first position.
      /// </remarks>
      StartPosition : Int32;
        ReadOnly;

      /// <summary>
      ///   The transformation.
      /// </summary>
      Transform : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   The vertical move.
      /// </summary>
      VerticalMove : Int32;
        ReadOnly;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Constructor. *)

  // <summary>
  //   Initializes an instance of the class.
  // </summary>
  // <param name="Board">The board.</param>
  // <param name="Transform">The transform.</param>

  Constructor BoardTransform.Info (
    Board     : Board;
    Transform : BoardTransform
  );

  Require
    Assigned (Board);
    Assigned (Transform);

  Begin
    Self.Transform := Transform;

    Var VertMove := Board.NbColumns + 1;

    Case Transform.Value Of

      BoardTransform.Values.LeftBottomHorizontal : Begin
        StartPosition  := Board.GetIndex (Board.NbRows, 1);
        HorizontalMove := 1;
        VerticalMove   := - VertMove
      End;

      BoardTransform.Values.LeftBottomVertical : Begin
        StartPosition  := Board.GetIndex (Board.NbRows, 1);
        HorizontalMove := - VertMove;
        VerticalMove   := 1
      End;

      BoardTransform.Values.LeftTopHorizontal : Begin
        StartPosition  := Board.GetIndex (1, 1);
        HorizontalMove := 1;
        VerticalMove   := VertMove
      End;

      BoardTransform.Values.LeftTopVertical : Begin
        StartPosition  := Board.GetIndex (1, 1);
        HorizontalMove := VertMove;
        VerticalMove   := 1
      End;

      BoardTransform.Values.RightBottomHorizontal : Begin
        StartPosition  := Board.GetIndex (Board.NbRows, Board.NbColumns);
        HorizontalMove := -1;
        VerticalMove   := - VertMove
      End;

      BoardTransform.Values.RightBottomVertical : Begin
        StartPosition  := Board.GetIndex (Board.NbRows, Board.NbColumns);
        HorizontalMove := - VertMove;
        VerticalMove   := -1
      End;

      BoardTransform.Values.RightTopHorizontal : Begin
        StartPosition  := Board.GetIndex (1, Board.NbColumns);
        HorizontalMove := -1;
        VerticalMove   := VertMove
      End;

      BoardTransform.Values.RightTopVertical : Begin
        StartPosition  := Board.GetIndex (1, Board.NbColumns);
        HorizontalMove := VertMove;
        VerticalMove   := -1
      End;

    End
  End;

(*---------------------------------------------------------------------------------------------*)

End.