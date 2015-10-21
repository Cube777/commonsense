unit datModule_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdatModule = class(TDataModule)
    ADOspamData: TADOConnection;
    tblUsers: TADOTable;
    tblSpamDat: TADOTable;
    ADOusers: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  datModule: TdatModule;

implementation

{$R *.dfm}

end.
