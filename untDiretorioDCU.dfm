object frmDiretorioDCU: TfrmDiretorioDCU
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Diret'#243'rio DCU'
  ClientHeight = 261
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmPrinc
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxgDiretorioDCU: TcxGrid
    Left = 0
    Top = 0
    Width = 515
    Height = 261
    Align = alClient
    TabOrder = 0
    object cxgDiretorioDCUDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgDiretorioDCUDBTableView1CellDblClick
      DataController.DataSource = dmCadastros.dsDCU
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgDiretorioDCUDBTableView1VERSAO: TcxGridDBColumn
        Caption = 'Vers'#227'o'
        DataBinding.FieldName = 'VERSAO'
      end
      object cxgDiretorioDCUDBTableView1DIRETORIO: TcxGridDBColumn
        Caption = 'Caminho'
        DataBinding.FieldName = 'DIRETORIO'
        Width = 973
      end
    end
    object cxgDiretorioDCULevel1: TcxGridLevel
      GridView = cxgDiretorioDCUDBTableView1
    end
  end
  object mmPrinc: TMainMenu
    Left = 248
    Top = 128
    object Novo1: TMenuItem
      Caption = 'Novo'
      OnClick = Novo1Click
    end
  end
end
