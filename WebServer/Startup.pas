Namespace WebClient;

(* Startup and server configuration.
   For the Reversi project.

   Author:  OrdinaSoft
            Patrick Lanz
            Lausanne
            info@ordinasoft.ch

   First version: May 25, 2021
*)


Interface


  Uses
    System.Diagnostics,
    System.IO.Compression,

    Microsoft.AspNetCore.Builder,
    Microsoft.AspNetCore.Hosting,
    Microsoft.AspNetCore.ResponseCompression,
    Microsoft.Extensions.DependencyInjection,
    Microsoft.Extensions.Hosting;

(*---------------------------------------------------------------------------------------------*)

  Type

    /// <summary>
    ///   Startup and server configuration.
    /// </summary>

    Startup = Public Class

    Public

    {-- Constructor --}

      /// <summary>
      ///   Initializes an instance of the class.
      /// </summary>
      /// <param name="Environment">The environment.</param>
      Constructor (Environment : IWebHostEnvironment);

    {-- Field --}

      /// <summary>
      ///   The environment.
      /// </summary>
      Environment : IWebHostEnvironment;
        ReadOnly;

    {-- Methods --}

      /// <summary>
      ///   Called by the runtime to configure the services.
      /// </summary>
      /// <param name="Services">The current services.</param>
      Method ConfigureServices (Services : IServiceCollection);

      /// <summary>
      ///   Called by the runtime to configure the HTTP request pipeline.
      /// </summary>
      /// <param name="Application">The application builder.</param>
      Method Configure (Application : IApplicationBuilder);

    End;

(*---------------------------------------------------------------------------------------------*)

Implementation

(*---------------------------------------------------------------------------------------------*)
(* Constructor. *)

  // <summary>
  //   Initializes an instance of the class.
  // </summary>
  // <param name="Environment">The environment.</param>

  Constructor Startup (
    Environment   : IWebHostEnvironment
  );

  Begin
    Self.Environment   := Environment
  End;

(*---------------------------------------------------------------------------------------------*)
(* Configuration. *)

  // <summary>
  //   Called by the runtime to configure the services.
  // </summary>
  // <param name="Services">The current services.</param>

  Method Startup.ConfigureServices (
    Services : IServiceCollection
  );

  Begin

    {-- HSTS --}
    If Environment.IsProduction Then
      Services
        .AddHsts (
          Options ->
          Begin
            Options.IncludeSubDomains := True;
            Options.MaxAge            := TimeSpan.FromDays (365)
          End);

    {-- Response compression --}
    Services.Configure <BrotliCompressionProviderOptions> (
      Options ->
      Begin
        Options.Level := CompressionLevel.Optimal
      End);

    Services.Configure <GzipCompressionProviderOptions> (
      Options ->
      Begin
        Options.Level := CompressionLevel.Optimal
      End);

    Services.AddResponseCompression (
      Options ->
      Begin
        Options.EnableForHttps := True
      End);

    {-- Standard services --}
    Services.AddControllers;
    Services.AddHttpContextAccessor;
    Services.AddRazorPages

  End;



  // <summary>
  //   Called by the runtime to configure the HTTP request pipeline.
  // </summary>
  // <param name="Application">The application builder.</param>

  Method Startup.Configure (
    Application : IApplicationBuilder
  );

  Begin
      
    {-- Configuration --}
    If Environment.IsDevelopment Then
      Application
        .UseDeveloperExceptionPage
        .UseWebAssemblyDebugging
    Else
      Application
        .UseHttpsRedirection
        .UseHsts;

    Application
      .UseResponseCompression
      .UseBlazorFrameworkFiles
      .UseStaticFiles
      .UseRouting
      .UseEndpoints (
        Endpoints ->
        Begin
          Endpoints.MapControllers;
          Endpoints.MapRazorPages
        End);

    {-- Starts the application --}
    Var StartInfo :=
          New ProcessStartInfo ('http://localhost:5000',
                UseShellExecute := True
              );

    Process.Start (StartInfo)

  End;

(*---------------------------------------------------------------------------------------------*)

End.