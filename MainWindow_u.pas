unit MainWindow_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, datModule_u;

type
  TMainWindow = class(TForm)
    btnClose: TBitBtn;
    btnLogout: TButton;
    grpStats: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblInfected: TLabel;
    lblHighScore: TLabel;
    pnlStart: TPanel;
    imgSpam: TImage;
    pnlStats: TPanel;
    pnlFakeExit: TPanel;
    svStats: TSaveDialog;
    Label3: TLabel;
    Label4: TLabel;
    pnlEasy: TPanel;
    pnlHard: TPanel;
    pnlMedium: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure pnlStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlStatsClick(Sender: TObject);
    procedure pnlFakeExitClick(Sender: TObject);
    procedure pnlEasyClick(Sender: TObject);
    procedure pnlMediumClick(Sender: TObject);
    procedure pnlHardClick(Sender: TObject);
  private
    { Private declarations }
  public
    loggedOut : boolean;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

uses GameWindow_u, Login_u;

procedure TMainWindow.FormCreate(Sender: TObject);
begin
  self.Width := Screen.Width;
  self.Height := Screen.Height;
  self.imgSpam.Picture.LoadFromFile('rsc\spam.bmp');
end;

procedure TMainWindow.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainWindow.btnLogoutClick(Sender: TObject);
begin
  self.Hide;
  LoginScreen.Show;
end;

procedure TMainWindow.pnlStartClick(Sender: TObject);
begin
  self.pnlEasy.Show;
  self.pnlMedium.Show;
  self.pnlHard.Show;

  self.pnlStart.Hide;
  self.pnlStats.Hide;
  self.pnlFakeExit.Hide;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  self.lblInfected.Caption := datModule.tblUsers['Infections'];
  self.lblHighScore.Caption := datModule.tblUsers['HighScore'];
  self.pnlEasy.Hide;
  self.pnlMedium.Hide;
  self.pnlHard.Hide;
end;

procedure TMainWindow.pnlStatsClick(Sender: TObject);
var
tfile : TextFile;
begin
  svStats.FileName := datModule.tblUsers['Username'] + ' - stats.txt';
  svStats.Execute;
  AssignFile(tfile, svStats.FileName);
  Rewrite(tfile);

  Writeln(tfile, 'Username: ' + datModule.tblUsers['Username']);
  Writeln(tfile, 'How to get rich fast and easy - goto www.scam.com');
  Writeln(tfile, 'High score: ' + floattostr(datModule.tblUsers['HighScore']));
  Writeln(tfile, 'Russian brides in your area - click here to meet them');
  Writeln(tfile, 'Time infected with ads and the like: ' + floattostr(datModule.tblUsers['Infections']));
  if datModule.tblUsers['Infections'] > 20 then
    Writeln(tfile, 'Sufficient training - This person will survive on the Internet')
  else
    Writeln(tfile, 'Insufficient training - This person will probably get a virus');

  CloseFile(tfile);

  MessageDlg('User statistics exported to ''' + svStats.FileName + '''', mtInformation, [mbOK], 0);
end;

procedure TMainWindow.pnlFakeExitClick(Sender: TObject);
begin
  MessageDlg('Please stop pressing big buttons. Please', mtError, [mbNo], 0);
end;

procedure TMainWindow.pnlEasyClick(Sender: TObject);
begin
  GameWindow.START_TIME := 30000;
  self.Hide;
  GameWindow.Show;
end;

procedure TMainWindow.pnlMediumClick(Sender: TObject);
begin
  GameWindow.START_TIME := 20000;
  self.Hide;
  GameWindow.Show;
end;

procedure TMainWindow.pnlHardClick(Sender: TObject);
begin
  GameWindow.START_TIME := 10000;
  self.Hide;
  GameWindow.Show;
end;

end.
