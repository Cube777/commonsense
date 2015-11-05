object MainWindow: TMainWindow
  Left = 697
  Top = 327
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsNone
  Caption = 'MainWindow'
  ClientHeight = 620
  ClientWidth = 1131
  Color = clRed
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1131
    620)
  PixelsPerInch = 96
  TextHeight = 13
  object imgSpam: TImage
    Left = 326
    Top = 104
    Width = 478
    Height = 511
    Anchors = [akLeft, akTop, akRight, akBottom]
    Center = True
    Proportional = True
    Transparent = True
  end
  object Label3: TLabel
    Left = 765
    Top = 585
    Width = 362
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '*DISCLAIMER: This whole program is designed to look like an ad!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 789
    Top = 601
    Width = 337
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 'The content contained can be an ad or an authentic website'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnClose: TBitBtn
    Left = 1104
    Top = 0
    Width = 30
    Height = 25
    Anchors = [akTop, akRight]
    TabOrder = 0
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
  object btnLogout: TButton
    Left = 1032
    Top = 0
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Logout'
    TabOrder = 1
    OnClick = btnLogoutClick
  end
  object grpStats: TGroupBox
    Left = 808
    Top = 128
    Width = 321
    Height = 129
    Anchors = [akTop, akRight]
    Caption = 'Statistics'
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -27
    Font.Name = 'Terminal'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 240
      Height = 24
      Caption = 'Times infected:'
    end
    object Label2: TLabel
      Left = 8
      Top = 80
      Width = 176
      Height = 24
      Caption = 'High score:'
    end
    object lblInfected: TLabel
      Left = 297
      Top = 40
      Width = 16
      Height = 24
      Alignment = taRightJustify
      Caption = '0'
    end
    object lblHighScore: TLabel
      Left = 297
      Top = 80
      Width = 16
      Height = 24
      Alignment = taRightJustify
      Caption = '0'
    end
  end
  object pnlStart: TPanel
    Left = 32
    Top = 124
    Width = 273
    Height = 113
    Anchors = [akLeft]
    Caption = 'START'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = pnlStartClick
  end
  object pnlStats: TPanel
    Left = 32
    Top = 252
    Width = 273
    Height = 113
    Anchors = [akLeft]
    Caption = 'STATS 2 TXT'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = pnlStatsClick
  end
  object pnlFakeExit: TPanel
    Left = 32
    Top = 382
    Width = 273
    Height = 113
    Anchors = [akLeft]
    Caption = 'EXIT'
    Color = clOlive
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = pnlFakeExitClick
  end
  object pnlEasy: TPanel
    Left = 148
    Top = 24
    Width = 275
    Height = 65
    Anchors = [akTop]
    Caption = 'EASY'
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -31
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = pnlEasyClick
  end
  object pnlHard: TPanel
    Left = 708
    Top = 24
    Width = 275
    Height = 65
    Anchors = [akTop]
    Caption = 'HARD'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DLight
    Font.Height = -31
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
    OnClick = pnlHardClick
  end
  object pnlMedium: TPanel
    Left = 428
    Top = 24
    Width = 275
    Height = 65
    Anchors = [akTop]
    Caption = 'MEDIUM'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -31
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = pnlMediumClick
  end
  object svStats: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Choose a filepath to save statistics'
  end
end
