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
    Panel1: TPanel;
    imgSpam: TImage;
    Panel2: TPanel;
    Panel3: TPanel;
    svStats: TSaveDialog;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
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

procedure TMainWindow.Panel1Click(Sender: TObject);
begin
  self.Hide;
  GameWindow.Show;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  self.lblInfected.Caption := datModule.tblUsers['Infections'];
  self.lblHighScore.Caption := datModule.tblUsers['HighScore'];
end;

procedure TMainWindow.Panel2Click(Sender: TObject);
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

procedure TMainWindow.Panel3Click(Sender: TObject);
begin
  MessageDlg('Please stop pressing big buttons. Please', mtError, [mbNo], 0);
end;

end.
