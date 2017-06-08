object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Menu GIT'
  ClientHeight = 766
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmPrincipal
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxgAtendimentos: TcxGrid
    Left = 0
    Top = 0
    Width = 397
    Height = 766
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 746
    object cxgAtendimentosDBTableView1: TcxGridDBTableView
      PopupMenu = pmMenuExec
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
      DataController.DataSource = dmCadastros.dsAten
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
      object cxgAtendimentosDBTableView1RotinaNome: TcxGridDBColumn
        Caption = 'Rotina'
        DataBinding.FieldName = 'ROTINANOME'
        Visible = False
        GroupIndex = 0
        Width = 150
      end
      object cxgAtendimentosDBTableView1WT: TcxGridDBColumn
        DataBinding.FieldName = 'WT'
        Width = 150
      end
      object cxgAtendimentosDBTableView1BRANCH: TcxGridDBColumn
        Caption = 'Branch'
        DataBinding.FieldName = 'BRANCH'
        Width = 150
      end
      object cxgAtendimentosDBTableView1VERSAO: TcxGridDBColumn
        Caption = 'Vers'#227'o'
        DataBinding.FieldName = 'VERSAO'
      end
      object cxgAtendimentosDBTableView1TipoAt: TcxGridDBColumn
        Caption = 'Tipo Cria'#231#227'o'
        DataBinding.FieldName = 'TIPO'
      end
    end
    object cxgAtendimentosLevel1: TcxGridLevel
      GridView = cxgAtendimentosDBTableView1
    end
  end
  object mmPrincipal: TMainMenu
    Left = 176
    Top = 80
    object Atendimento1: TMenuItem
      Caption = 'Atendimento'
      object NovoAtendimento1: TMenuItem
        Caption = 'Novo Atendimento'
        OnClick = NovoAtendimento1Click
      end
      object AnalisarRotina1: TMenuItem
        Caption = 'Analisar Rotina'
        OnClick = AnalisarRotina1Click
      end
      object PegarbatDCU1: TMenuItem
        Caption = 'Pegar .bat DCU'
        OnClick = PegarbatDCU1Click
      end
    end
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object DCU1: TMenuItem
        Caption = 'DCU'
        OnClick = DCU1Click
      end
      object ComandosGIT1: TMenuItem
        Caption = 'Comandos GIT'
        OnClick = ComandosGIT1Click
      end
      object Rotina1: TMenuItem
        Caption = 'Rotina'
        OnClick = Rotina1Click
      end
      object Arquivosbat1: TMenuItem
        Caption = 'Arquivos .bat '
        OnClick = Arquivosbat1Click
      end
    end
    object Parmetros1: TMenuItem
      Caption = 'Parametros'
      OnClick = Parmetros1Click
    end
  end
  object pmMenuExec: TPopupMenu
    Left = 264
    Top = 72
    object IniciarAntedimento1: TMenuItem
      Caption = 'Iniciar Antedimento'
      OnClick = IniciarAntedimento1Click
    end
    object AlterarAtendimento1: TMenuItem
      Caption = 'Alterar Atendimento'
      OnClick = AlterarAtendimento1Click
    end
    object Analisar1: TMenuItem
      Caption = 'Analisar'
      OnClick = Analisar1Click
    end
    object Comandos1: TMenuItem
      Caption = 'Comandos'
      object BowerInstall1: TMenuItem
        Caption = 'Bower Install'
        OnClick = BowerInstall1Click
      end
      object AtualizarDCU1: TMenuItem
        Caption = 'Atualizar DCU'
        OnClick = AtualizarDCU1Click
      end
      object Fetch1: TMenuItem
        Caption = 'Fetch'
        OnClick = Fetch1Click
      end
      object Commit1: TMenuItem
        Caption = 'Commit/push'
        OnClick = Commit1Click
      end
      object Stash1: TMenuItem
        Caption = 'Stash (Revert)'
        OnClick = Stash1Click
      end
      object Conflito1: TMenuItem
        Caption = 'Conflito'
        OnClick = Conflito1Click
      end
      object Rebase1: TMenuItem
        Caption = 'Rebase'
        OnClick = Rebase1Click
      end
    end
  end
  object TrayIcon1: TTrayIcon
    BalloonHint = 'Controle de atendimento'
    PopupMenu = pmTrayIc
    OnClick = TrayIcon1Click
    OnDblClick = TrayIcon1DblClick
    Left = 304
    Top = 176
  end
  object pmTrayIc: TPopupMenu
    Left = 112
    Top = 184
    object Abrir1: TMenuItem
      Caption = 'Abrir'
      OnClick = Abrir1Click
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
