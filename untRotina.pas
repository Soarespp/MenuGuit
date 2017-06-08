unit untRotina;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  DB, cxDBData, StdCtrls, ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untDMCadastro;

type
  TppStatus = (tpNull,tpInsert,tpEdit);

  TfrmRotina = class(TForm)
    cxgRotinaDBTableView1: TcxGridDBTableView;
    cxgRotinaLevel1: TcxGridLevel;
    cxgRotina: TcxGrid;
    pnlCentral: TPanel;
    edtRotina: TEdit;
    lblRotina: TLabel;
    edtLink: TEdit;
    lblLink: TLabel;
    btnEvento: TButton;
    btnCancelar: TButton;
    cxgRotinaDBTableView1ROTINA: TcxGridDBColumn;
    cxgRotinaDBTableView1LINK: TcxGridDBColumn;
    cxgRotinaDBTableView1Modulo: TcxGridDBColumn;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgRotinaDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnEventoClick(Sender: TObject);
  private
    FStatus: TppStatus;
    procedure SetStatus(const Value: TppStatus);
    { Private declarations }
  public
    property Status : TppStatus read FStatus write SetStatus;
    procedure AtualizarTela;
  end;
const
  SALVAR  = 'Salvar';
  NOVO    = 'Novo';
implementation

{$R *.dfm}

{ TfrmRotina }

procedure TfrmRotina.AtualizarTela;
begin
  case Status of
    tpNull: begin
              btnEvento.Caption   := NOVO;
              btnCancelar.Visible := false;
              cxgRotina.Enabled := true;
              edtRotina.Enabled   := False;
              edtLink.Enabled  := False;
              edtRotina.Clear;
              edtLink.Clear;
              DmCadastro.AtualizarRotina;
            end;
    tpInsert: begin
                btnEvento.Caption   := SALVAR;
                btnCancelar.Visible := True;
                cxgRotina.Enabled := False;
                edtRotina.Enabled   := true;
                edtLink.Enabled  := true;
                edtRotina.SetFocus;
              end;
    tpEdit: begin
              btnEvento.Caption   := SALVAR;
              btnCancelar.Visible := True;
              cxgRotina.Enabled   := False;
              edtRotina.Enabled   := true;
              edtLink.Enabled     := true;
              edtRotina.Text      := DmCadastro.qryRotina.FieldByName('rotina').AsString;
              edtLink.Text        := DmCadastro.qryRotina.FieldByName('link').AsString;
              edtRotina.SetFocus;
            end;
  end;

end;

procedure TfrmRotina.btnCancelarClick(Sender: TObject);
begin
  Status := tpNull;
end;

procedure TfrmRotina.btnEventoClick(Sender: TObject);
begin
  if DmCadastro.ValidaRotinaExiste(edtRotina.Text) and (Status = tpInsert)then begin
    ShowMessage('Rotina já existente não e permitido incluir uma nova dela');
    exit;
  end;

  case Status of
    tpInsert: DmCadastro.IncluirRotina(edtRotina.Text,edtLink.Text);
    tpEdit:   DmCadastro.AjustarRotina(DmCadastro.qryRotinaID.AsInteger,edtRotina.Text,edtLink.Text);
  end;

  if Status = tpNull then
    Status := tpInsert
  else
    Status := tpNull;
end;

procedure TfrmRotina.cxgRotinaDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  Status := tpEdit;
end;

procedure TfrmRotina.FormShow(Sender: TObject);
begin
  Status := tpNull;
end;

procedure TfrmRotina.SetStatus(const Value: TppStatus);
begin
  FStatus := Value;
  AtualizarTela;
end;

end.
