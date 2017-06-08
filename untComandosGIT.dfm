object frmComandosGIT: TfrmComandosGIT
  Left = 0
  Top = 0
  Caption = 'Comandos GIT'
  ClientHeight = 308
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxgComandos: TcxGrid
    Left = 0
    Top = 152
    Width = 505
    Height = 156
    Align = alBottom
    TabOrder = 0
    object cxgComandosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
      OnCellDblClick = cxgComandosDBTableView1CellDblClick
      DataController.DataSource = dmCadastros.dsComGit
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
      OptionsView.GroupByBox = False
      object cxgComandosDBTableView1SEQ: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'SEQ'
        Width = 50
      end
      object cxgComandosDBTableView1FUNCAO: TcxGridDBColumn
        Caption = 'Fun'#231#227'o'
        DataBinding.FieldName = 'FUNCAO'
        Width = 150
      end
      object cxgComandosDBTableView1COMANDO: TcxGridDBColumn
        DataBinding.FieldName = 'COMANDO'
        Width = 500
      end
      object cxgComandosDBTableView1Opcao: TcxGridDBColumn
        Caption = 'Op'#231#227'o'
        DataBinding.FieldName = 'OPCAO'
      end
    end
    object cxgComandosLevel1: TcxGridLevel
      GridView = cxgComandosDBTableView1
    end
  end
  object pnlCentral: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 152
    Align = alClient
    TabOrder = 1
    object lblFuncao: TLabel
      Left = 24
      Top = 11
      Width = 35
      Height = 13
      Caption = 'Fun'#231#227'o'
    end
    object lblComando: TLabel
      Left = 24
      Top = 55
      Width = 45
      Height = 13
      Caption = 'Comando'
    end
    object lblSeq: TLabel
      Left = 264
      Top = 10
      Width = 49
      Height = 13
      Caption = 'Sequencia'
    end
    object lblOpcao: TLabel
      Left = 24
      Top = 100
      Width = 31
      Height = 13
      Caption = 'Opcao'
    end
    object edtFuncao: TEdit
      Left = 24
      Top = 29
      Width = 193
      Height = 21
      TabOrder = 0
    end
    object edtComando: TEdit
      Left = 24
      Top = 75
      Width = 465
      Height = 21
      TabOrder = 2
    end
    object btnEvento: TButton
      Left = 368
      Top = 13
      Width = 121
      Height = 25
      Caption = 'Novo'
      TabOrder = 4
      OnClick = btnEventoClick
    end
    object btnCancelar: TButton
      Left = 368
      Top = 44
      Width = 121
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = btnCancelarClick
    end
    object edtSeq: TEdit
      Left = 264
      Top = 29
      Width = 73
      Height = 21
      TabOrder = 1
    end
    object edtOpco: TEdit
      Left = 24
      Top = 117
      Width = 465
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
  end
end
