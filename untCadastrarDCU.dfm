object frmCadastrarDCU: TfrmCadastrarDCU
  Left = 0
  Top = 0
  Caption = 'Cadastrar DCU'
  ClientHeight = 178
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnCentral: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 178
    Align = alClient
    TabOrder = 0
    object lblVersao: TLabel
      Left = 32
      Top = 16
      Width = 37
      Height = 13
      Caption = 'Vers'#227'o:'
    end
    object lblDiretorio: TLabel
      Left = 32
      Top = 64
      Width = 45
      Height = 13
      Caption = 'Diret'#243'rio:'
    end
    object btnDirDCU: TSpeedButton
      Left = 392
      Top = 80
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = btnDirDCUClick
    end
    object edtVersao: TEdit
      Left = 32
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtDiretorio: TEdit
      Left = 32
      Top = 80
      Width = 361
      Height = 21
      TabOrder = 1
    end
    object btnCancelar: TButton
      Left = 32
      Top = 128
      Width = 121
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnSalvar: TButton
      Left = 272
      Top = 128
      Width = 121
      Height = 25
      Caption = 'Salvar'
      TabOrder = 3
      OnClick = btnSalvarClick
    end
  end
  object dlgOpenDiretorio: TOpenDialog
    Left = 345
    Top = 44
  end
  object dlgSave: TSaveDialog
    Left = 288
    Top = 56
  end
end
