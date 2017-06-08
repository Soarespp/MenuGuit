unit untCadastrarDCU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,FileCtrl;

type
  TfrmCadastrarDCU = class(TForm)
    pnCentral: TPanel;
    edtVersao: TEdit;
    lblVersao: TLabel;
    lblDiretorio: TLabel;
    edtDiretorio: TEdit;
    dlgOpenDiretorio: TOpenDialog;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnDirDCU: TSpeedButton;
    dlgSave: TSaveDialog;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDirDCUClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmCadastrarDCU.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmCadastrarDCU.btnDirDCUClick(Sender: TObject);
VAR dir : STRING;
begin
  dir := 'C:\fontesSVN';
  if SelectDirectory(dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
    edtDiretorio.Text := dir;

end;

procedure TfrmCadastrarDCU.btnSalvarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
