unit untComentario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,untGit,untDMCadastro;

type
  TfrmComentario = class(TForm)
    btnCommit: TButton;
    mmoTexto: TMemo;
    procedure btnCommitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FWt: string;
    FBranch: string;
    procedure SetWt(const Value: string);
    procedure SetBranch(const Value: string);
    { Private declarations }
  public
    function ShowModal(pWt,pBranch:string):integer;overload;


    property Wt:string read FWt write SetWt;
    property Branch:string read FBranch write SetBranch;
  end;

implementation

{$R *.dfm}

{ TfrmComentario }

procedure TfrmComentario.btnCommitClick(Sender: TObject);
var vGitCm : TGitComando;
    vText : string;
begin
  vGitCm := TGitComando.Create;
  try
    if Length(trim(mmoTexto.Lines.Text))= 0 then begin
      ShowMessage('Necessário existir um texto de commit.');
      Exit;
    end;

    mmoTexto.Lines.Text := Wt +' '+mmoTexto.Lines.Text;

    vGitCm.CommitPull(DmCadastro.qryAten.FieldByName('wt').AsString,
                      DmCadastro.qryAten.FieldByName('branch').AsString,
                      mmoTexto.Lines.Text,
                      DmCadastro.qryAten.FieldByName('rotina').AsString);
    ShowMessage('Commit e push realizado com sucesso.');
    Close;
  finally
    vGitCm.Free;
  end;
end;

procedure TfrmComentario.FormShow(Sender: TObject);
begin
  mmoTexto.SetFocus;
end;

procedure TfrmComentario.SetBranch(const Value: string);
begin
  FBranch := Value;
end;

procedure TfrmComentario.SetWt(const Value: string);
begin
  FWt := Value;
end;

function TfrmComentario.ShowModal(pWt, pBranch: string): integer;
begin
  Wt := pWt;
  Branch := pBranch;
  Result := ShowModal;
end;

end.
