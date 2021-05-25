Namespace Reversi.Model;


(* The values of the board transformations.
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
    ///   The values of the <see cref="BoardTransform">board transformations</see>.
    /// </summary>
    /// <seealso cref="BoardTransform" />

    Values Nested In BoardTransform = Public Static Class

    Public Const

      /// <summary>
      ///   The value of the
      ///   <see cref="BoardTransform.LeftBottomHorizontal">LeftBottomHorizontal</see> board
      ///   transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>1</b>.
      /// </remarks>
      LeftBottomHorizontal = 1;

      /// <summary>
      ///   The value of the
      ///   <see cref="BoardTransform.LeftBottomVertical">LeftBottomVertical</see> board
      ///   transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>2</b>.
      /// </remarks>
      LeftBottomVertical = 2;

      /// <summary>
      ///   The value of the <see cref="BoardTransform.LeftTopHorizontal">LeftTopHorizontal</see>
      ///   board transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>3</b>.
      /// </remarks>
      LeftTopHorizontal = 3;

      /// <summary>
      ///   The value of the <see cref="BoardTransform.LeftTopVertical">LeftTopVertical</see>
      ///   board transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>4</b>.
      /// </remarks>
      LeftTopVertical = 4;

      /// <summary>
      ///   The value of the
      ///   <see cref="BoardTransform.RightBottomHorizontal">RightBottomHorizontal</see> board
      ///   transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>5</b>.
      /// </remarks>
      RightBottomHorizontal = 5;

      /// <summary>
      ///   The value of the
      ///   <see cref="BoardTransform.RightBottomVertical">RightBottomVertical</see> board
      ///   transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>6</b>.
      /// </remarks>
      RightBottomVertical = 6;

      /// <summary>
      ///   The value of the
      ///   <see cref="BoardTransform.RightTopHorizontal">RightTopHorizontal</see> board
      ///   transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>7</b>.
      /// </remarks>
      RightTopHorizontal = 7;

      /// <summary>
      ///   The value of the <see cref="BoardTransform.RightTopVertical">RightTopVertical</see>
      ///   board transformation.
      /// </summary>
      /// <remarks>
      ///   The value is <b>8</b>.
      /// </remarks>
      RightTopVertical = 8;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)

End.