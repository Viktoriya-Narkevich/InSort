program InSort;

uses
  Forms,
  InSortMain in 'InSortMain.pas' {MainForm},
  UElem in 'UElem.pas',
  USort in 'USort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
