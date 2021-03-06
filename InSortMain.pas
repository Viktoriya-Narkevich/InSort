//11�. ���������� ���������� ������� ����� ����� ������� ����������� �������, ��� ������������� ��������������� �������
unit InSortMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,USort, ComCtrls, Mask, Spin, jpeg;

type
  TMainForm = class(TForm)
    img1: TImage;
    btnSort: TBitBtn;
    btnGenerate: TBitBtn;
    lbl1: TLabel;
    seDelay: TSpinEdit;
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure seDelayChange(Sender: TObject);
  private
    FMas:TMasElem;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnGenerateClick(Sender: TObject);
begin
  FMas.SetRandom;
  FMas.Show;
  btnSort.Enabled:=True;
  Self.DoubleBuffered:=True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FMas:=TMasElem.Create(img1,200);
  FMas.SetRandom;
  FMas.Show;

end;

procedure TMainForm.btnSortClick(Sender: TObject);
begin
  btnGenerate.Enabled:=False;
  btnSort.Enabled:=False;
  FMas.Sort;
  ShowMessage('�������������!');
  btnGenerate.Enabled:=True;
end;

procedure TMainForm.seDelayChange(Sender: TObject);
begin
  FMas.Delay:=seDelay.Value;
end;



end.
