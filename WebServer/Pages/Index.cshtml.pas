namespace WebClient.Pages;

uses
  Microsoft.AspNetCore.Mvc,
  Microsoft.AspNetCore.Mvc.RazorPages,
  Microsoft.Extensions.Logging;

type
  IndexModel = public class(PageModel)
  public
  
    constructor(logger: ILogger<IndexModel>);
    begin
      _logger := logger;
    end;

    method OnGet;
    begin
    end;

  private

    var _logger: ILogger<IndexModel>; private;

  end;

end.
