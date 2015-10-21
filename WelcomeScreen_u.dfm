object WelcomeScreen: TWelcomeScreen
  Left = 665
  Top = 226
  BorderStyle = bsNone
  Caption = 'WelcomeScreen'
  ClientHeight = 414
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblWelcome: TLabel
    Left = 120
    Top = 24
    Width = 200
    Height = 67
    Caption = 'Welcome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object RichEdit1: TRichEdit
    Left = 24
    Top = 104
    Width = 393
    Height = 233
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    Lines.Strings = (
      
        'Welcome to Common Sense(R), the software that will help you dist' +
        'inguish'
      
        'between the good and bad on the WWW. This software is filled wit' +
        'h funny'
      
        'fonts, bad GUI'#39's and horrible flashing images - just like the we' +
        'b we use'
      
        'everyday, yet still people struggle to not infect their PC'#39's wit' +
        'h spamware.'
      ''
      
        'This program will not have any tutorial - you'#39're on your own to ' +
        'defend your'
      
        'PC from horrible sickness and disease, and if you fail - you wil' +
        'l see :)'
      ''
      
        'All I can say is this - pay attention to detail, think fast and ' +
        'most of all'
      'USE YOUR COMMON SENSE! And ALWAYS be ready, the ads never ever'
      'stop... good luck, and may the ads be ever in your favor')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 360
    Width = 393
    Height = 41
    Caption = 'Ask yourself, will this button do wat you want it to do?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
end
