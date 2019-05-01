unit ufrmmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,wofhelper;

type
  Tfrmmain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    txtfile: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  frmmain: Tfrmmain;

implementation

{$R *.dfm}



procedure Tfrmmain.Button1Click(Sender: TObject);
begin
try
wofcompress(txtfile.Text);
except
on e:exception do showmessage(e.Message );
end;
end;

procedure Tfrmmain.Button2Click(Sender: TObject);
begin
try
wofuncompress(txtfile.Text);
except
on e:exception do showmessage(e.Message );
end;
end;

end.
