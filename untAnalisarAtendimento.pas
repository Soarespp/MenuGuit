unit untAnalisarAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,untDMCadastro, Menus;

type
  TfrmAnalisarRotina = class(TForm)
    cxgAnalisarRotinaDBTableView1: TcxGridDBTableView;
    cxgAnalisarRotinaLevel1: TcxGridLevel;
    cxgAnalisarRotina: TcxGrid;
    cxgAnalisarRotinaDBTableView1ROTINA: TcxGridDBColumn;
    pmAtualizarRotina: TPopupMenu;
    Analisar1: TMenuItem;
    cxgAnalisarRotinaDBTableView1Modulo: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure Analisar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
implementation

uses untGit;

{$R *.dfm}

procedure TfrmAnalisarRotina.Analisar1Click(Sender: TObject);
var vGit: TGit;
begin
  vGit := TGit.Create;
  try
    if MessageDlg('Será feito o reverte das alterações caso haja alteração no diretório.'+sLineBreak+
                  'Deseja continuar?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      Exit;
    vGit.Analisar(DmCadastro.qryRotinaID.AsString,0);
  finally
    vGit.Free;
  end;
end;

procedure TfrmAnalisarRotina.FormShow(Sender: TObject);
begin
  DmCadastro.AtualizarRotina;
end;

end.
