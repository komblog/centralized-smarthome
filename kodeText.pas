unit kodeText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformKode = class(TForm)
    txtKode: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formKode: TformKode;

implementation

uses ListRule;
{$R *.dfm}

end.
