object frmComentario: TfrmComentario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Commit Coment'#225'rio'
  ClientHeight = 241
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnCommit: TButton
    Left = 0
    Top = 202
    Width = 515
    Height = 39
    Align = alBottom
    Caption = 'Commit'
    TabOrder = 0
    OnClick = btnCommitClick
  end
  object mmoTexto: TMemo
    Left = 0
    Top = 0
    Width = 515
    Height = 202
    Align = alClient
    TabOrder = 1
  end
end
