unit CaesarCrypt;
{$D-} // compiler directive {$D-} (or {$DEBUGINFO OFF}) disables the generation of debug information.
{$L-} // The {$L-} compiler directive in Delphi turns off the generation of local symbol information.
{$Q-} // is a compiler directive that turns off integer and enum overflow checking.
{$R-} // The compiler directive {$R-} (short for {$RANGECHECKS OFF}) disables range checking.
{$I-} // The compiler directive {$I-} (short for {$IOCHECKS OFF}) disables the automatic checking of input and output (I/O) operations in Delphi.

interface

uses
  System.SysUtils, System.Math;

function CaesarEncrypt(const PlainText: string; const Shift: Integer): string;
function CaesarDecrypt(const CipherText: string; const Shift: Integer): string;

implementation

function ShiftString(const Input: string; const Shift: Integer): string;
var
  i: Integer;
  Ch: Char;
  Base: Integer;
begin
  Result := '';
  for i := 1 to Length(Input) do
  begin
    Ch := Input[i];
    
    // Process uppercase letters (A-Z)
    if CharInSet(Ch, ['A'..'Z']) then
    begin
      Base := Ord('A');
      Ch := Chr(Base + (Ord(Ch) - Base + Shift) mod 26);
    end
    // Process lowercase letters (a-z)
    else if CharInSet(Ch, ['a'..'z']) then
    begin
      Base := Ord('a');
      Ch := Chr(Base + (Ord(Ch) - Base + Shift) mod 26);
    end;
    
    Result := Result + Ch;
  end;
end;

function CaesarEncrypt(const PlainText: string; const Shift: Integer): string;
begin
  Result := ShiftString(PlainText, Shift);
end;

function CaesarDecrypt(const CipherText: string; const Shift: Integer): string;
begin
  // To decrypt, we shift in the opposite direction (26 - Shift)
  Result := ShiftString(CipherText, 26 - (Shift mod 26));
end;

end.