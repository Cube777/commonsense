object LoginScreen: TLoginScreen
  Left = 584
  Top = 282
  BorderStyle = bsNone
  Caption = 'USE COMMON SENSE'
  ClientHeight = 248
  ClientWidth = 433
  Color = clLime
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object lblUsername: TLabel
    Left = 32
    Top = 48
    Width = 144
    Height = 24
    Caption = 'Username:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
  end
  object lblPassword: TLabel
    Left = 32
    Top = 88
    Width = 144
    Height = 24
    Caption = 'Password:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
  end
  object pnlFakeLogin: TPanel
    Left = 232
    Top = 136
    Width = 185
    Height = 41
    Caption = 'LOGIN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object pnlSpam: TPanel
    Left = 16
    Top = 136
    Width = 185
    Height = 41
    Caption = 'FREE ACCESS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = pnlSpamClick
  end
  object edtUsername: TEdit
    Left = 184
    Top = 48
    Width = 217
    Height = 21
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 184
    Top = 88
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnClose: TBitBtn
    Left = 408
    Top = 0
    Width = 25
    Height = 25
    TabOrder = 4
    OnClick = btnCloseClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphRight
    NumGlyphs = 2
  end
  object pnlFakeClose: TPanel
    Left = 16
    Top = 184
    Width = 185
    Height = 41
    Caption = 'CLOSE'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = pnlFakeCloseClick
  end
  object btnLogin: TButton
    Left = 232
    Top = 184
    Width = 97
    Height = 41
    Caption = 'Real login'
    TabOrder = 6
    OnClick = btnLoginClick
  end
  object btnRegister: TButton
    Left = 328
    Top = 184
    Width = 89
    Height = 41
    Caption = 'Register'
    TabOrder = 7
    OnClick = btnRegisterClick
  end
  object tmColor: TTimer
    Interval = 300
    OnTimer = tmColorTimer
  end
end
