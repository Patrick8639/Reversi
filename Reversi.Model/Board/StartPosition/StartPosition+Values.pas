Namespace Reversi.Model;


(* The values of the start positions.
   For the Reversi.Model assembly.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: March 14, 2021
*)


Interface


(*---------------------------------------------------------------------------------------------*)

  Type
    StartPosition = Public Partial Sealed Class End;


    /// <summary>
    ///   The values of the <see cref="StartPosition">start positions</see>.
    /// </summary>
    /// <seealso cref="StartPosition" />

    Values Nested In StartPosition = Public Static Class

    Public Const

      /// <summary>
      ///   The value of the <see cref="StartPosition.Empty">Empty</see> start position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>1</b>.
      /// </remarks>
      &Empty = 1;

      /// <summary>
      ///   The value of the <see cref="StartPosition.LightBottom">LightBottom</see> start
      ///   position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>2</b>.
      /// </remarks>
      LightBottom = 2;

      /// <summary>
      ///   The value of the <see cref="StartPosition.LightLeft">LightLeft</see> start position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>3</b>.
      /// </remarks>
      LightLeft = 3;

      /// <summary>
      ///   The value of the <see cref="StartPosition.LightRight">LightRight</see> start
      ///   position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>4</b>.
      /// </remarks>
      LightRight = 4;

      /// <summary>
      ///   The value of the <see cref="StartPosition.LightTop">LightTop</see> start position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>5</b>.
      /// </remarks>
      LightTop = 5;

      /// <summary>
      ///   The value of the <see cref="StartPosition.Standard">Standard</see> start position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>6</b>.
      /// </remarks>
      Standard = 6;

      /// <summary>
      ///   The value of the <see cref="StartPosition.StandardInverted">StandardInverted</see>
      ///   start position.
      /// </summary>
      /// <remarks>
      ///   The value is <b>7</b>.
      /// </remarks>
      StandardInverted = 7;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)

End.