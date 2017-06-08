object frmRotina: TfrmRotina
  Left = 0
  Top = 0
  Caption = 'Rotinas'
  ClientHeight = 389
  ClientWidth = 441
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
  object cxgRotina: TcxGrid
    Left = 0
    Top = 100
    Width = 441
    Height = 289
    Align = alBottom
    TabOrder = 0
    object cxgRotinaDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
      OnCellDblClick = cxgRotinaDBTableView1CellDblClick
      DataController.DataSource = dmCadastros.dsRotina
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsSelection.InvertSelect = False
      object cxgRotinaDBTableView1ROTINA: TcxGridDBColumn
        Caption = 'Rotina'
        DataBinding.FieldName = 'ROTINA'
        Width = 150
      end
      object cxgRotinaDBTableView1LINK: TcxGridDBColumn
        Caption = 'Link'
        DataBinding.FieldName = 'LINK'
        Width = 300
      end
      object cxgRotinaDBTableView1Modulo: TcxGridDBColumn
        Caption = 'Modulo'
        DataBinding.FieldName = 'MODULO'
        Visible = False
        GroupIndex = 0
      end
    end
    object cxgRotinaLevel1: TcxGridLevel
      GridView = cxgRotinaDBTableView1
    end
  end
  object pnlCentral: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 100
    Align = alClient
    TabOrder = 1
    object lblRotina: TLabel
      Left = 16
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Rotina'
    end
    object lblLink: TLabel
      Left = 16
      Top = 54
      Width = 18
      Height = 13
      Caption = 'Link'
    end
    object edtRotina: TEdit
      Left = 16
      Top = 27
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object edtLink: TEdit
      Left = 16
      Top = 73
      Width = 409
      Height = 21
      TabOrder = 1
    end
    object btnEvento: TButton
      Left = 344
      Top = 25
      Width = 81
      Height = 25
      Caption = 'Nova'
      TabOrder = 2
      OnClick = btnEventoClick
    end
    object btnCancelar: TButton
      Left = 257
      Top = 25
      Width = 81
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
end
