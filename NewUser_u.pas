unit NewUser_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, datModule_u;

type
  TNewUser = class(TForm)
    Label1: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtCPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnRegister: TButton;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewUser: TNewUser;

implementation

{$R *.dfm}

uses Login_u;

procedure TNewUser.btnCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TNewUser.btnRegisterClick(Sender: TObject);
var
flg : boolean;
begin
  //Check if all fields are filled
   flg := true;
   flg := (edtUsername.Text <> '') and flg;
   flg := (edtPassword.Text <> '') and flg;
   flg := (edtCPassword.Text <> '') and flg;
   if not flg then
   begin
    MessageDlg('Please fill in all fields!', mtError, [mbOK], 0);
    exit;
   end;

  //Check if passwords match
  if edtPassword.Text <> edtCPassword.Text then
  begin
    MessageDlg('Passwords do not match!', mtError, [mbOK], 0);
    exit;
  end;

  //Check if username exists
  with datModule do
  begin
    tblUsers.First;
    while not tblUsers.Eof do
    begin
      if tblUsers['Username'] = NewUser.edtUsername.Text then
        Break;
      tblUsers.Next;
    end;

    if not tblUsers.Eof then
    begin
      MessageDlg('Username already in use. Please choose another', mtError, [mbOK], 0);
      edtUsername.SetFocus;
      exit;
    end;
  end;

  datModule.tblUsers.Insert;
  datModule.tblUsers['Username'] := edtUsername.Text;
  datModule.tblUsers['Password'] := edtPassword.Text;
  datModule.tblUsers['Infections'] := '0';
  datModule.tblUsers['HighScore'] := '0';
  datModule.tblUsers.Post;
  ShowMessage(edtUsername.Text + ' successfully registered!');
  self.Close;
end;

procedure TNewUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LoginScreen.Show;
end;

end.
