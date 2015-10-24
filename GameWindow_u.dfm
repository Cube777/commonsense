object GameWindow: TGameWindow
  Left = 377
  Top = 118
  Cursor = crHourGlass
  BorderStyle = bsNone
  Caption = 'GameWindow'
  ClientHeight = 668
  ClientWidth = 979
  Color = clInactiveCaptionText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    979
    668)
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 272
    Top = 120
    Width = 443
    Height = 337
    Anchors = [akLeft, akTop, akRight, akBottom]
    Center = True
    Transparent = True
    OnClick = imgMainClick
    OnDblClick = imgMainDblClick
  end
  object lblScore: TLabel
    Left = 48
    Top = 627
    Width = 128
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = 'Score: 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -29
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
  end
  object lblInfections: TLabel
    Left = 698
    Top = 627
    Width = 240
    Height = 24
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Infections: 0/3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
  end
  object imgResult1: TImage
    Left = 40
    Top = 224
    Width = 169
    Height = 169
    Anchors = [akLeft]
    Center = True
    Proportional = True
    Transparent = True
  end
  object imgResult2: TImage
    Left = 770
    Top = 224
    Width = 169
    Height = 169
    Anchors = [akRight]
    Center = True
    Proportional = True
    Transparent = True
  end
  object prgbTime: TProgressBar
    Left = 48
    Top = 588
    Width = 889
    Height = 24
    Anchors = [akLeft, akRight, akBottom]
    Position = 100
    TabOrder = 0
  end
  object tmrLimit: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrLimitTimer
  end
  object tmrFlash: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrFlashTimer
    Left = 32
  end
end
