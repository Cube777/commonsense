object NewUser: TNewUser
  Left = 613
  Top = 291
  BorderStyle = bsNone
  Caption = 'NewUser'
  ClientHeight = 177
  ClientWidth = 321
  Color = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 272
    Height = 24
    Caption = 'Register New User'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 48
    Top = 48
    Width = 52
    Height = 13
    Caption = 'Username:'
  end
  object Label3: TLabel
    Left = 48
    Top = 80
    Width = 50
    Height = 13
    Caption = 'Password:'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 90
    Height = 13
    Caption = 'Confirm password:'
  end
  object edtUsername: TEdit
    Left = 104
    Top = 48
    Width = 193
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 104
    Top = 80
    Width = 169
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtCPassword: TEdit
    Left = 104
    Top = 104
    Width = 169
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object btnRegister: TButton
    Left = 104
    Top = 128
    Width = 203
    Height = 41
    Caption = 'REGISTER FREE ACCOUNT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnRegisterClick
  end
  object btnCancel: TBitBtn
    Left = 8
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = btnCancelClick
    Kind = bkCancel
  end
end
