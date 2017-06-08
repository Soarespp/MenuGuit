object frmParamtros: TfrmParamtros
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Parametros'
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
  object pnlCentral: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 241
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 112
    ExplicitTop = 24
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblDirAtendimento: TLabel
      Left = 24
      Top = 16
      Width = 123
      Height = 13
      Caption = 'Diret'#243'rio de atendimento:'
    end
    object spbtDirAtendimento: TSpeedButton
      Left = 448
      Top = 34
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = spbtDirAtendimentoClick
    end
    object btnCancelar: TButton
      Left = 104
      Top = 198
      Width = 137
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object edtDiretorioAtendimento: TEdit
      Left = 24
      Top = 35
      Width = 425
      Height = 21
      TabOrder = 1
    end
  end
  object btnSalvar: TButton
    Left = 312
    Top = 198
    Width = 121
    Height = 25
    Caption = 'Salvar'
    TabOrder = 1
    OnClick = btnSalvarClick
  end
end
