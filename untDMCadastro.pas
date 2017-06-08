unit untDMCadastro;

interface

uses
  SysUtils, Classes,dmConexao, DB, MemDS, DBAccess, Ora;

type
  TdmCadastros = class(TDataModule)
    qryDCU: TOraQuery;
    dsDCU: TDataSource;
    qryDCUID: TFloatField;
    qryDCUVERSAO: TFloatField;
    qryDCUDIRETORIO: TStringField;
    qryExecute: TOraQuery;
    qryComGIT: TOraQuery;
    qryComGITID: TFloatField;
    qryComGITFUNCAO: TStringField;
    qryComGITCOMANDO: TStringField;
    qryComGITSEQ: TFloatField;
    dsComGit: TDataSource;
    qryRotina: TOraQuery;
    dsRotina: TDataSource;
    qryRotinaID: TFloatField;
    qryRotinaROTINA: TStringField;
    qryRotinaLINK: TStringField;
    qryAten: TOraQuery;
    dsAten: TDataSource;
    qryAtenID: TFloatField;
    qryAtenWT: TStringField;
    qryAtenBRANCH: TStringField;
    qryAtenVERSAO: TFloatField;
    qryAtenTIPOCRIACAO: TIntegerField;
    qryAtenDTCRIACAO: TDateTimeField;
    qryAtenROTINA: TFloatField;
    qryAtenTIPO: TStringField;
    qryAtenROTINANOME: TStringField;
    qryComGITOPCAO: TStringField;
    qryRotinaMODULO: TStringField;
  private
    { Private declarations }
  public
    procedure InserirDCU(const versao:Integer;const Caminho :string);
    procedure DeletarDCU(const pId:integer);
    procedure AtualizarDCU;
    function VerificarDCUCadastrada(const pVersao : integer):Boolean;
    procedure AtualizarDiretorioDCU(const versao:Integer;const Caminho :string);

    procedure IncluirAtendimento(const pWT,pNomeBranche:string;pVersao,pTipoCriacao:integer;const pRotina:string);
    procedure AtualizarAtendimento;

    procedure InserirParametros(pDirAtendimento:STRING);
    function CarregarParametros: TOraQuery;

    procedure AtualizarComandos;
    procedure IncluirComando(const pFucnao,pComando:string;const pSeq : Integer;const pOpcao : string);
    function AjustarComando(const pId:Integer;const pFucnao,pComando:string;const pSeq : Integer;const pOpcao : string):TOraQuery;

    procedure IncluirRotina(const pRotina,pLink:string);
    procedure AjustarRotina(const pId:Integer;const pRotina,pLink:string);
    procedure AtualizarRotina;
    function ValidaRotinaExiste(const pRotina:string):Boolean;

    function PegarDiretorio:string;
  end;

var
  DmCadastro: TdmCadastros;

implementation

{$R *.dfm}

{ TdmCadastros }

function TdmCadastros.AjustarComando(const pId: Integer; const pFucnao,
  pComando: string;const pSeq : Integer;const pOpcao : string): TOraQuery;
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'update comandos set comando = :comando, funcao = :funcao, seq = :SEQ, OPCAO = :OPCAO where id = :id';
    vQry.ParamByName('id').AsInteger      := pId;
    vQry.ParamByName('funcao').AsString   := pFucnao;
    vQry.ParamByName('comando').AsString  := pComando;
    vQry.ParamByName('SEQ').AsInteger     := pSeq;
    vQry.ParamByName('OPCAO').AsString    := pOpcao;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.AjustarRotina(const pId: Integer; const pRotina,
  pLink: string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'update rotina set rotina = :rotina, link = :link where id = :id';
    vQry.ParamByName('id').AsInteger      := pId;
    vQry.ParamByName('rotina').AsString   := pRotina;
    vQry.ParamByName('link').AsString  := pLink;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.AtualizarAtendimento;
begin
  qryAten.Close;
  qryAten.Open;
end;

procedure TdmCadastros.AtualizarComandos;
begin
  qryComGIT.Close;
  qryComGIT.Open;
end;

procedure TdmCadastros.AtualizarDCU;
begin
  qryDCU.Close;
  qryDCU.Open;
end;

procedure TdmCadastros.AtualizarDiretorioDCU(const versao: Integer;
  const Caminho: string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'update dcu set DIRETORIO = :CAMINHO where versao = :VERSAO';
    vQry.ParamByName('VERSAO').AsInteger  := versao;
    vQry.ParamByName('CAMINHO').AsString   := Caminho;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.AtualizarRotina;
begin
  qryRotina.Close;
  qryRotina.Open;
end;

function TdmCadastros.CarregarParametros:TOraQuery;
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);

  vQry.Close;
  vQry.SQL.Text := 'select * from parametros order by id';
  vQry.Open;

  result := vQry;
end;

procedure TdmCadastros.DeletarDCU(const pId: integer);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'delete from DCU WHERE ID = :ID';
    vQry.ParamByName('ID').AsInteger  := pId;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.IncluirAtendimento(const pWT, pNomeBranche: string;
  pVersao, pTipoCriacao: integer;const pRotina:string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'INSERT INTO ATENDIMENTO VALUES (SEQ_ATENDIMENTO.NEXTVAL,:WT,:BRANCHE,:VERSAO,:TIPOCRIACAO,SYSDATE,:ROTINA)';
    vQry.ParamByName('WT').AsString           := pWT;
    vQry.ParamByName('BRANCHE').AsString      := pNomeBranche;
    vQry.ParamByName('VERSAO').AsInteger      := pVersao;
    vQry.ParamByName('TIPOCRIACAO').AsInteger := pTipoCriacao;
    vQry.ParamByName('ROTINA').AsString       := pRotina;
    vQry.Execute;

  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.IncluirComando(const pFucnao, pComando: string;const pSeq : Integer;const pOpcao : string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'INSERT INTO COMANDOS VALUES (SEQ_COMANDO.NEXTVAL,:FUNCAO,:COMANDO,:SEQ,:OPCAO)';
    vQry.ParamByName('FUNCAO').AsString   := pFucnao;
    vQry.ParamByName('COMANDO').AsString  := pComando;
    vQry.ParamByName('SEQ').AsInteger     := pSeq;
    vQry.ParamByName('OPCAO').AsString    := pOpcao;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.IncluirRotina(const pRotina, pLink: string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'INSERT INTO ROTINA VALUES (SEQ_ROTINA.NEXTVAL,:ROTINA,:LINK)';
    vQry.ParamByName('ROTINA').AsString := pRotina;
    vQry.ParamByName('LINK').AsString   := pLink;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.InserirDCU(const versao: Integer; const Caminho: string);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'INSERT INTO DCU VALUES (SEQ_DCU.NEXTVAL,:VERSAO,:CAMINHO)';
    vQry.ParamByName('VERSAO').AsInteger  := versao;
    vQry.ParamByName('CAMINHO').AsString   := Caminho;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

procedure TdmCadastros.InserirParametros(pDirAtendimento: STRING);
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('begin');
    vQry.SQL.Add('  delete from parametros; ');
    vQry.SQL.Add('  ');
    vQry.SQL.Add('  insert into parametros values(0,''DIRATENDIMENTO'',:DIRETORIO);');
    vQry.SQL.Add('  ');
    vQry.SQL.Add('  COMMIT;');
    vQry.SQL.Add('end;');

    vQry.ParamByName('DIRETORIO').AsString  := pDirAtendimento;
    vQry.Execute;
  finally
    vQry.Free;
  end;
end;

function TdmCadastros.PegarDiretorio: string;
var vQry : TOraQuery;
begin
  Result := '';

  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select (select valor from parametros where id = 0) ||''\''||'''' dir ');
    vQry.SQL.Add('  from dual ');

    vQry.Open;

    Result := vQry.FieldByName('dir').AsString;
  finally
    vQry.Free;
  end;
end;

function TdmCadastros.ValidaRotinaExiste(const pRotina: string): Boolean;
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'select * from rotina where rotina = :rotina';
    vQry.ParamByName('rotina').AsString  := pRotina;
    vQry.Open;

    result := vQry.RecordCount > 0;
  finally
    vQry.Free;
  end;
end;

function TdmCadastros.VerificarDCUCadastrada(const pVersao: integer): Boolean;
var vQry: TOraQuery;
begin
  vQry := TOraQuery.Create(DataModule1.oraConexao);
  try
    vQry.Close;
    vQry.SQL.Text := 'select * from dcu where versao = :versao';
    vQry.ParamByName('VERSAO').AsInteger  := pVersao;
    vQry.Open;

    result := vQry.RecordCount > 0;
  finally
    vQry.Free;
  end;
end;

end.
