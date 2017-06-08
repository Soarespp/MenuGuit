program MenuGit;

uses
  Forms,
  untMenu in 'untMenu.pas' {frmMenu},
  untNovoAtendimento in 'untNovoAtendimento.pas' {frmNovoAtendimento},
  untDiretorioDCU in 'untDiretorioDCU.pas' {frmDiretorioDCU},
  dmConexao in 'dmConexao.pas' {DataModule1: TDataModule},
  untDMCadastro in 'untDMCadastro.pas' {dmCadastros: TDataModule},
  untCadastrarDCU in 'untCadastrarDCU.pas' {frmCadastrarDCU},
  untGit in 'untGit.pas',
  untParametros in 'untParametros.pas' {frmParamtros},
  untComandosGIT in 'untComandosGIT.pas' {frmComandosGIT},
  untRotina in 'untRotina.pas' {frmRotina},
  untAnalisarAtendimento in 'untAnalisarAtendimento.pas' {frmAnalisarRotina},
  untArquivos in 'untArquivos.pas' {frmArquivos},
  untComentario in 'untComentario.pas' {frmComentario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDmCadastros, DmCadastro);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
