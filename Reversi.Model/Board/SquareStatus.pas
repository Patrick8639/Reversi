Namespace Reversi.Model;


(* The status of a square on the board.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: February 2, 2021
*)


Interface


(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   The status of a square on the board.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///     The <i>Empty</i>, <i>Dark</i> and <i>Light</i> values are used to save a board, so
    ///     they have the smallest values. The <i>Outside</i> and <i>MoveableZone</i> values are
    ///     only use during a game.
    ///   </para>
    ///   <para>
    ///     This enum defines the <i>MoveableZone</i> that is a mark in addition to a normal
    ///     status (here, the <i>Empty</i>.
    ///   </para>
    ///   <para>
    ///     The <i>Outside</i> value is used to simplify the algorithm to calculate the moves:
    ///     the algorithm can stop moving into a direction when one of these square is found.
    ///   </para>
    /// </remarks>

    SquareStatus = Public Enum (

      /// <summary>
      ///   The square is empty.
      /// </summary>
      /// <remarks>
      ///   The value is <b>0</b>.
      /// </remarks>
      &Empty = 0,

      /// <summary>
      ///   The square contains a dark stone.
      /// </summary>
      /// <remarks>
      ///   The value is <b>1</b>.
      /// </remarks>
      Dark = 1,

      /// <summary>
      ///   The square contains a light stone.
      /// </summary>
      /// <remarks>
      ///   The value is <b>2</b>.
      /// </remarks>
      Light = 2,

      /// <summary>
      ///   The square is on the outside of the square.
      /// </summary>
      /// <remarks>
      ///   The value is <b>14</b>.
      /// </remarks>
      Outside = 14,

      /// <summary>
      ///   The square is a moveable zone for the current player.
      /// </summary>
      /// <remarks>
      ///   The value is <b>16</b>.
      /// </remarks>
      MoveableZone = 16,

      /// <summary>
      ///   The mask to have only the content of a square.
      /// </summary>
      ContentMask = $0F,

      /// <summary>
      ///   The mask to have only the marks of a square.
      /// </summary>
      MarkMask = $F0

    ) Of Byte;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)

End.