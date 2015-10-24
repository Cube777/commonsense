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
    tmrPause: TTimer;
    tmrDestroy: TTimer;
    Label1: TLabel;
    lblObjective: TLabel;
    pnlBonus: TPanel;
    tmrBonus: TTimer;
    imgBonusClose: TImage;
    Label2: TLabel;
    Label3: TLabel;
    btnBAM: TButton;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmrLimitTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NextImage();
    //Returns true for correct answer, false for incorrect
    function CheckAnswer(x, y : integer) : boolean;
    procedure imgMainClick(Sender: TObject);
    procedure tmrFlashTimer(Sender: TObject);
    procedure tmrPauseTimer(Sender: TObject);
    procedure rightAnswer();
    procedure wrongAnswer();
    procedure GameOver();
    procedure tmrDestroyTimer(Sender: TObject);
    procedure tmrBonusTimer(Sender: TObject);
    procedure btnBAMClick(Sender: TObject);
    procedure imgBonusCloseClick(Sender: TObject);
  private
    iTotal, iLeft, iScore, iInfections : integer;
    tx, ty, bx, by, iDestroyed : integer; //Answer co-ordinates
    tCorrect, bgameOver : boolean;
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
  self.Width := Screen.Width;
  self.Height := Screen.Height;
  self.Left := 0;
  self.Top := 0;
  self.tmrBonus.Interval := random(10000) + 10000;
  //self.pnlBonus.Width := floor(self.Width / 5);
  //self.pnlBonus.Height := floor(self.Height / 7);
  //self.imgBonusClose.Width := floor(self.pnlBonus.Width / 13);
  //self.imgBonusClose.Height := floor(self.pnlBonus.Height / 9);
end;

procedure TGameWindow.tmrLimitTimer(Sender: TObject);
begin
  if iLeft <> 0 then
  begin
    iLeft := iLeft - 100;
    self.prgbTime.Position := floor(iLeft / iTotal * 100)
  end
  else
  begin
    self.imgResult1.Picture.LoadFromFile('rsc/wrong-cross.jpg');
    self.imgResult2.Picture.LoadFromFile('rsc/wrong-cross.jpg');
    sndPlaySound('rsc/wth.wav', SND_ASYNC);

    self.tmrPause.Enabled := true;
    self.tmrFlash.Enabled := true;
    self.tmrLimit.Enabled := false;
  end;
end;

procedure TGameWindow.FormShow(Sender: TObject);
begin;
  self.bgameOver := false;
  iTotal := 10000;
  iInfections := 0;
  iScore := 0;
  Randomize;
  self.NextImage;
end;

procedure TGameWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if self.bgameOver then
    exit;

  MessageDlg('Now now, you can only exit when your''e PC is fully infected ;)', mtError, [mbOK], 0);
  Abort;
end;

procedure TGameWindow.NextImage;
var
recNum, i, rand : Integer;
ans, temp : string;
begin
  if self.bgameOver then
    exit;

  self.iLeft := iTotal;
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
  self.imgMain.Show;

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

  //Set up objective text
  temp := datModule.tblSpamDat['Type'];

  if temp = 'download' then
    self.lblObjective.Caption := 'Find the correct download button';
  if temp = 'close-button' then
    self.lblObjective.Caption := 'Find the correct close button';
  if temp = 'spammy-or-not' then
    self.lblObjective.Caption := 'Should you trust this website?';
  if temp = 'auth-url' then
    self.lblObjective.Caption := 'Choose the authentic URL';
  if temp = 'no-hint' then
    self.lblObjective.Caption := 'Do what you think is acceptable';

  //Re-enable timer
  self.tmrLimit.Enabled := true;
end;

procedure TGameWindow.imgMainClick(Sender: TObject);
var
flg : boolean;
begin
  flg := CheckAnswer(Mouse.CursorPos.X - self.imgMain.Left,
  Mouse.CursorPos.Y - self.imgMain.Top);
  self.tCorrect := flg;
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
    sndPlaySound('rsc/wth.wav', SND_ASYNC);
  end;
  self.imgMain.Hide;

  self.tmrPause.Enabled := true;
  self.tmrFlash.Enabled := true;
  self.tmrLimit.Enabled := false;
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

procedure TGameWindow.tmrFlashTimer(Sender: TObject);
begin
  imgResult1.Visible := not imgResult1.Visible;
  imgResult2.Visible := not imgResult2.Visible;
end;

procedure TGameWindow.tmrPauseTimer(Sender: TObject);
begin
  self.tmrPause.Enabled := false;
  if self.tCorrect then
    self.rightAnswer
  else
    self.wrongAnswer;

  self.NextImage;
end;

procedure TGameWindow.rightAnswer;
begin
  inc(self.iScore);
  self.lblScore.Caption := 'Score: ' + IntToStr(self.iScore);
  if (self.iScore mod 5 = 0) then
    self.iTotal := self.iTotal - 1000;
end;

procedure TGameWindow.wrongAnswer;
begin
  inc(iInfections);
  if iInfections = 3 then
  begin
    self.bgameOver := true;
    self.GameOver;
    exit;
  end
  else
    self.lblInfections.Caption := 'Infections: ' + IntToStr(iInfections) + '/3';

  MessageDlg(datModule.tblSpamDat['Tip'], mtInformation, [mbRetry], 0);
end;

procedure TGameWindow.GameOver;
begin
  sndPlaySound('rsc/why.wav', SND_ASYNC);
  self.pnlBonus.Enabled := false;
  self.imgMain.Top := 0;
  self.imgMain.Left := 0;
  self.imgMain.Width := self.ClientWidth;
  self.imgMain.Height := self.ClientHeight;
  self.imgMain.Picture.LoadFromFile('rsc/game-over.jpg');
  self.imgMain.Enabled := false;
  self.imgMain.Show;
  self.tmrDestroy.Enabled := true;
  iDestroyed := 0;
end;

procedure TGameWindow.tmrDestroyTimer(Sender: TObject);
var
spawn : TButton;
begin
  if iDestroyed = 150 then
  begin
    datModule.tblUsers.Edit;
    self.tmrDestroy.Enabled := false;
    if iScore > StrToInt(datModule.tblUsers['HighScore']) then
    begin
      MessageDlg('NEW HIGH SCORE!', mtConfirmation, [mbIgnore], 0);
      datModule.tblUsers['HighScore'] := IntToStr(iScore);
    end
    else
      MessageDlg('All you got was a new infection.', mtWarning, [mbOK], 0);

    datModule.tblUsers['Infections'] := IntToStr(StrToInt(datModule.tblUsers['Infections']) + 1);
    datModule.tblUsers.Post;
    self.Close;
  end;

  spawn := TButton.Create(self);
  spawn.Left := random(self.ClientWidth - spawn.Width);
  spawn.Top := random(self.ClientHeight - spawn.Height);
  spawn.Width := 120;
  spawn.Caption := 'INFECTION DETECTED';
  spawn.Parent := self;
  spawn.Visible := true;
  inc(iDestroyed);
end;

procedure TGameWindow.tmrBonusTimer(Sender: TObject);
begin
  self.tmrBonus.Interval := random(10000) + 10000;
  self.pnlBonus.Left := random(self.ClientWidth - self.pnlBonus.Width);
  self.pnlBonus.Top := random(self.ClientHeight - self.pnlBonus.Height);
  //self.imgBonusClose.Top := random(self.pnlBonus.Height - self.imgBonusClose.Height);
  //self.imgBonusClose.Left := random(self.pnlBonus.Width - self.imgBonusClose.Width);
  self.pnlBonus.Show;
end;

procedure TGameWindow.btnBAMClick(Sender: TObject);
begin
  self.tmrLimit.Enabled := false;
  self.bgameOver := true;
  self.GameOver;
end;

procedure TGameWindow.imgBonusCloseClick(Sender: TObject);
begin
  self.pnlBonus.Hide;
  inc(self.iScore, 5);
  self.lblScore.Caption := 'Score: ' + IntToStr(self.iScore);
  sndPlaySound('rsc/correct.wav', SND_ASYNC);
end;

end.
