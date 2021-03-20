Namespace Reversi.Model;


(* A board transformation.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: March 20, 2021
*)


Interface


  Uses
    OrdinaSoft;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   A board transformation.
    /// </summary>

    BoardTransform = Public Partial Sealed Class (
      DiscreteValue <BoardTransform>
    )

    Private

    {-- Class constructor --}

      /// <summary>
      ///   Initializes the static data of the class.
      /// </summary>
      Class Constructor;

    {-- Constructor --}

      /// <summary>
      ///   Initializes a board transformation value.
      /// </summary>
      /// <param name="Name">The name.</param>
      /// <param name="Value">The value.</param>
      Constructor (Name : String; Value : Int32);

    Public Const

      /// <summary>
      ///   The prefix for the resource names.
      /// </summary>
      /// <remarks>
      ///   <para>
      ///     The prefix is <b>Reversi.BoardTransform.</b>.
      ///   </para>
      ///   <para>
      ///     The resource name is constructed by appending the name of the start position to
      ///     this prefix.
      ///   </para>
      /// </remarks>
      ResNamePrefix = 'Reversi.BoardTransform.';

    Public Class

    {-- Fields --}

      /// <summary>
      ///   Starts at the left bottom corner, with horizontal row.
      /// </summary>
      LeftBottomHorizontal : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the left bottom corner, with vertical row.
      /// </summary>
      LeftBottomVertical : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the left top corner, with horizontal row.
      /// </summary>
      LeftTopHorizontal : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the left top corner, with vertical row.
      /// </summary>
      LeftTopVertical : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the right bottom corner, with horizontal row.
      /// </summary>
      RightBottomHorizontal : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the right bottom corner, with vertical row.
      /// </summary>
      RightBottomVertical : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the right top corner, with horizontal row.
      /// </summary>
      RightTopHorizontal : BoardTransform;
        ReadOnly;

      /// <summary>
      ///   Starts at the right top corner, with vertical row.
      /// </summary>
      RightTopVertical : BoardTransform;
        ReadOnly;

    Public

    {-- Constructor --}

      /// <summary>
      ///   Initializes a board transformation without any value.
      /// </summary>
      /// <remarks>
      ///   This constructor is used internally only, but must be defined as public because of
      ///   generic constraints.
      /// </remarks>
      Constructor;
        Empty;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Class constructor. *)

  // <summary>
  //   Initializes the static data of the class.
  // </summary>

  Class Constructor BoardTransform;


    Method &Add (
      Name  : String;
      Value : Int32
    ) : BoardTransform;

    Require
      Not String.IsNullOrEmpty (Name);

    Begin
      Result := Inherited &Add (New BoardTransform (Name, Value))
    End;


  Begin

    {-- Values --}
    LeftBottomHorizontal  := &Add (NameOf (LeftBottomHorizontal ), Values.LeftBottomHorizontal );
    LeftBottomVertical    := &Add (NameOf (LeftBottomVertical   ), Values.LeftBottomVertical   );
    LeftTopHorizontal     := &Add (NameOf (LeftTopHorizontal    ), Values.LeftTopHorizontal    );
    LeftTopVertical       := &Add (NameOf (LeftTopVertical      ), Values.LeftTopVertical      );
    RightBottomHorizontal := &Add (NameOf (RightBottomHorizontal), Values.RightBottomHorizontal);
    RightBottomVertical   := &Add (NameOf (RightBottomVertical  ), Values.RightBottomVertical  );
    RightTopHorizontal    := &Add (NameOf (RightTopHorizontal   ), Values.RightTopHorizontal   );
    RightTopVertical      := &Add (NameOf (RightTopVertical     ), Values.RightTopVertical     );

    InitializeList
  End;

(*---------------------------------------------------------------------------------------------*)
(* Constructor. *)

  // <summary>
  //   Initializes a board transformation value.
  // </summary>
  // <param name="Name">The name.</param>
  // <param name="Value">The value.</param>

  Constructor BoardTransform (
    Name  : String;
    Value : Int32
  );

  Require
    Assigned (Name);

  Begin
    Inherited Constructor (Name, Value, ResNamePrefix + Name)
  End;

(*---------------------------------------------------------------------------------------------*)

End.