unit untNovoAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,untDMCadastro, Buttons;

type
  TfrmNovoAtendimento = class(TForm)
    Panel1: TPanel;
    edtWT: TEdit;
    lblWt: TLabel;
    lbNameBranche: TLabel;
    edtNomeBranche: TEdit;
    rgOpcoes: TRadioGroup;
    btnIniciar: TButton;
    btnCancelar: TButton;
    cxgDCUDBTableView1: TcxGridDBTableView;
    cxgDCULevel1: TcxGridLevel;
    cxgDCU: TcxGrid;
    cxgDCUDBTableView1VERSAO: TcxGridDBColumn;
    cxgRotinaConsultDBTableView1: TcxGridDBTableView;
    cxgRotinaConsultLevel1: TcxGridLevel;
    cxgRotinaConsult: TcxGrid;
    cxgRotinaConsultDBTableView1ROTINA: TcxGridDBColumn;
    cxgRotinaConsultDBTableView1Modulo: TcxGridDBColumn;
    procedure btnIniciarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public

  end;

implementation

{$R *.dfm}

procedure TfrmNovoAtendimento.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmNovoAtendimento.btnIniciarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmNovoAtendimento.FormShow(Sender: TObject);
begin
  DMCadastro.AtualizarDCU;
  DmCadastro.AtualizarRotina;
end;


end.
