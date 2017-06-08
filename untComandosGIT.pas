unit untComandosGIT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,untDMCadastro, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, DB, cxDBData, StdCtrls, ExtCtrls,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TppStatus = (tpNull,tpInsert,tpEdit);

  TfrmComandosGIT = class(TForm)
    cxgComandosDBTableView1: TcxGridDBTableView;
    cxgComandosLevel1: TcxGridLevel;
    cxgComandos: TcxGrid;
    pnlCentral: TPanel;
    edtFuncao: TEdit;
    lblFuncao: TLabel;
    edtComando: TEdit;
    lblComando: TLabel;
    btnEvento: TButton;
    btnCancelar: TButton;
    cxgComandosDBTableView1FUNCAO: TcxGridDBColumn;
    cxgComandosDBTableView1COMANDO: TcxGridDBColumn;
    cxgComandosDBTableView1SEQ: TcxGridDBColumn;
    edtSeq: TEdit;
    lblSeq: TLabel;
    lblOpcao: TLabel;
    edtOpco: TEdit;
    cxgComandosDBTableView1Opcao: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgComandosDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnEventoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FStatus: TppStatus;
    pId :Integer;
    procedure SetStatus(const Value: TppStatus);
    procedure AjustarTela;
  public
    property Status : TppStatus read FStatus write SetStatus;
  end;

const
  SALVAR  = 'Salvar';
  NOVO    = 'Novo';

implementation


{$R *.dfm}


{ TfrmComandosGIT }

procedure TfrmComandosGIT.AjustarTela;
begin
  case Status of
    tpNull: begin
              btnEvento.Caption   := NOVO;
              btnCancelar.Visible := false;
              cxgComandos.Enabled := true;
              edtFuncao.Enabled   := False;
              edtComando.Enabled  := False;
              edtSeq.Enabled      := False;
              edtOpco.Enabled     := False;
              edtFuncao.Clear;
              edtComando.Clear;
              edtSeq.Clear;
              edtOpco.Clear;
              DmCadastro.AtualizarComandos;
              pId := 0;
            end;
    tpInsert: begin
                btnEvento.Caption   := SALVAR;
                btnCancelar.Visible := True;
                cxgComandos.Enabled := False;
                edtFuncao.Enabled   := true;
                edtComando.Enabled  := true;
                edtSeq.Enabled      := true;
                edtOpco.Enabled     := True;
                edtFuncao.SetFocus;
              end;
    tpEdit: begin
              btnEvento.Caption   := SALVAR;
              btnCancelar.Visible := True;
              cxgComandos.Enabled := False;
              edtFuncao.Enabled   := true;
              edtComando.Enabled  := true;
              edtSeq.Enabled      := true;
              edtOpco.Enabled     := true;
              edtFuncao.Text      := DmCadastro.qryComGIT.FieldByName('funcao').AsString;
              edtComando.Text     := DmCadastro.qryComGIT.FieldByName('comando').AsString;
              edtSeq.Text         := DmCadastro.qryComGIT.FieldByName('seq').AsString;
              edtOpco.Text         := DmCadastro.qryComGIT.FieldByName('OPCAO').AsString;
              edtFuncao.SetFocus;
            end;
  end;

end;

procedure TfrmComandosGIT.btnCancelarClick(Sender: TObject);
begin
  Status := tpNull;
end;

procedure TfrmComandosGIT.btnEventoClick(Sender: TObject);
begin
  if edtSeq.Text = '0' then begin
    ShowMessage('Valor 0 não permitido para o campo.');
    exit;
  end;

  case Status of
    tpInsert: DmCadastro.IncluirComando(edtFuncao.Text,edtComando.Text,StrToInt(edtSeq.Text),edtOpco.Text);
    tpEdit:   DmCadastro.AjustarComando(DmCadastro.qryComGITID.AsInteger,edtFuncao.Text,edtComando.Text,StrToInt(edtSeq.Text),edtOpco.Text);
  end;

  if Status = tpNull then
    Status := tpInsert
  else
    Status := tpNull;
end;

procedure TfrmComandosGIT.cxgComandosDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
//  ShowMessage(DmCadastro.qryComGITID.AsString);
  pId := DmCadastro.qryComGITID.AsInteger;
  Status := tpEdit;
end;

procedure TfrmComandosGIT.FormCreate(Sender: TObject);
begin
  Status := tpNull;
end;

procedure TfrmComandosGIT.FormShow(Sender: TObject);
begin
  Status := tpNull;
end;

procedure TfrmComandosGIT.SetStatus(const Value: TppStatus);
begin
  FStatus := Value;
  AjustarTela;
end;

end.
