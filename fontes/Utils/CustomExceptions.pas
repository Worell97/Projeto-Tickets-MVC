unit CustomExceptions;

interface

uses System.SysUtils;

type
  TDuplicatedCpfException = class (Exception);
  TInvalidCpfException = class (Exception);
  TConnectionException = class (Exception);
implementation

end.
