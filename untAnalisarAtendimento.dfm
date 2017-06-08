object frmAnalisarRotina: TfrmAnalisarRotina
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Analisar Rotina'
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
  object cxgAnalisarRotina: TcxGrid
    Left = 0
    Top = 0
    Width = 515
    Height = 241
    Align = alClient
    TabOrder = 0
    object cxgAnalisarRotinaDBTableView1: TcxGridDBTableView
      PopupMenu = pmAtualizarRotina
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dmCadastros.dsRotina
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsSelection.InvertSelect = False
      object cxgAnalisarRotinaDBTableView1ROTINA: TcxGridDBColumn
        Caption = 'Rotina'
        DataBinding.FieldName = 'ROTINA'
        Width = 500
      end
      object cxgAnalisarRotinaDBTableView1Modulo: TcxGridDBColumn
        Caption = 'Modulo'
        DataBinding.FieldName = 'MODULO'
        Visible = False
        GroupIndex = 0
      end
    end
    object cxgAnalisarRotinaLevel1: TcxGridLevel
      GridView = cxgAnalisarRotinaDBTableView1
    end
  end
  object pmAtualizarRotina: TPopupMenu
    Left = 144
    Top = 88
    object Analisar1: TMenuItem
      Caption = 'Analisar'
      OnClick = Analisar1Click
    end
  end
end
