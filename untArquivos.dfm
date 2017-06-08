object frmArquivos: TfrmArquivos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Arquivos'
  ClientHeight = 118
  ClientWidth = 419
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
  object mmoDCU: TMemo
    Left = 0
    Top = 0
    Width = 419
    Height = 89
    Align = alTop
    Lines.Strings = (
      '@echo off'
      'choice /C SNP /M "Selecione: [S]26, [N]27, [P]28 para executar "'
      'IF errorlevel=3 goto P'
      'IF errorlevel=2 goto NAO'
      'IF errorlevel=1 goto SIM'
      ''
      ':SIM'
      'del wt_bibliotecas\pacotes_build\bpls /a/q'
      'del wt_bibliotecas\pacotes_build\dcps /a/q'
      'del wt_bibliotecas\pacotes_build\dcus /a/q'
      
        'copy C:\fontesSVN\Branches\26\bpls wt_bibliotecas\pacotes_build\' +
        'bpls\'
      
        'copy C:\fontesSVN\Branches\26\dcps wt_bibliotecas\pacotes_build\' +
        'dcps\'
      
        'copy C:\fontesSVN\Branches\26\dcus wt_bibliotecas\pacotes_build\' +
        'dcus\'
      'exit'
      ':NAO'
      'del wt_bibliotecas\pacotes_build\bpls /a/q'
      'del wt_bibliotecas\pacotes_build\dcps /a/q'
      'del wt_bibliotecas\pacotes_build\dcus /a/q'
      
        'copy C:\fontesSVN\Branches\27\bpls wt_bibliotecas\pacotes_build\' +
        'bpls\'
      
        'copy C:\fontesSVN\Branches\27\dcps wt_bibliotecas\pacotes_build\' +
        'dcps\'
      
        'copy C:\fontesSVN\Branches\27\dcus wt_bibliotecas\pacotes_build\' +
        'dcus\'
      'exit'
      ':P'
      'del wt_bibliotecas\pacotes_build\bpls /a/q'
      'del wt_bibliotecas\pacotes_build\dcps /a/q'
      'del wt_bibliotecas\pacotes_build\dcus /a/q'
      
        'copy C:\fontesSVN\Branches\28\bpls wt_bibliotecas\pacotes_build\' +
        'bpls\'
      
        'copy C:\fontesSVN\Branches\28\dcps wt_bibliotecas\pacotes_build\' +
        'dcps\'
      
        'copy C:\fontesSVN\Branches\28\dcus wt_bibliotecas\pacotes_build\' +
        'dcus\'
      'exit')
    TabOrder = 0
  end
  object btbSalvar: TButton
    Left = 0
    Top = 89
    Width = 419
    Height = 29
    Align = alClient
    Caption = 'Salvar'
    TabOrder = 1
    OnClick = btbSalvarClick
  end
end
