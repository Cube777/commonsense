unit GameWindow_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, datModule_u, JPEG, MMSystem;

type
  TGameWindow = class(TForm)
    tmrLimit: TTimer;
    imgMain: TImage;
    prgbTime: TProgressBar;
    lblScore: TLabel;
    lblInfections: TLabel;
    imgResult1: TImage;
    imgResult2: TImage;
    tmrFlash: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrLimitTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NextImage();
    //Returns true for correct answer, false for incorrect
    function CheckAnswer(x, y : integer) : boolean;
    procedure imgMainClick(Sender: TObject);
    procedure imgMainDblClick(Sender: TObject);
    procedure tmrFlashTimer(Sender: TObject);
  private
    iTotal, iLeft, iScore : integer;
    tx, ty, bx, by : integer; //Answer co-ordinates
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
end;

procedure TGameWindow.tmrLimitTimer(Sender: TObject);
begin
  if iLeft <> 0 then
  begin
    iLeft := iLeft - 100;
    self.prgbTime.Position := floor(iLeft / iTotal * 100);
  end;
end;

procedure TGameWindow.FormShow(Sender: TObject);
begin;
  iTotal := 10000;
  iLeft := iTotal;
  self.NextImage;
  //self.imgMain.Picture.LoadFromFile('rsc/spam.bmp');

end;

procedure TGameWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MessageDlg('Now now, you can only exit when your''e PC is fully infected ;)',
  mtError, [mbOK], 0);
  Abort;
end;

procedure TGameWindow.NextImage;
var
recNum, i, rand : Integer;
ans, temp : string;
begin
  Randomize;
  self.tmrLimit.Enabled := false;
  self.tmrFlash.Enabled := false;
  self.imgResult1.Hide;
  self.imgResult2.Hide;

  //Pick new file
  recNum := datModule.tblSpamDat.RecordCount;

  if recNum = 0 then
  begin
    MessageDlg('No spam data found, please make sure spam-data database is readable and populated',
    mtError, [mbAbort], 0);
    Application.Terminate;
  end;

  rand := random(recNum);

  datModule.tblSpamDat.First;
  for i := 1 to rand do
    datModule.tblSpamDat.Next;

  //Load image
  self.imgMain.Picture.LoadFromFile('rsc/' + datModule.tblSpamDat['Filename']);

  //Center image and set up co-ordinates
  self.imgMain.Width := self.imgMain.Picture.Width;
  self.imgMain.Height := self.imgMain.Picture.Height;
  self.imgMain.Left := (self.ClientWidth - self.imgMain.Width) div 2;
  self.imgMain.Top := (Self.ClientHeight - 100 - self.imgMain.Height) div 2;

  //Set up answer co-ordinates
  ans := datModule.tblSpamDat['Answer'];

  //Top x
  temp := copy(ans, 1, pos(';', ans) - 1);
  tx := StrToInt(temp);
  delete(ans, 1, pos(';', ans));

  //Top y
  temp := copy(ans, 1, pos(';', ans) - 1);
  ty := StrToInt(temp);
  delete(ans, 1, pos(';', ans));

  //Bottom x
  temp := copy(ans, 1, pos(';', ans) - 1);
  bx := StrToInt(temp);
  delete(ans, 1, pos(';', ans));

  //Bottom y
  by := StrToInt(ans);

  //Re-enable timer
  self.tmrLimit.Enabled := true;
end;

procedure TGameWindow.imgMainClick(Sender: TObject);
var
flg : boolean;
begin
  flg := CheckAnswer(Mouse.CursorPos.X - self.imgMain.Left,
  Mouse.CursorPos.Y - self.imgMain.Top);

  //flg will be true if answer is correct and false if answer is incorrect

  if flg then
  begin
    self.imgResult1.Picture.LoadFromFile('rsc/checkmark.bmp');
    self.imgResult2.Picture.LoadFromFile('rsc/checkmark.bmp');
    sndPlaySound('rsc/tada.wav', SND_ASYNC);

  end
  else
  begin
    self.imgResult1.Picture.LoadFromFile('rsc/wrong-cross.jpg');
    self.imgResult2.Picture.LoadFromFile('rsc/wrong-cross.jpg');
  end;

  self.tmrFlash.Enabled := true;
end;

function TGameWindow.CheckAnswer(x, y: integer): boolean;
begin
  result := false;

  if not ( (x >= tx) and (x <= bx) ) then
    exit;

  if not ( (y >= ty) and (y <= by) ) then
    exit;

  result := true;
end;

procedure TGameWindow.imgMainDblClick(Sender: TObject);
begin
  self.NextImage;
end;

procedure TGameWindow.tmrFlashTimer(Sender: TObject);
begin
  imgResult1.Visible := not imgResult1.Visible;
  imgResult2.Visible := not imgResult2.Visible;
end;

end.
