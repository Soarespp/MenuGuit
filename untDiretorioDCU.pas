unit untDiretorioDCU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,untDMCadastro, Menus;

type
  TfrmDiretorioDCU = class(TForm)
    mmPrinc: TMainMenu;
    Novo1: TMenuItem;
    cxgDiretorioDCU: TcxGrid;
    cxgDiretorioDCUDBTableView1: TcxGridDBTableView;
    cxgDiretorioDCUDBTableView1VERSAO: TcxGridDBColumn;
    cxgDiretorioDCUDBTableView1DIRETORIO: TcxGridDBColumn;
    cxgDiretorioDCULevel1: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure cxgDiretorioDCUDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
  end;


implementation

uses untCadastrarDCU;
{$R *.dfm}

procedure TfrmDiretorioDCU.cxgDiretorioDCUDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var vNovDCU : TfrmCadastrarDCU;
begin
  vNovDCU := TfrmCadastrarDCU.create(nil);
  try
    vNovDCU.edtVersao.Text    := DmCadastro.qryDCU.FieldByName('versao').AsString;
    vNovDCU.edtVersao.ReadOnly := true;
    vNovDCU.edtDiretorio.Text := DmCadastro.qryDCU.FieldByName('diretorio').AsString;
    vNovDCU.ShowModal;

    if vNovDCU.ModalResult = mrOk then begin
      if Length(trim(vNovDCU.edtDiretorio.Text)) = 0 then
        ShowMessage('Necessário informar um diretório')
      else if Length(trim(vNovDCU.edtVersao.Text)) = 0 then
        ShowMessage('Necessário informar um diretório')
      else begin
        if DmCadastro.VerificarDCUCadastrada(strtoint(vNovDCU.edtVersao.Text)) then begin
          if MessageDlg('Versão já inserida deseja mudar o diretório?',mtconfirmation,[mbyes,mbno],0)= mryes then
            DmCadastro.AtualizarDiretorioDCU(strtoint(vNovDCU.edtVersao.Text),vNovDCU.edtDiretorio.Text);
        end;
        DmCadastro.AtualizarDCU;
      end;
    end;
  finally
    vNovDCU.free;
  end;
end;

procedure TfrmDiretorioDCU.FormCreate(Sender: TObject);
begin
  DmCadastro.AtualizarDCU;
end;

procedure TfrmDiretorioDCU.Novo1Click(Sender: TObject);
var vNovDCU : TfrmCadastrarDCU;
begin
  vNovDCU := TfrmCadastrarDCU.create(nil);
  try
    vNovDCU.ShowModal;
    if vNovDCU.ModalResult = mrOk then begin
      if Length(trim(vNovDCU.edtDiretorio.Text)) = 0 then
        ShowMessage('Necessário informar um diretório')
      else if Length(trim(vNovDCU.edtVersao.Text)) = 0 then
        ShowMessage('Necessário informar um diretório')
      else begin
        if DmCadastro.VerificarDCUCadastrada(strtoint(vNovDCU.edtVersao.Text)) then begin
          if MessageDlg('Versão já inserida deseja mudar o diretório?',mtconfirmation,[mbyes,mbno],0)= mryes then
            DmCadastro.AtualizarDiretorioDCU(strtoint(vNovDCU.edtVersao.Text),vNovDCU.edtDiretorio.Text);
        end else
          DmCadastro.InserirDCU(strtoint(vNovDCU.edtVersao.Text),vNovDCU.edtDiretorio.Text);
        DmCadastro.AtualizarDCU;
      end;
    end;
  finally
    vNovDCU.free;
  end;
end;

end.
