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
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
//showmessage(inttostr(FILE_SHARE_DELETE or FILE_SHARE_READ or FILE_SHARE_WRITE));
//showmessage(inttostr(open_existing));
//showmessage(inttostr(sizeof(ExternalBacking)));
end;

procedure Tfrmmain.Button3Click(Sender: TObject);
begin
if IsWofCompress(txtfile.Text ) then showmessage('true') else showmessage('false'); 
end;

end.
