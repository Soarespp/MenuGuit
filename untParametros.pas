unit untParametros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,FileCtrl,ora;

type
  TfrmParamtros = class(TForm)
    pnlCentral: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    edtDiretorioAtendimento: TEdit;
    lblDirAtendimento: TLabel;
    spbtDirAtendimento: TSpeedButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure spbtDirAtendimentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untDMCadastro;

{$R *.dfm}

procedure TfrmParamtros.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmParamtros.btnSalvarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmParamtros.FormShow(Sender: TObject);
var dmCadastros : TdmCadastros;
    vQry : TOraQuery;
begin
  dmCadastros := TdmCadastros.Create(nil);
  try
    vQry := dmCadastros.CarregarParametros;

    vQry.First;
    while not vQry.Eof do begin
      if vQry.FieldByName('ID').AsInteger = 0 then
        edtDiretorioAtendimento.Text := vQry.FieldByName('valor').AsString;

      vQry.Next;
    end;
  finally
    dmCadastros.Free;
  end;
end;

procedure TfrmParamtros.spbtDirAtendimentoClick(Sender: TObject);
VAR dir : STRING;
begin
  dir := 'C:\';
  if SelectDirectory(dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
    edtDiretorioAtendimento.Text := dir;
end;

end.
