Namespace WebClient;

(* The web application.
   For the Reversi project.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: May 25, 2021
*)


Interface


  Uses
    System.Reflection,

    Microsoft.Extensions.Hosting,

    OrdinaSoft;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   The application.
    /// </summary>

    Program = Public Class


    Public

    {-- Constructor --}

      /// <summary>
      ///   Initializes an instance of the application.
      /// </summary>
      Constructor;
        Empty;

    {-- Methods --}

      /// <summary>
      ///   Program entry point.
      /// </summary>
      /// <param name="Args">The command-line arguments.</param>
      Class Method Main (Args : Array Of String);

      /// <summary>
      ///   Creates the host builder.
      /// </summary>
      /// <param name="Args">The command-line arguments.</param>
      /// <returns>The host builder.</returns>
      Class Method CreateHostBuilder (Args : Array Of String) : IHostBuilder;

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Program initialization. *)

  // <summary>
  //   Program entry point.
  // </summary>
  // <param name="Args">The command-line arguments.</param>
  // <returns>The task.</returns>

  Class Method Program.Main (
    Args : Array Of String
  );

  Begin

    {-- Text resources --}
    Var TextResources := TextResourcesDict.TextResources;

    TextResources
      .AddSource (&Assembly.Load ('OrdinaSoft.Base'), 'TextResources')
      .AddSource (&Assembly.Load ('Reversi.Model'  ), 'TextResources');

    TextResources.UserLanguageCode := 'en';

    {-- Starts the web service --}
    CreateHostBuilder (Args)
      .Build
      .Run

  End;



  // <summary>
  //   Creates the host builder.
  // </summary>
  // <param name="Args">The command-line arguments.</param>
  // <returns>The host builder.</returns>

  Class Method Program.CreateHostBuilder (
    Args : Array Of String
  ) : IHostBuilder;

  Begin
    Result :=
      Host
        .CreateDefaultBuilder     (Args)
        .ConfigureWebHostDefaults (WebBuilder -> WebBuilder.UseStartup <Startup>)
  End;

(*---------------------------------------------------------------------------------------------*)

End.