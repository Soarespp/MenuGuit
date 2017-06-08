unit dmConexao;

interface

uses
  SysUtils, Classes, OraCall, DB, DBAccess, Ora;

type
  TDataModule1 = class(TDataModule)
    oraConexao: TOraSession;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  oraConexao.Connect;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  oraConexao.Disconnect;
end;

end.
