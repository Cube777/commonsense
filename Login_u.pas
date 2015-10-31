unit Login_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, datModule_u;

type
  TLoginScreen = class(TForm)
    pnlFakeLogin: TPanel;
    tmColor: TTimer;
    pnlSpam: TPanel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnClose: TBitBtn;
    pnlFakeClose: TPanel;
    btnLogin: TButton;
    btnRegister: TButton;
    procedure tmColorTimer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pnlSpamClick(Sender: TObject);
    procedure pnlFakeCloseClick(Sender: TObject);
    procedure virusMessage(str : string);
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    showedWelcome : boolean;
  public
    { Public declarations }
  end;

var
  LoginScreen: TLoginScreen;

implementation

{$R *.dfm}

uses MainWindow_u, NewUser_u, WelcomeScreen_u, DB;

procedure TLoginScreen.tmColorTimer(Sender: TObject);
begin
  pnlFakeLogin.Color := RGB(random(255), random(255), random(255));
  pnlFakeLogin.Font.Color := RGB(random(255), random(255), random(255));
  pnlSpam.Color := RGB(random(255), random(255), random(255));
  pnlSpam.Font.Color := RGB(random(255), random(255), random(255));
end;

procedure TLoginScreen.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TLoginScreen.FormPaint(Sender: TObject);
begin
  if ((datModule.tblUsers.RecordCount = 0) and (not showedWelcome)) then
  begin
    self.Hide;
    WelcomeScreen.ShowModal;
    showedWelcome := true;
    self.Show;
  end;
  edtUsername.Clear;
  edtPassword.Clear;
end;

procedure TLoginScreen.pnlSpamClick(Sender: TObject);
begin
  virusMessage('Ask yourself, why on earth would there be a ' +
  'free access button on an already free program? Even a beginner should ' +
  'know that! NEVER click on a button giving you "free" access to' +
  'a website or something similar, unless you are absolutely certain ' +
  'it is the legitamite button');
end;

procedure TLoginScreen.pnlFakeCloseClick(Sender: TObject);
begin
  virusMessage('WHY DID YOU CLICK ON THE BIG RED BUTTON? ' +
  'Never EVER click the big close button, always look for a ' +
  'small red cross or something similar');
end;

procedure TLoginScreen.virusMessage(str: string);
begin
  //Add more content
  ShowMessage(str);
end;

procedure TLoginScreen.btnLoginClick(Sender: TObject);
var
temp : string;
begin
  if edtUsername.Text = '' then
    exit;
  if edtPassword.Text = '' then
    exit;
  
  with datModule do
  begin
    //Search through all users for username
    tblUsers.First;
    while not tblUsers.Eof do
    begin
      if tblUsers['Username'] = LoginScreen.edtUsername.Text then
        Break;
      tblUsers.Next;
    end;
    if tblUsers.Eof then
    begin
      MessageDlg('User does not exist, please register', mtError, [mbOK], 0);
      exit;
    end;

    //Check if password is correct
    temp := tblUsers['Password'];

    if temp <> LoginScreen.edtPassword.Text then
    begin
      MessageDlg('Password incorrect, please try again', mtError, [mbOK], 0);
      LoginScreen.edtPassword.Clear;
      LoginScreen.edtPassword.SetFocus;
      exit;
    end;

    //Open main window
    self.Hide;
    MainWindow.Show;
  end;

end;

procedure TLoginScreen.btnRegisterClick(Sender: TObject);
begin
  self.Hide;
  NewUser.ShowModal;
  self.Show;
end;

procedure TLoginScreen.FormCreate(Sender: TObject);
begin
  showedWelcome := false;
end;

end.
