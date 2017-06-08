unit untMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,dmConexao, ExtCtrls, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,untDMCadastro, StdCtrls, cxDropDownEdit;

type
  TfrmMenu = class(TForm)
    mmPrincipal: TMainMenu;
    Atendimento1: TMenuItem;
    NovoAtendimento1: TMenuItem;
    Cadastros1: TMenuItem;
    DCU1: TMenuItem;
    Parmetros1: TMenuItem;
    pmMenuExec: TPopupMenu;
    IniciarAntedimento1: TMenuItem;
    ComandosGIT1: TMenuItem;
    Rotina1: TMenuItem;
    cxgAtendimentosDBTableView1: TcxGridDBTableView;
    cxgAtendimentosLevel1: TcxGridLevel;
    cxgAtendimentos: TcxGrid;
    cxgAtendimentosDBTableView1WT: TcxGridDBColumn;
    cxgAtendimentosDBTableView1BRANCH: TcxGridDBColumn;
    cxgAtendimentosDBTableView1VERSAO: TcxGridDBColumn;
    cxgAtendimentosDBTableView1RotinaNome: TcxGridDBColumn;
    cxgAtendimentosDBTableView1TipoAt: TcxGridDBColumn;
    TrayIcon1: TTrayIcon;
    pmTrayIc: TPopupMenu;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    AlterarAtendimento1: TMenuItem;
    Analisar1: TMenuItem;
    AnalisarRotina1: TMenuItem;
    PegarbatDCU1: TMenuItem;
    Comandos1: TMenuItem;
    BowerInstall1: TMenuItem;
    AtualizarDCU1: TMenuItem;
    Fetch1: TMenuItem;
    Commit1: TMenuItem;
    Stash1: TMenuItem;
    Arquivosbat1: TMenuItem;
    Conflito1: TMenuItem;
    Rebase1: TMenuItem;
    procedure NovoAtendimento1Click(Sender: TObject);
    procedure DCU1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Parmetros1Click(Sender: TObject);
    procedure IniciarAntedimento1Click(Sender: TObject);
    procedure ComandosGIT1Click(Sender: TObject);
    procedure Rotina1Click(Sender: TObject);
    procedure btnIniciarAtendimentoClick(Sender: TObject);
    procedure btnAlterarAtendimentClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure AlterarAtendimento1Click(Sender: TObject);
    procedure Analisar1Click(Sender: TObject);
    procedure AnalisarRotina1Click(Sender: TObject);
    procedure PegarbatDCU1Click(Sender: TObject);
    procedure BowerInstall1Click(Sender: TObject);
    procedure AtualizarDCU1Click(Sender: TObject);
    procedure Fetch1Click(Sender: TObject);
    procedure Commit1Click(Sender: TObject);
    procedure Stash1Click(Sender: TObject);
    procedure Arquivosbat1Click(Sender: TObject);
    procedure Conflito1Click(Sender: TObject);
    procedure Rebase1Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmMenu: TfrmMenu;

implementation

uses untNovoAtendimento,untDiretorioDCU,untCadastrarDCU,untParametros,
     untComandosGIT,untGit, untRotina, untAnalisarAtendimento,untArquivos,
     untComentario;
{$R *.dfm}

procedure TfrmMenu.Abrir1Click(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmMenu.AlterarAtendimento1Click(Sender: TObject);
var vGit : TGit;
    vComando:string;
begin

  vGit :=  TGit.Create;
  try
    if DmCadastro.qryAten.RecNo = 0 then begin
      ShowMessage('Nenhum atendimento selecionado.');
      Exit;
    end else if vGit.VericarDiretorio(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINA').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger) then BEGIN
      ShowMessage('Atendimento ainda não iniciado, '+sLineBreak+
                  'necessário iniciar o atendimento primeiro.');
      Exit;
    END;
    if MessageDlg('Será feito o reverte das alterações caso haja alteração.'+sLineBreak+
                  'Deseja continuar?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      Exit;

    vGit.AlterarAtendimento(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINANOME').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGit.Free;
  end;

end;

procedure TfrmMenu.Analisar1Click(Sender: TObject);
var vGit : TGit;
    vComando:string;
begin

  vGit :=  TGit.Create;
  try
    if DmCadastro.qryAten.RecNo = 0 then begin
      ShowMessage('Nenhum atendimento selecionado.');
      Exit;
    end else if vGit.VericarDiretorio(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINA').AsString,
                            0) then BEGIN
      ShowMessage('Atendimento ainda não iniciado, '+sLineBreak+
                  'necessário iniciar o atendimento primeiro.');
      Exit;
    END;

    vGit.Analisar(DmCadastro.qryAten.FieldByName('ROTINA').AsString,0);
  finally
    vGit.Free;
  end;

end;

procedure TfrmMenu.AnalisarRotina1Click(Sender: TObject);
var vAnal : TfrmAnalisarRotina;
begin
  vAnal := TfrmAnalisarRotina.Create(nil);
  try
    vAnal.ShowModal;
  finally
    vAnal.Free;
  end;
end;

procedure TfrmMenu.Arquivosbat1Click(Sender: TObject);
var vFrmArq : TfrmArquivos;
begin
  vFrmArq := TfrmArquivos.Create(nil);
  try
    vFrmArq.ShowModal;
  finally
    vFrmArq.Free;
  end;
end;

procedure TfrmMenu.AtualizarDCU1Click(Sender: TObject);
var vFrmArq: TfrmArquivos;
begin
  vFrmArq := TfrmArquivos.Create(nil);
  try
    vFrmArq.AtualizarDCU(DmCadastro.qryAten.FieldByName('wt').AsString,
                        DmCadastro.qryAten.FieldByName('branch').AsString);
  finally
    vFrmArq.Free;
  end;
end;

procedure TfrmMenu.BowerInstall1Click(Sender: TObject);
var vGitCm : TGitComando;
begin
  vGitCm := TGitComando.Create;
  try
    vGitCm.BowerInstall(DmCadastro.qryAten.FieldByName('wt').AsString,
                        DmCadastro.qryAten.FieldByName('branch').AsString,
                        DmCadastro.PegarDiretorio,
                        DmCadastro.qryAten.FieldByName('rotina').AsString);
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmMenu.btnAlterarAtendimentClick(Sender: TObject);
var vGit : TGit;
    vComando:string;
begin

  vGit :=  TGit.Create;
  try
    if DmCadastro.qryAten.RecNo = 0 then begin
      ShowMessage('Nenhum atendimento selecionado.');
      Exit;
    end else if vGit.VericarDiretorio(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINA').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger) then BEGIN
      ShowMessage('Atendimento ainda não iniciado, '+sLineBreak+
                  'necessário iniciar o atendimento primeiro.');
      Exit;
    END;

    vGit.AlterarAtendimento(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINANOME').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGit.Free;
  end;

end;

procedure TfrmMenu.btnIniciarAtendimentoClick(Sender: TObject);
var vGit : TGit;
    vComando:string;
begin

  vGit :=  TGit.Create;
  try
    if DmCadastro.qryAten.RecNo = 0 then begin
      ShowMessage('Nenhum atendimento selecionado.');
      Exit;
    end;
    vGit.IniciarAntedimento(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINANOME').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGit.Free;
  end;

end;

procedure TfrmMenu.ComandosGIT1Click(Sender: TObject);
var vFrmComandoGIt: TfrmComandosGIT;
begin
  vFrmComandoGIt := TfrmComandosGIT.Create(nil);
  try
    vFrmComandoGIt.ShowModal;
  finally
    vFrmComandoGIt.Free;
  end;
end;

procedure TfrmMenu.Commit1Click(Sender: TObject);
var vGitCm : TfrmComentario;
begin
  vGitCm := TfrmComentario.Create(nil);
  try
    vGitCm.ShowModal(DmCadastro.qryAten.FieldByName('wt').AsString,
                     DmCadastro.qryAten.FieldByName('branch').AsString);
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmMenu.Conflito1Click(Sender: TObject);
var vGitCm : TGitComando;
begin
  vGitCm := TGitComando.Create;
  try
    vGitCm.Conflito(DmCadastro.qryAten.FieldByName('wt').AsString,
                    DmCadastro.qryAten.FieldByName('branch').AsString,
                    DmCadastro.qryAten.FieldByName('ROTINA').AsString,
                    DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmMenu.DCU1Click(Sender: TObject);
var vDirDCU : TfrmDiretorioDCU;
begin
  vDirDCU := TfrmDiretorioDCU.create(nil);
  try
    vDirDCU.ShowModal;
    if vDirDCU.ModalResult = mrOk then
      DmCadastro.AtualizarAtendimento;
  finally
    vDirDCU.free;
  end;
end;

procedure TfrmMenu.Fechar1Click(Sender: TObject);
begin
  Free;
end;

procedure TfrmMenu.Fetch1Click(Sender: TObject);
var vGitCm : TGitComando;
begin
  vGitCm := TGitComando.Create;
  try
    vGitCm.Fetch(DmCadastro.qryAten.FieldByName('wt').AsString,
                 DmCadastro.qryAten.FieldByName('branch').AsString,
                 DmCadastro.qryAten.FieldByName('rotina').AsString);
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Self.Hide;
//  TrayIcon1.Visible := True;
//  TrayIcon1.Animate := True;
//  TrayIcon1.ShowBalloonHint;
//  WindowState := wsMinimized;
//  exit;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  dmCadastro.AtualizarAtendimento;
end;

procedure TfrmMenu.IniciarAntedimento1Click(Sender: TObject);
var vGit : TGit;
    vComando:string;
begin

  vGit :=  TGit.Create;
  try
    if DmCadastro.qryAten.RecNo = 0 then begin
      ShowMessage('Nenhum atendimento selecionado.');
      Exit;
    end;
    vGit.IniciarAntedimento(DmCadastro.qryAten.FieldByName('wt').AsString,
                            DmCadastro.qryAten.FieldByName('branch').AsString,
                            DmCadastro.qryAten.FieldByName('ROTINANOME').AsString,
                            DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGit.Free;
  end;

end;

procedure TfrmMenu.NovoAtendimento1Click(Sender: TObject);
var vNvAtendimento : TfrmNovoAtendimento;
begin
  vNvAtendimento := TfrmNovoAtendimento.create(nil);
  try
      vNvAtendimento.ShowModal;
    if vNvAtendimento.ModalResult = mrOk then begin
      if Length(Trim(vNvAtendimento.edtWT.Text)) = 0 then
          ShowMessage('Necessário informar uma WT')
      else if Length(Trim(vNvAtendimento.edtNomeBranche.Text)) = 0 then
        ShowMessage('Necessário informar uma branche')
      else if Length(Trim(DmCadastro.qryDCU.FieldByName('versao').AsString)) = 0 then
        ShowMessage('Necessário selecionar uma versão')
      else if Length(Trim(DMCadastro.qryRotina.FieldByName('id').AsString)) = 0 then
        ShowMessage('Necessário selecionar uma rotina')
      else begin
//        ShowMessage('teste');
        DmCadastro.IncluirAtendimento(vNvAtendimento.edtWT.Text,
                                       vNvAtendimento.edtNomeBranche.Text,
                                       DMCadastro.qryDCU.FieldByName('versao').AsInteger,
                                       vNvAtendimento.rgOpcoes.ItemIndex,
                                       DMCadastro.qryRotina.FieldByName('ID').AsString);

      end;
      DmCadastro.AtualizarAtendimento;
    end;
  finally
    vNvAtendimento.free;
  end;
end;

procedure TfrmMenu.Parmetros1Click(Sender: TObject);
var vFrmParam : TfrmParamtros;
begin
  vFrmParam := TfrmParamtros.Create(nil);
  try
    vFrmParam.ShowModal;
    if vFrmParam.ModalResult = mrOk then begin
      if Length(Trim(vFrmParam.edtDiretorioAtendimento.Text)) = 0 then
          ShowMessage('Necessário Diretório padrão para os atendimentos.')
      else begin
        DmCadastro.InserirParametros(vFrmParam.edtDiretorioAtendimento.Text);
      end;
    end;
  finally
    vFrmParam.Free
  end;
end;

procedure TfrmMenu.PegarbatDCU1Click(Sender: TObject);
var vArq : TfrmArquivos;
begin
  vArq := TfrmArquivos.Create(nil);
  try
    vArq.ShowModal;
  finally
    vArq.Free;
  end;
end;

procedure TfrmMenu.Rebase1Click(Sender: TObject);
var vGitRebase : TGitComando;
begin
  vGitRebase := TGitComando.Create;
  try
    vGitRebase.Rebase(DmCadastro.qryAten.FieldByName('wt').AsString,
                      DmCadastro.qryAten.FieldByName('branch').AsString,
                      DmCadastro.qryAten.FieldByName('ROTINA').AsString,
                      DmCadastro.qryAten.FieldByName('TIPOCRIACAO').AsInteger);
  finally
    vGitRebase.Free;
  end;
end;

procedure TfrmMenu.Rotina1Click(Sender: TObject);
var vRot : TfrmRotina;
begin
  vRot := TfrmRotina.Create(nil);
  try
    vRot.ShowModal;
  finally
    vRot.Free;
  end;
end;

procedure TfrmMenu.Stash1Click(Sender: TObject);
var vGitCm : TGitComando;
begin
  vGitCm := TGitComando.Create;
  try
    vGitCm.Stash(DmCadastro.qryAten.FieldByName('wt').AsString,
                 DmCadastro.qryAten.FieldByName('branch').AsString,
                 DmCadastro.qryAten.FieldByName('rotina').AsString);
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmMenu.TrayIcon1Click(Sender: TObject);
begin
  TrayIcon1.ShowBalloonHint();
end;

procedure TfrmMenu.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
