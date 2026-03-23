unit uFileHashs;

interface

uses
  Windows, SysUtils, Classes, Math;


function GetFileHashOfMd5(const AFileName: string): String;


implementation

uses
  JwaWinCrypt;


Function GetFileSizeEx(hFile: THandle; Var lpFileSizeHigh :UInt64):Boolean; stdcall; external kernel32 name 'GetFileSizeEx';

function ByteToChar(v: Byte): Char; inline;
const
  // asc '0' -- 48, 'A' -- 65 ( - 10)
  HEXOFFDATA: array [Boolean] of Byte = (55, 48);
begin
  Result := Char(HEXOFFDATA[v < 10] + v);
end;

function GetFileHashOfMd5(const AFileName: string): String;
Const
  Buffer_Threshold = 1024 * 1024;
Var
  hFile      :THandle;
  hMapFile   :THandle;
  dwFileSize :UInt64;
  dwFileSizeH:DWORD;

  hProv      :HCRYPTPROV;
  hHash      :HCRYPTHASH;
  iIndex     :UInt64;
  dwBufSize  :DWORD;
  lpBuffer   :PByte;

  lpHash     :Array [0..MAXCHAR] Of Byte;
  dwHashLen  :DWORD;
  szHash     :Array [0..MAXCHAR] Of Char;
  iHashStrLen: Integer;
begin
  lpBuffer := Nil;
  hProv := 0;
  hHash := 0;
  iHashStrLen := 0;

  hMapFile := INVALID_HANDLE_VALUE;
  hFile    := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, Nil,OPEN_EXISTING, 0, 0);
  try
    if hFile = INVALID_HANDLE_VALUE then Exit;
    if Not GetFileSizeEx(hFile, dwFileSize) then Exit;

    hMapFile := CreateFileMapping(hFile, Nil, PAGE_READONLY, 0, 0, Nil);
    if hMapFile = INVALID_HANDLE_VALUE then Exit;
    if Not CryptAcquireContext(hProv, Nil, Nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT Or CRYPT_MACHINE_KEYSET) Then
      Exit;
    if Not CryptCreateHash(hProv, CALG_MD5, 0, 0, hHash) Then Exit;

    iIndex := 0;
    while iIndex < dwFileSize do
    begin
      dwBufSize := Min(dwFileSize - iIndex, Buffer_Threshold);
      lpBuffer  := MapViewOfFile(hMapFile, FILE_MAP_READ, Int64Rec(iIndex).Hi, Int64Rec(iIndex).Lo, dwBufSize);
      if lpBuffer = Nil then
        Exit;
      if Not CryptHashData(hHash, lpBuffer, dwBufSize, 0) then
        Exit;

      UnmapViewOfFile(lpBuffer);
      Inc(iIndex, Buffer_Threshold);
      lpBuffer := nil;
    end;

    dwHashLen := 0;
    dwBufSize := SizeOf(DWORD);
    if CryptGetHashParam(hHash, HP_HASHSIZE, @dwHashLen, dwBufSize, 0) and
       CryptGetHashParam(hHash, HP_HASHVAL, @lpHash, dwHashLen, 0) then
    begin
      for dwFileSizeH := 0 to dwHashLen - 1 do
      begin
        szHash[iHashStrLen] := ByteToChar(lpHash[dwFileSizeH] shr 4);
        szHash[iHashStrLen+1] := ByteToChar(lpHash[dwFileSizeH] and $F);
        inc(iHashStrLen, 2);
      end;
    end;
  finally
    CryptDestroyHash(hHash);
    CryptReleaseContext(hProv, 0);
    UnmapViewOfFile(lpBuffer);
    CloseHandle(hFile);
    CloseHandle(hMapFile);
  end;

  SetString(Result, szHash, iHashStrLen);
end;


end.
