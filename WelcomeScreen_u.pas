unit WelcomeScreen_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TWelcomeScreen = class(TForm)
    lblWelcome: TLabel;
    RichEdit1: TRichEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WelcomeScreen: TWelcomeScreen;

implementation

{$R *.dfm}

procedure TWelcomeScreen.Button1Click(Sender: TObject);
begin
  self.Close;
end;

end.
