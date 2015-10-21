unit GameWindow_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls;

type
  TGameWindow = class(TForm)
    tmrLimit: TTimer;
    imgMain: TImage;
    prgbTime: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure tmrLimitTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NextSpam();
  private
    iTotal, iUsed : integer;
  public
    { Public declarations }
  end;

var
  GameWindow: TGameWindow;

implementation

uses Math;

{$R *.dfm}

procedure TGameWindow.FormCreate(Sender: TObject);
begin
  self.Width := Screen.DesktopWidth;
  self.Height := Screen.DesktopHeight;
  self.imgMain.Picture.LoadFromFile('rsc/spam.bmp');
end;

procedure TGameWindow.tmrLimitTimer(Sender: TObject);
begin
  if iUsed <> iTotal then
  begin
    inc(iUsed, 100);
    prgbTime.Position := Floor((iTotal - iUsed) / iTotal * 100);
  end;
end;

procedure TGameWindow.FormShow(Sender: TObject);
begin
  iTotal := 10000;
  iUsed := 0;
  tmrLimit.Enabled := true;
end;

procedure TGameWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MessageDlg('Now now, you can only exit when your''e PC is fully infected ;)',
  mtError, [mbOK], 0);
  Abort;
end;

procedure TGameWindow.NextSpam;
begin
//
end;

end.
