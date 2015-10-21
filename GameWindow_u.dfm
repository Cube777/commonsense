object GameWindow: TGameWindow
  Left = 314
  Top = 129
  BorderStyle = bsNone
  Caption = 'GameWindow'
  ClientHeight = 668
  ClientWidth = 985
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
    985
    668)
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 48
    Top = 8
    Width = 895
    Height = 569
    Anchors = [akLeft, akTop, akRight, akBottom]
    Center = True
    Proportional = True
    Transparent = True
  end
  object lblScore: TLabel
    Left = 48
    Top = 627
    Width = 249
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
  object Label1: TLabel
    Left = 704
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
  object prgbTime: TProgressBar
    Left = 48
    Top = 588
    Width = 895
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
end
