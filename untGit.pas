unit untGit;

interface

uses untDMCadastro,dmConexao,ora,WINDOWS,SysUtils,StrUtils,classes;

type
  tpTipo = (tpNovo,tpAlterar,tpAnalisar);
  TGitComando = class
  private
    { private declarations }
  public
    procedure BowerInstall(pWt,pBranch,dir,pRotina: string);
    procedure Fetch(pWt,pBranch,pRotina: string);
    procedure Commit(pWt,pBranch,pComentario,pRotina: string);
    procedure Stash(pWt,pBranch,pRotina: string);
    procedure CommitPull(pWt,pBranch,pComentario,pRotina:string);
    procedure Conflito(pWt,pBranch,pRotina:string;ptipo:integer);
    procedure Rebase(pWt,pBranch,pRotina:string;ptipo:integer);
  end;

  TGit = class
  private
    { private declarations }
  public
    procedure executarComandos(const pWT,pBranch,pRotina:string;const pTipo:tpTipo);
    procedure ExecutarComandosAnalise(pRotina:string);
    procedure AjustarDiretorio(const pWT, pBranch,pRotina: string;const pTipoDir : integer);
    function VericarDiretorio(const pWT, pBranch,pRotina: string;const pTipoDir : integer):boolean;

    procedure IniciarAntedimento(const pWT, pBranch,pRotina: string;const pTipoDir : integer);
    procedure AlterarAtendimento(const pWT, pBranch,pRotina: string;const pTipoDir : integer);
    procedure Analisar(pRotina: string;const pTipoDir : integer);
  end;

implementation

uses untArquivos;

{ TGit }

procedure TGit.AjustarDiretorio(const pWT, pBranch,pRotina: string;const pTipoDir : integer);
var vQry: TOraQuery;
    vDir: string;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'select valor from parametros where opcao = ''DIRATENDIMENTO'' ';
    vQry.Open;

    if (length(Trim(pBranch)) = 0) and (length(Trim(pWT)) = 0) then begin
      vDir := vQry.FieldByName('valor').AsString+'\'+Copy(pRotina,6,2);
    end else begin
      case pTipoDir of
        0 : vDir := vQry.FieldByName('valor').AsString+'\'+Copy(pRotina,6,2);
        1 : vDir := vQry.FieldByName('valor').AsString+'\'+Copy(pRotina,6,2)+'\'+pWT;
      end;
    end;


    if not DirectoryExists(vDir) then begin
      CreateDir(vDir);
    end;
  finally
    vQry.free;
  end;

end;

procedure TGit.AlterarAtendimento(const pWT, pBranch, pRotina: string;
  const pTipoDir: integer);
begin
  AjustarDiretorio(pWT,pBranch,pRotina,pTipoDir);
  executarComandos(pWT,pBranch,pRotina,tpAlterar);
end;

procedure TGit.Analisar(pRotina: string; const pTipoDir: integer);
begin
  AjustarDiretorio('','',pRotina,pTipoDir);
  ExecutarComandosAnalise(pRotina);
end;

procedure TGit.executarComandos(const pWT,pBranch,pRotina:string;const pTipo:tpTipo);
var vQry:TOraQuery;
    vComando,vDiretorio,vLink,
    vRotina:string;
    vListaComando: TStringList;
    vTipo:Integer;
    vFrmArq: TfrmArquivos;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select (select valor from parametros where id = 0) ||''\''|| ');
    vQry.SQL.Add('       case tipocriacao ');
    vQry.SQL.Add('            when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\'' ');
    vQry.SQL.Add('            else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\'' ');
    vQry.SQL.Add('       end dir, ');
    vQry.SQL.Add('       (select link from rotina where id = a.rotina ) link,');
    vQry.SQL.Add('       (select rotina from rotina where id = a.rotina) rotina, ');
    vQry.SQL.Add('       tipocriacao tipo ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.rotina = :rotina');
    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vDiretorio  := vQry.FieldByName('dir').AsString;
    vLink       := vQry.FieldByName('link').AsString;
    vRotina     := vQry.FieldByName('rotina').AsString;
    vTipo       := vQry.FieldByName('tipo').AsInteger;

    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\'' ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\'' ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a ');
    vQry.SQL.Add(' where a.wt = :wt ');
    vQry.SQL.Add('   and a.branch = :branch ');
    vQry.SQL.Add('union ');
    vQry.SQL.Add('select c.seq, ');
    vQry.SQL.Add('       c.comando, ');
    vQry.SQL.Add('       '''' PREF, ');
    vQry.SQL.Add('       '''' OBS, ');
    vQry.SQL.Add('       OPCAO  ');
    vQry.SQL.Add('  from comandos c ');
    vQry.SQL.Add('  union ');
    vQry.SQL.Add('  select (select max(seq)+1 from comandos) seq, ');
    vQry.SQL.Add('         (select valor from parametros where id = 0) || ');
    vQry.SQL.Add('         case tipocriacao ');
    vQry.SQL.Add('              when 0 then ''\''||(select substr(rotina,6,2) from rotina where id = a.rotina )||''\''||(select rotina from rotina where id = a.rotina ) ');
    vQry.SQL.Add('              else ''\''||(select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina )||''\''');
    vQry.SQL.Add('         end||''\wt_bibliotecas\''  comando, ');
    vQry.SQL.Add('         ''DCU'' PREF, ');
    vQry.SQL.Add('         D.DIRETORIO OBS, ');
    vQry.SQL.Add('         '''' OPCAO  ');
    vQry.SQL.Add('    from dcu d, ');
    vQry.SQL.Add('         atendimento a ');
    vQry.SQL.Add('   where d.versao = a.versao ');
    vQry.SQL.Add('     and a.wt = :wt ');
    vQry.SQL.Add('     and a.branch = :branch ');
    vQry.SQL.Add('  order by seq ');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;

    vQry.Open;

    vQry.First;
    while not vQry.Eof do begin
      if UpperCase(vQry.FieldByName('PREF').AsString) = 'DCU' then begin
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bbpls /a/q');
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcps /a/q');
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus /a/q');

        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\bpls '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus\');
        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\dcps '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcps\');
        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\dcus '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus\');
      end else if Length(Trim(vQry.FieldByName('OPCAO').AsString)) > 0 then begin

        case AnsiIndexStr(UpperCase(vQry.FieldByName('OPCAO').AsString),['CLONE','CHECKOUT','DIR']) of
          0 : begin
                case pTipo of
                  tpNovo : begin
                        if pTipo = tpNovo then
                          vListaComando.Add(vQry.FieldByName('comando').AsString +' '+ vLink);
                        vListaComando.Add('cd '+vDiretorio+vRotina+'\');
                      end;
                  tpAlterar : begin
                        vListaComando.Add('cd '+vDiretorio+vRotina+'\');
                        vListaComando.Add('del '+vDiretorio+vRotina+'\wt_bibliotecas /a/q');
                        vListaComando.Add('git stash ')
                      end;

                end;
              end;
          1 : begin
                vListaComando.Add(vQry.FieldByName('comando').AsString+' '+ pBranch);
              end;
          2 : BEGIN
                vListaComando.Add(vQry.FieldByName('OBS').AsString);
                vListaComando.Add(vQry.FieldByName('comando').AsString);
              END;
        end;
      end else
        vListaComando.Add(vQry.FieldByName('comando').AsString);

      vQry.Next;
    end;

    vListaComando.SaveToFile('C:\WinThor\Spool\comands.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands.bat'),SW_SHOWNORMAL);

  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGit.ExecutarComandosAnalise(pRotina:string);
var vQry:TOraQuery;
    vComando,vDiretorio,vLink,
    vRotina:string;
    vListaComando: TStringList;
    vTipo:Integer;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select (select valor from parametros where id = 0) ||''\'' dir, ');
    vQry.SQL.Add('       (select link from rotina where id = :rotina ) link,');
    vQry.SQL.Add('       (select rotina from rotina where id = :rotina) rotina ');
    vQry.SQL.Add('  from dual ');
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vDiretorio  := vQry.FieldByName('dir').AsString;
    vLink       := vQry.FieldByName('link').AsString;
    vRotina     := vQry.FieldByName('rotina').AsString;

    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||(select substr(rotina,6,2) from rotina where id = :rotina )||''\'' comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from dual ');
    vQry.SQL.Add('union ');
    vQry.SQL.Add('select c.seq, ');
    vQry.SQL.Add('       c.comando, ');
    vQry.SQL.Add('       '''' PREF, ');
    vQry.SQL.Add('       '''' OBS, ');
    vQry.SQL.Add('       OPCAO  ');
    vQry.SQL.Add('  from comandos c ');
    vQry.SQL.Add('  union ');
    vQry.SQL.Add('  select (select max(seq)+1 from comandos) seq, ');
    vQry.SQL.Add('         (select valor from parametros where id = 0) ||''\''||(select substr(rotina,6,2) from rotina where id = :rotina )|| ');
    vQry.SQL.Add('         ''\''||(select rotina from rotina where id = :rotina ) ');
    vQry.SQL.Add('         ||''\wt_bibliotecas\''  comando, ');
    vQry.SQL.Add('         ''DCU'' PREF, ');
    vQry.SQL.Add('         D.DIRETORIO OBS, ');
    vQry.SQL.Add('         '''' OPCAO  ');
    vQry.SQL.Add('    from dcu d ');
    vQry.SQL.Add('   where d.versao = (select min(versao) from dcu) ');
    vQry.SQL.Add('  order by seq ');

    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vQry.First;
    while not vQry.Eof do begin
      if UpperCase(vQry.FieldByName('PREF').AsString) = 'DCU' then begin
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bbpls /a/q');
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcps /a/q');
        vListaComando.Add('del '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus /a/q');

        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\bpls '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus\');
        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\dcps '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcps\');
        vListaComando.Add('copy '+vQry.FieldByName('OBS').AsString+'\dcus '+vQry.FieldByName('comando').AsString+'pacotes_build\bdcus\');
      end else if Length(Trim(vQry.FieldByName('OPCAO').AsString)) > 0 then begin

        case AnsiIndexStr(UpperCase(vQry.FieldByName('OPCAO').AsString),['CLONE','CHECKOUT','DIR']) of
          0 : begin
                vListaComando.Add(vQry.FieldByName('comando').AsString +' '+ vLink);
                vListaComando.Add('cd '+vDiretorio+Copy(vRotina,6,2)+'\'+vRotina+'\');
              end;
          1 : begin
                vListaComando.Add(vQry.FieldByName('comando').AsString+' master');
              end;
          2 : BEGIN
                vListaComando.Add(vQry.FieldByName('OBS').AsString);
                vListaComando.Add(vQry.FieldByName('comando').AsString);
              END;
        end;
      end else
        vListaComando.Add(vQry.FieldByName('comando').AsString);

      vQry.Next;
    end;

    vListaComando.SaveToFile('C:\WinThor\Spool\comands.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGit.IniciarAntedimento(const pWT, pBranch, pRotina: string;
  const pTipoDir: integer);
begin
  AjustarDiretorio(pWT,pBranch,pRotina,pTipoDir);
  executarComandos(pWT,pBranch,pRotina,tpNovo);
end;

function TGit.VericarDiretorio(const pWT, pBranch, pRotina: string;
  const pTipoDir: integer):boolean;
var vQry: TOraQuery;
    vDir: string;
begin
  result := false;
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'select valor from parametros where opcao = ''DIRATENDIMENTO'' ';
    vQry.Open;

    case pTipoDir of
      0 : vDir := vQry.FieldByName('valor').AsString+'\'+pRotina;
      1 : vDir := vQry.FieldByName('valor').AsString+'\'+pWT+'\'+pRotina;
    end;


    if DirectoryExists(vDir) then begin
      result := true;
    end;
  finally
    vQry.free;
  end;
end;

{ TGitComando }

procedure TGitComando.BowerInstall(pWt,pBranch,dir,pRotina: string);
var vListaComando : TStringList;
    vQry : TOraQuery;

begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('bower install --force ');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.Commit(pWt, pBranch,pComentario,pRotina: string);
var vListaComando : TStringList;
    vQry : TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\'' || wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git commit');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.CommitPull(pWt, pBranch, pComentario,pRotina: string);
var vListaComando : TStringList;
    vQry : TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\'' || wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('wt').AsString     := pWt;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git fetch');
    vListaComando.Add('git commit -m "'+pComentario+'" --all');
    vListaComando.Add('git push origin '+pBranch);

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.Fetch(pWt, pBranch,pRotina: string);
var vListaComando : TStringList;
    vQry : TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('rotina').AsString := pRotina;
    vQry.ParamByName('branch').AsString := pBranch;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git fetch');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.Rebase(pWt, pBranch, pRotina: string; ptipo: integer);
var vListaComando : TStringList;
    vQry : TOraQuery;
    vGit : TGit;
begin
  vGit :=  TGit.Create;
  try
    vGit.AjustarDiretorio(pWt,pBranch,pRotina,ptipo);
  finally
    vGit.Free;
  end;
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git checkout '+pBranch);
    vListaComando.Add('git rebase master');
    vListaComando.Add('git pull');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.Conflito(pWt, pBranch, pRotina: string;ptipo:integer);
var vListaComando : TStringList;
    vQry : TOraQuery;
    vGit : TGit;
begin
  vGit :=  TGit.Create;
  try
    vGit.AjustarDiretorio(pWt,pBranch,pRotina,ptipo);
  finally
    vGit.Free;
  end;
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git checkout '+pBranch);
    vListaComando.Add('git pull origin master');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

procedure TGitComando.Stash(pWt, pBranch,pRotina: string);
var vListaComando : TStringList;
    vQry : TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  vListaComando :=  TStringList.Create;
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select 0 seq, ');
    vQry.SQL.Add('   ''cd ''||(select valor from parametros where id = 0)||''\''||  ');
    vQry.SQL.Add('   case tipocriacao ');
    vQry.SQL.Add('        when 0 then (select substr(rotina,6,2) from rotina where id = a.rotina ) ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('        else (select substr(rotina,6,2) from rotina where id = a.rotina )||''\''|| wt ||''\''||(select rotina from rotina where id = a.rotina) ');
    vQry.SQL.Add('   end comando, ');
    vQry.SQL.Add('       ''CD'' PREF, ');
    vQry.SQL.Add('       substr((select valor from parametros where id = 0),1,instr((select valor from parametros where id = 0),''\'')-1) OBS, ');
    vQry.SQL.Add('       ''DIR'' OPCAO  ');
    vQry.SQL.Add('  from atendimento a, ');
    vQry.SQL.Add('       rotina r ');
    vQry.SQL.Add(' where a.wt = :wt ');;
    vQry.SQL.Add('   and a.branch = :branch');
    vQry.SQL.Add('   and a.rotina = r.id');
    vQry.SQL.Add('   and r.id = :rotina');

    vQry.ParamByName('wt').AsString     := pWT;
    vQry.ParamByName('branch').AsString := pBranch;
    vQry.ParamByName('rotina').AsString := pRotina;

    vQry.Open;

    vListaComando.Add(vQry.FieldByName('OBS').AsString);
    vListaComando.Add(vQry.FieldByName('comando').AsString);
    vListaComando.Add('git stash');

    vListaComando.SaveToFile('C:\WinThor\Spool\comands_bower.bat');
    WinExec(PAnsiChar('C:\WinThor\Spool\comands_bower.bat'),SW_SHOWNORMAL);
  finally
    vListaComando.Free;
    vQry.Free;
  end;
end;

end.
