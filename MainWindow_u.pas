unit MainWindow_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TMainWindow = class(TForm)
    btnClose: TBitBtn;
    btnLogout: TButton;
    grpStats: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblInfected: TLabel;
    lblRecord: TLabel;
    Panel1: TPanel;
    imgSpam: TImage;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    loggedOut : boolean;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

uses GameWindow_u;

procedure TMainWindow.FormCreate(Sender: TObject);
begin
  self.loggedOut := false;
  self.Width := Screen.DesktopWidth;
  self.Height := Screen.DesktopHeight;
  self.imgSpam.Picture.LoadFromFile('rsc\spam.bmp');
end;

procedure TMainWindow.btnCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TMainWindow.btnLogoutClick(Sender: TObject);
begin
  self.loggedOut := true;
  self.Close;
end;

procedure TMainWindow.Panel1Click(Sender: TObject);
begin
  self.Hide;
  GameWindow.ShowModal;
  self.Show;
end;

end.
