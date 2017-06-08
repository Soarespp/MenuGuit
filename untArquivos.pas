unit untArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,untDMCadastro,ORA,dmConexao,shellapi;

type
  TfrmArquivos = class(TForm)
    mmoDCU: TMemo;
    btbSalvar: TButton;
    procedure btbSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AtualizarDCU(pWt,pBranch: string);
  end;


implementation

{$R *.dfm}

procedure TfrmArquivos.AtualizarDCU(pWt, pBranch: string);
var vQry : TOraQuery;
    vCaminho: string;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   (select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a ');
    vQry.SQL.Add(' where a.wt = :wt ');
    vQry.SQL.Add('   and a.branch = :branch ');
    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;

    vQry.Open;
    mmoDCU.Lines.Text := 'cd '+Trim(vQry.FieldByName('comando').AsString)+sLineBreak+mmoDCU.Lines.Text;
    vCaminho := Trim(vQry.FieldByName('comando').AsString)+'\comands_DCU.bat';

    mmoDCU.Lines.SaveToFile(vCaminho);
    ShellExecute(Handle,'open',PChar(vCaminho),nil,nil,SW_SHOWNORMAL);
  finally
    vQry.Free;
  end;
end;

procedure TfrmArquivos.btbSalvarClick(Sender: TObject);
var vCaminho :string;
begin
  vCaminho := DmCadastro.PegarDiretorio;
  mmoDCU.Lines.SaveToFile('texto_batDCU.txt');
  mmoDCU.Lines.SaveToFile(vCaminho+'\clone_dcu.bat');
  ShowMessage('Salvo em '+vCaminho);
  Close;
end;

procedure TfrmArquivos.FormShow(Sender: TObject);
begin
  if FileExists('texto_batDCU.txt') then
    mmoDCU.Lines.LoadFromFile('texto_batDCU.txt');

end;

end.
