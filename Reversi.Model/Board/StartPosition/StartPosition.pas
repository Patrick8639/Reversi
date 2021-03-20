Namespace Reversi.Model;


(* The start position for a game.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: March 14, 2021
*)


Interface


  Uses
    OrdinaSoft;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   The start position for a game.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///     The <see cref="Null">Null</see> property is not defined in this class.
    ///   </para>
    ///   <para>
    ///     For all starting positions, the 4 first discs are placed in the center of the board.
    ///   </para>
    ///
    ///   <h3>Text resources</h3>
    ///   <para>
    ///     All the texts used by the class are taken from text resources files. The assembly
    ///     defines the texts in English and in French. Other languages can be added with the
    ///     <see cref="TextResourcesDict">text resources dictionary</see>.
    ///   </para>
    ///   <para>
    ///     The texts resources are in the <c>Reversi.StartPosition</c> group, with the name of
    ///     the start position appended.
    ///   </para>
    ///
    ///   <h3>Values</h3>
    ///   <para>
    ///     The values are defined in the <see cref="Values" /> nested class.
    ///   </para>
    ///
    /// </remarks>
    /// <seealso cref="Values" />

    StartPosition = Public Partial Sealed Class (
      DiscreteValue <StartPosition>
    )

    Private

    {-- Class constructor --}

      /// <summary>
      ///   Initializes the static data of the class.
      /// </summary>
      Class Constructor;

    {-- Constructor --}

      /// <summary>
      ///   Initializes a start position value.
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
      ///     The prefix is <b>Reversi.StartPosition.</b>.
      ///   </para>
      ///   <para>
      ///     The resource name is constructed by appending the name of the start position to
      ///     this prefix.
      ///   </para>
      /// </remarks>
      ResNamePrefix = 'Reversi.StartPosition.';

    Public Class

    {-- Fields --}

      /// <summary>
      ///   The game starts with an empty board and the players play the four first discs in the
      ///   center, without the need to return the opponent discs.
      /// </summary>
      &Empty : StartPosition;
        ReadOnly;

      /// <summary>
      ///   The position with two light discs at the bottom.
      /// </summary>
      /// <remarks>
      ///   The two dark discs are at the top.
      /// </remarks>
      LightBottom : StartPosition;
        ReadOnly;

      /// <summary>
      ///   The position with two light discs at the left.
      /// </summary>
      /// <remarks>
      ///   The two dark discs are at the right.
      /// </remarks>
      LightLeft : StartPosition;
        ReadOnly;

      /// <summary>
      ///   The position with two light discs at the right.
      /// </summary>
      /// <remarks>
      ///   The two dark discs are at the left.
      /// </remarks>
      LightRight : StartPosition;
        ReadOnly;

      /// <summary>
      ///   The position with two light discs at the top.
      /// </summary>
      /// <remarks>
      ///   The two dark discs are at the bottom.
      /// </remarks>
      LightTop : StartPosition;
        ReadOnly;

      /// <summary>
      ///   The standard <i>Othello</i> start position.
      /// </summary>
      /// <remarks>
      ///   The discs are placed in a diagonal pattern, with a light disc at the top left.
      /// </remarks>
      Standard: StartPosition;
        ReadOnly;

      /// <summary>
      ///   The inverted standard <i>Othello</i> start position.
      /// </summary>
      /// <remarks>
      ///   The discs are placed in a diagonal pattern, with a dark disc at the top left.
      /// </remarks>
      StandardInverted: StartPosition;
        ReadOnly;

    Public

    {-- Constructor --}

      /// <summary>
      ///   Initializes a start position without any value.
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

  Class Constructor StartPosition;


    Method &Add (
      Name  : String;
      Value : Int32
    ) : StartPosition;

    Require
      Not String.IsNullOrEmpty (Name);

    Begin
      Result := Inherited &Add (New StartPosition (Name, Value))
    End;


  Begin

    {-- Values --}
    &Empty           := &Add (NameOf (&Empty          ), Values.Empty           );
    LightBottom      := &Add (NameOf (LightBottom     ), Values.LightBottom     );
    LightLeft        := &Add (NameOf (LightLeft       ), Values.LightLeft       );
    LightRight       := &Add (NameOf (LightRight      ), Values.LightRight      );
    LightTop         := &Add (NameOf (LightTop        ), Values.LightTop        );
    Standard         := &Add (NameOf (Standard        ), Values.Standard        );
    StandardInverted := &Add (NameOf (StandardInverted), Values.StandardInverted);

    InitializeList
  End;

(*---------------------------------------------------------------------------------------------*)
(* Constructor. *)

  // <summary>
  //   Initializes a start position value.
  // </summary>
  // <param name="Name">The name.</param>
  // <param name="Value">The value.</param>

  Constructor StartPosition (
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