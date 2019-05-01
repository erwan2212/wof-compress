unit wofhelper;

interface

uses windows,sysutils;

function wofcompress(filename:string):boolean;
function wofuncompress(filename:string):boolean;
function IsWofCompress(Filename:string):boolean;

implementation

type WOF_EXTERNAL_INFO = record
WOFEI_Version:ulong;
WOFEI_Provider:ulong;
end;

type WIM_PROVIDER_EXTERNAL_INFO = record
FPEI_Version:ulong;
FPEI_CompressionFormat:ulong;
Flags:ulong;
end;

type ExternalBacking=record
ExternalInfo:WOF_EXTERNAL_INFO;
ProviderInfo:WIM_PROVIDER_EXTERNAL_INFO;
end;

const FSCTL_SET_EXTERNAL_BACKING   =$9030C;
const FSCTL_DELETE_EXTERNAL_BACKING=$90314;
const FSCTL_GET_EXTERNAL_BACKING   =$90310;

Const WOF_CURRENT_VERSION = 1;
Const WOF_PROVIDER_FILE = 2;
Const FILE_PROVIDER_COMPRESSION_FORMAT_XPRESS4K = 0;
Const FILE_PROVIDER_COMPRESSION_FORMAT_LZX = 1;
Const FILE_PROVIDER_COMPRESSION_FORMAT_XPRESS8K = 2;
Const FILE_PROVIDER_COMPRESSION_FORMAT_XPRESS16K = 3;
Const FILE_PROVIDER_CURRENT_VERSION = 1;

function IsWofCompress(Filename:string):boolean;
var
hfile:thandle;
ret:dword;
Backing:ExternalBacking;
begin
hFile := CreateFile(pchar(Filename), {0x181} GENERIC_READ, FILE_SHARE_DELETE or FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, $0A000000, 0);
if hfile=thandle(-1) then raise exception.create('invalid handle');

fillchar(Backing,sizeof(Backing),0);

Ret := 0;
if DeviceIoControl(hFile, FSCTL_GET_EXTERNAL_BACKING, nil, 0, @backing, sizeof(ExternalBacking), ret, nil)<>true then raise exception.create('DeviceIoControl failed:'+inttostr(getlasterror));
end;

function wofuncompress(filename:string):boolean;
var
hfile:thandle;
ret:dword;
begin
result:=false;
try
//not compressed? lets stop it there...
if IsWofCompress(filename)=false then exit;
except
exit;
end;
hFile := CreateFile(pchar(filename ), $181, FILE_SHARE_DELETE or FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, $0A000000, 0);
if hfile=thandle(-1) then raise exception.create('invalid handle');

Ret := 0;
if DeviceIoControl(hFile, FSCTL_DELETE_EXTERNAL_BACKING, nil, 0, nil, 0, ret, nil)<>true then raise exception.create('DeviceIoControl failed:'+inttostr(getlasterror));
result:=true;
end;

function wofcompress(filename:string):boolean;
var
hfile:thandle;
ret:dword;
Backing:ExternalBacking;
begin
result:=false;
hFile := CreateFile(pchar(filename ), $81, FILE_SHARE_READ or FILE_SHARE_DELETE, nil, OPEN_EXISTING, $0A000000, 0);
if hfile=thandle(-1) then raise exception.create('invalid handle');


fillchar(Backing,sizeof(Backing),0);
with backing do
begin
ExternalInfo.WOFEI_Version :=WOF_CURRENT_VERSION;
ExternalInfo.WOFEI_Provider :=WOF_PROVIDER_FILE;
ProviderInfo.FPEI_Version :=FILE_PROVIDER_CURRENT_VERSION;
ProviderInfo.FPEI_CompressionFormat :=FILE_PROVIDER_COMPRESSION_FORMAT_LZX;
end;

Ret := 0;
if DeviceIoControl(hFile, FSCTL_SET_EXTERNAL_BACKING, @backing, $14, nil, 0, ret, nil)<>true then raise exception.create('DeviceIoControl failed:'+inttostr(getlasterror));
result:=true;
end;



end.
