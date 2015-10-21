object datModule: TdatModule
  OldCreateOrder = False
  Left = 601
  Top = 248
  Height = 263
  Width = 341
  object ADOspamData: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=spam-data.mdb;Mode=' +
      'Share Deny None;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 264
    Top = 8
  end
  object tblUsers: TADOTable
    Active = True
    Connection = ADOusers
    CursorType = ctStatic
    TableName = 'Users'
    Left = 32
    Top = 64
  end
  object tblSpamDat: TADOTable
    Active = True
    Connection = ADOspamData
    CursorType = ctStatic
    TableName = 'SpamData'
    Left = 264
    Top = 64
  end
  object ADOusers: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=users' +
      '.mdb;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB:' +
      'System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database' +
      ' Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking ' +
      'Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk' +
      ' Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cre' +
      'ate System Database=False;Jet OLEDB:Encrypt Database=False;Jet O' +
      'LEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Withou' +
      't Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 8
  end
end
