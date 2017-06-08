object frmNovoAtendimento: TfrmNovoAtendimento
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Novo Atendimento'
  ClientHeight = 428
  ClientWidth = 388
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 388
    Height = 428
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 358
    object lblWt: TLabel
      Left = 24
      Top = 8
      Width = 71
      Height = 13
      Caption = 'Numero da WT'
    end
    object lbNameBranche: TLabel
      Left = 24
      Top = 54
      Width = 69
      Height = 13
      Caption = 'Nome branche'
    end
    object edtWT: TEdit
      Left = 24
      Top = 27
      Width = 353
      Height = 21
      TabOrder = 0
    end
    object edtNomeBranche: TEdit
      Left = 24
      Top = 73
      Width = 353
      Height = 21
      TabOrder = 1
    end
    object rgOpcoes: TRadioGroup
      Left = 24
      Top = 100
      Width = 353
      Height = 45
      Caption = 'Cria'#231#227'o de pastas:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Comum'
        'Nova')
      TabOrder = 2
    end
    object btnIniciar: TButton
      Left = 216
      Top = 379
      Width = 105
      Height = 25
      Caption = 'Iniciar'
      TabOrder = 3
      OnClick = btnIniciarClick
    end
    object btnCancelar: TButton
      Left = 40
      Top = 379
      Width = 105
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = btnCancelarClick
    end
    object cxgDCU: TcxGrid
      Left = 24
      Top = 290
      Width = 353
      Height = 78
      TabOrder = 5
      object cxgDCUDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
        DataController.DataSource = dmCadastros.dsDCU
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxgDCUDBTableView1VERSAO: TcxGridDBColumn
          Caption = 'Vers'#227'o'
          DataBinding.FieldName = 'VERSAO'
          Width = 282
        end
      end
      object cxgDCULevel1: TcxGridLevel
        GridView = cxgDCUDBTableView1
      end
    end
    object cxgRotinaConsult: TcxGrid
      Left = 24
      Top = 151
      Width = 353
      Height = 135
      TabOrder = 6
      object cxgRotinaConsultDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
        DataController.DataSource = dmCadastros.dsRotina
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxgRotinaConsultDBTableView1ROTINA: TcxGridDBColumn
          Caption = 'Rotina'
          DataBinding.FieldName = 'ROTINA'
          Width = 250
        end
        object cxgRotinaConsultDBTableView1Modulo: TcxGridDBColumn
          Caption = 'Modulo'
          DataBinding.FieldName = 'MODULO'
          Visible = False
          GroupIndex = 0
          Width = 100
        end
      end
      object cxgRotinaConsultLevel1: TcxGridLevel
        GridView = cxgRotinaConsultDBTableView1
      end
    end
  end
end
