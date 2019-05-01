object frmmain: Tfrmmain
  Left = 299
  Top = 137
  Width = 396
  Height = 165
  Caption = 'WofCompress'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 80
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Compress'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 80
    Width = 75
    Height = 25
    Caption = 'uncompress'
    TabOrder = 1
    OnClick = Button2Click
  end
  object txtfile: TEdit
    Left = 80
    Top = 48
    Width = 289
    Height = 24
    TabOrder = 2
    Text = 'f:\data0.vmdk'
  end
end
