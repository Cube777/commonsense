unit GameWindow_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, datModule_u, JPEG, MMSystem,
  MPlayer;

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
    lblObjective: TLabel;
    pnlBonus: TPanel;
    tmrBonus: TTimer;
    imgBonusClose: TImage;
    Label2: TLabel;
    Label3: TLabel;
    btnBAM: TButton;
    Label4: TLabel;
    pnlVid: TPanel;
    mpSpam: TMediaPlayer;
    imgVidClose: TImage;
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
    procedure imgVidCloseClick(Sender: TObject);
    procedure Reset();
    procedure FormHide(Sender: TObject);
  private
    iTotal, iLeft, iScore, iInfections, iLastInc : integer;
    iShowed : array of integer; //Keeps record numbers of ads not yet shown
    tx, ty, bx, by, iDestroyed : integer; //Answer co-ordinates
    tCorrect : boolean;
    aDestroyers : array of TButton;
  public
    START_TIME : integer;
  end;

var
  GameWindow: TGameWindow;
const
  DESTROY_NUM = 150;

implementation

uses Math, MainWindow_u;

{$R *.dfm}

procedure TGameWindow.FormCreate(Sender: TObject);
var
i : integer;
begin
  //Init screen size
  self.Width := Screen.Width;
  self.Height := Screen.Height;
  self.Left := 0;
  self.Top := 0;

  //Init game-over buttons
  SetLength(aDestroyers, DESTROY_NUM);
  for i := 0 to DESTROY_NUM - 1 do
  begin
    aDestroyers[i] := TButton.Create(self);
    with aDestroyers[i] do
    begin
      Caption := 'INFECTIONS DETECTED';
      Width := 120;
      Parent := GameWindow;
      Visible := false;
    end;
  end;

  //Load ad vid
  self.mpSpam.FileName := 'rsc/spamvid.wmv';
  self.mpSpam.Open;

  //Entropy
  Randomize;
  self.tmrBonus.Interval := random(10000) + 10000;

  self.Reset;
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

    self.tCorrect := false;
    self.imgMain.Hide;
    self.tmrPause.Enabled := true;
    self.tmrFlash.Enabled := true;
    self.tmrLimit.Enabled := false;
  end;
end;

procedure TGameWindow.FormShow(Sender: TObject);
begin;
  self.Reset;
  self.tmrBonus.Enabled := true;
  self.NextImage;
end;

procedure TGameWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MessageDlg('Now now, you can only exit when your''e PC is fully infected ;)', mtError, [mbOK], 0);
  Abort;
end;

procedure TGameWindow.NextImage;
var
i, k, rand : Integer;
ans, temp : string;
ta : array of integer; //Temp array
begin
  self.iLeft := iTotal;
  self.tmrFlash.Enabled := false;
  self.imgResult1.Hide;
  self.imgResult2.Hide;

  //Pick new file
  if length(iShowed) = 0 then
  begin
    MessageDlg('Well done, you have exhausted the ads... You are a true internet warrior!',
    mtInformation, [mbAbort], 0);
    self.GameOver;
    exit;
  end;

  rand := random(length(iShowed));

  datModule.tblSpamDat.First;
  for i := 0 to iShowed[rand] - 1 do
    datModule.tblSpamDat.Next;

  //Remove record from tracking array
  SetLength(ta, length(iShowed) - 1);
  k := 0;
  for i := 0 to length(iShowed) - 1 do
  begin
    if not (i = rand) then
    begin
      ta[k] := iShowed[i];
      inc(k);
    end;
  end;

  SetLength(iShowed, length(ta));
  for i := 0 to length(iShowed) - 1 do
    iShowed[i] := ta[i];

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
    self.lblObjective.Caption := 'Do what you must';
  if temp = 'search-result' then
    self.lblObjective.Caption := 'Choose the correct search result';

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
end;

procedure TGameWindow.rightAnswer;
begin
  //Score changes base on time it took to answer
  inc(self.iScore, Ceil(prgbTime.Position / 100 * 10));
  self.lblScore.Caption := 'Score: ' + IntToStr(self.iScore);
  if (self.iScore - self.iLastInc > 20) then
  begin
    self.iTotal := self.iTotal - 1000;
    self.iLastInc := self.iScore;
  end;

  self.NextImage;
end;

procedure TGameWindow.wrongAnswer;
begin
  inc(iInfections);
  if iInfections = 3 then
  begin
    self.GameOver;
    exit;
  end;

  self.lblInfections.Caption := 'Infections: ' + IntToStr(iInfections) + '/3';
  MessageDlg(datModule.tblSpamDat['Tip'], mtInformation, [mbRetry], 0);
  self.NextImage;
end;

procedure TGameWindow.GameOver;
begin
  sndPlaySound('rsc/why.wav', SND_ASYNC);
  self.imgMain.Picture.LoadFromFile('rsc/game-over.jpg');

  //Disable controls
  self.pnlBonus.Enabled := false;
  self.imgVidClose.Enabled := false;
  self.imgMain.Enabled := false;

  self.tmrLimit.Enabled := false;

  //Fullscreen gameover image
  self.imgMain.Top := 0;
  self.imgMain.Left := 0;
  self.imgMain.Width := self.ClientWidth;
  self.imgMain.Height := self.ClientHeight;
  self.imgMain.Show;

  self.tmrDestroy.Enabled := true;
end;

procedure TGameWindow.tmrDestroyTimer(Sender: TObject);
begin
  if iDestroyed = DESTROY_NUM then
  begin
    datModule.tblUsers.Edit;
    self.tmrDestroy.Enabled := false;
    if iScore > StrToInt(datModule.tblUsers['HighScore']) then
    begin
      MessageDlg('NEW HIGH SCORE!', mtConfirmation, [mbIgnore], 0);
      datModule.tblUsers['HighScore'] := IntToStr(iScore);
    end
    else
      MessageDlg('All you got was a new infection, not a new high score', mtWarning, [mbOK], 0);

    datModule.tblUsers['Infections'] := IntToStr(StrToInt(datModule.tblUsers['Infections']) + 1);
    datModule.tblUsers.Post;
    self.tmrBonus.Enabled := false;
    self.Hide;
    MainWindow.Show;
    exit;
  end;

  with aDestroyers[iDestroyed] do
  begin
    Left := random(GameWindow.ClientWidth - Width);
    Top := random(GameWindow.ClientHeight - Height);
    Visible := true;
  end;
  inc(iDestroyed);
end;

procedure TGameWindow.tmrBonusTimer(Sender: TObject);
begin
  self.tmrBonus.Interval := random(20000) + 10000;
  if pnlBonus.Visible or pnlVid.Visible then
    exit;

  if random(2) = 1 then
  begin
    self.pnlBonus.Left := random(self.ClientWidth - self.pnlBonus.Width);
    self.pnlBonus.Top := random(self.ClientHeight - self.pnlBonus.Height);
    self.pnlBonus.Show;
  end
  else
  begin
    self.pnlVid.Left := random(self.ClientWidth - self.pnlVid.Width);
    self.pnlVid.Top := random(self.ClientHeight - self.pnlVid.Height);
    self.imgVidClose.Top := self.pnlVid.Top - self.imgVidClose.Height;
    self.imgVidClose.Left := self.pnlVid.Left;
    self.imgVidClose.Show;

    self.pnlVid.Show;
    self.imgVidClose.BringToFront;
    self.mpSpam.Play;
  end;
end;

procedure TGameWindow.btnBAMClick(Sender: TObject);
begin
  self.GameOver;
end;

procedure TGameWindow.imgBonusCloseClick(Sender: TObject);
begin
  self.pnlBonus.Hide;
  inc(self.iScore, 5);
  self.lblScore.Caption := 'Score: ' + IntToStr(self.iScore);
  sndPlaySound('rsc/correct.wav', SND_ASYNC);
end;

procedure TGameWindow.imgVidCloseClick(Sender: TObject);
begin
  self.mpSpam.Stop;
  self.pnlVid.Hide;
  self.imgVidClose.Hide;
  self.mpSpam.Rewind;

  inc(self.iScore, 5);
  self.lblScore.Caption := 'Score: ' + IntToStr(self.iScore);
  sndPlaySound('rsc/correct.wav', SND_ASYNC);
end;

procedure TGameWindow.Reset;
var
i : integer;
begin
  //Reset scores
  iScore := 0;
  iLastInc := 0;
  iInfections := 0;
  iTotal := START_TIME;
  iDestroyed := 0;
  self.lblScore.Caption := 'Score: 0';
  self.lblInfections.Caption := 'Infections: 0/3';

  //Re-enable controls
  self.pnlBonus.Enabled := true;
  self.imgVidClose.Enabled := true;
  self.imgMain.Enabled := true;

  //Hide all game-over buttons
  for i := 0 to DESTROY_NUM - 1 do
    aDestroyers[i].Hide;

  //Hide all bonus panels
  pnlVid.Hide;
  pnlBonus.Hide;
  imgVidClose.Hide;

  //Init ads
  SetLength(iShowed, datModule.tblSpamDat.RecordCount);
  for i := 0 to length(iShowed) - 1 do
    iShowed[i] := i;

  self.mpSpam.Rewind;
end;

procedure TGameWindow.FormHide(Sender: TObject);
begin
  self.mpSpam.Stop;
end;

end.
