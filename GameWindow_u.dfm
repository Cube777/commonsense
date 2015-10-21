object GameWindow: TGameWindow
  Left = 344
  Top = 87
  BorderStyle = bsNone
  Caption = 'GameWindow'
  ClientHeight = 641
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
    641)
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 48
    Top = 8
    Width = 895
    Height = 577
    Anchors = [akLeft, akTop, akRight, akBottom]
    Center = True
    Proportional = True
    Transparent = True
  end
  object prgbTime: TProgressBar
    Left = 48
    Top = 601
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
