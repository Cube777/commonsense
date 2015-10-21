program CommonSense;

uses
  Forms,
  Login_u in 'Login_u.pas' {LoginScreen},
  WelcomeScreen_u in 'WelcomeScreen_u.pas' {WelcomeScreen},
  datModule_u in 'datModule_u.pas' {datModule: TDataModule},
  NewUser_u in 'NewUser_u.pas' {NewUser},
  MainWindow_u in 'MainWindow_u.pas' {MainWindow},
  GameWindow_u in 'GameWindow_u.pas' {GameWindow};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoginScreen, LoginScreen);
  Application.CreateForm(TWelcomeScreen, WelcomeScreen);
  Application.CreateForm(TdatModule, datModule);
  Application.CreateForm(TNewUser, NewUser);
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TGameWindow, GameWindow);
  Application.Run;
end.
