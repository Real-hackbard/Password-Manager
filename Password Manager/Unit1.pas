unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls,  System.ImageList, Vcl.ImgList,
  System.IniFiles, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Menus, WinApi.ShellAPI, Vcl.Clipbrd, UEncrypt, PDUCrypt, System.Math,
  CaesarCrypt;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label8: TLabel;
    ImageList1: TImageList;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    NewEntry1: TMenuItem;
    Delete1: TMenuItem;
    BitBtn3: TBitBtn;
    Search1: TMenuItem;
    BitBtn4: TBitBtn;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label9: TLabel;
    Rename1: TMenuItem;
    N1: TMenuItem;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    Edit8: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Image1: TImage;
    Label12: TLabel;
    Image2: TImage;
    GroupBox3: TGroupBox;
    CheckBox5: TCheckBox;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    CheckBox6: TCheckBox;
    GroupBox4: TGroupBox;
    ComboBox2: TComboBox;
    Label13: TLabel;
    CheckBox7: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure BitBtn2Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure NewEntry1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Rename1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Edit8Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox7Click(Sender: TObject);
    procedure Edit8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    procedure Gradient(Col1, Col2: TColor; Bmp: TBitmap);
  public
    procedure WriteOptions;
    procedure ReadOptions;
    { Public declarations }
  end;

var
  Form1: TForm1;
  path : string;  // main treeview account file path
  TIF : TIniFile; // Option File

const
  CKEY1 = 53761;  // Unicode Encoder key1
  CKEY2 = 32618;  // Unicode Encoder key2

implementation

{$R *.dfm}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteInteger(OPT,'CryptMode',ComboBox2.ItemIndex);
    WriteInteger(OPT,'Unicode',ComboBox1.ItemIndex);
    WriteBool(OPT,'StayTop',CheckBox5.Checked);
    WriteBool(OPT,'HideData',CheckBox6.Checked);
    WriteBool(OPT,'PassNumbers',CheckBox1.Checked);
    WriteBool(OPT,'LowLetters',CheckBox2.Checked);
    WriteBool(OPT,'UpLetters',CheckBox3.Checked);
    WriteBool(OPT,'SpecialCharacter',CheckBox4.Checked);
    WriteInteger(OPT,'CharCount',SpinEdit1.Value);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      ComboBox2.ItemIndex:=ReadInteger(OPT,'CryptMode',ComboBox2.ItemIndex);
      ComboBox1.ItemIndex:=ReadInteger(OPT,'Unicode',ComboBox1.ItemIndex);
      CheckBox5.Checked:=ReadBool(OPT,'StayTop',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'HideData',CheckBox6.Checked);
      CheckBox1.Checked:=ReadBool(OPT,'PassNumbers',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'LowLetters',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'UpLetters',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'SpecialCharacter',CheckBox4.Checked);
      SpinEdit1.Value:=ReadInteger(OPT,'CharCount',SpinEdit1.Value);
      Free;
    end;
  end;
end;

{$D-} // compiler directive {$D-} (or {$DEBUGINFO OFF}) disables the generation of debug information.
{$L-} // The {$L-} compiler directive in Delphi turns off the generation of local symbol information.
{$Q-} // is a compiler directive that turns off integer and enum overflow checking.
{$R-} // The compiler directive {$R-} (short for {$RANGECHECKS OFF}) disables range checking.
{$I-} // The compiler directive {$I-} (short for {$IOCHECKS OFF}) disables the automatic checking of input and output (I/O) operations in Delphi.
{$WARN UNSAFE_CAST OFF} // In Delphi, the compiler directive {$WARN UNSAFE_CAST OFF} specifically disables the compiler warning W1048 ("Unsafe typecast").
{$WARN UNSAFE_CODE OFF} // The directive {$WARN UNSAFE_CODE OFF} silences the W1047 "Unsafe Code" warning generated when using unmanaged code, such as pointer math or direct memory access.
{$WARN UNSAFE_TYPE OFF} // To disable the UNSAFE_TYPE warning in Delphi, place {$WARN UNSAFE_TYPE OFF} in your source code.

// Vigenere Encryption
function EncryptVigenere(const Text, Key: string): string;
var
  i, KeyIndex, Shift, Code: Integer;
begin
  Result := '';
  KeyIndex := 1;
  for i := 1 to Length(Text) do
  begin
    // Check if the character is a lowercase letter
    if CharInSet(Text[i], ['a'..'z']) then
    begin
      Shift := Ord(Key[KeyIndex]) - Ord('a');
      Code := (Ord(Text[i]) - Ord('a') + Shift) mod 26;
      Result := Result + Chr(Code + Ord('a'));
      // Move to the next key character, looping if necessary
      KeyIndex := (KeyIndex mod Length(Key)) + 1;
    end
    else
    begin
      // Leave non-alphabetic characters unchanged
      Result := Result + Text[i];
    end;
  end;
end;
// Vigenere Decryption
function DecryptVigenere(const Text, Key: string): string;
var
  i, KeyIndex, Shift, Code: Integer;
begin
  Result := '';
  KeyIndex := 1;
  for i := 1 to Length(Text) do
  begin
    // Check if the character is a lowercase letter
    if CharInSet(Text[i], ['a'..'z']) then
    begin
      Shift := Ord(Key[KeyIndex]) - Ord('a');
      Code := (Ord(Text[i]) - Ord('a') - Shift + 26) mod 26;
      Result := Result + Chr(Code + Ord('a'));
      // Move to the next key character, looping if necessary
      KeyIndex := (KeyIndex mod Length(Key)) + 1;
    end
    else
    begin
      // Leave non-alphabetic characters unchanged
      Result := Result + Text[i];
    end;
  end;
end;

// RC4 Encryption
function RC4EncryptString(const AText, AKey: string): string;
var
  SBox: array[0..255] of Byte;
  KeyBytes, TextBytes, ResultBytes: TBytes;
  I, J, T, KeyLen, TextLen: Integer;
  Temp: Byte;
begin
  Result := '';
  if (AText = '') or (AKey = '') then Exit;

  // Safely convert strings to byte arrays (UTF-8) for Unicode compatibility
  TextBytes := TEncoding.UTF8.GetBytes(AText);
  KeyBytes := TEncoding.UTF8.GetBytes(AKey);
  TextLen := Length(TextBytes);
  KeyLen := Length(KeyBytes);
  SetLength(ResultBytes, TextLen);

  // 1. Initialization of the S-Box (Key Scheduling Algorithm - KDF)
  for I := 0 to 255 do
    SBox[I] := I;

  J := 0;
  for I := 0 to 255 do
  begin
    J := (J + SBox[I] + KeyBytes[I mod KeyLen]) mod 256;
    // Swap bytes
    Temp := SBox[I];
    SBox[I] := SBox[J];
    SBox[J] := Temp;
  end;

  // 2. Encryption and decryption (Pseudo-Random Generation Algorithm - PRGA)
  I := 0;
  J := 0;
  for T := 0 to TextLen - 1 do
  begin
    I := (I + 1) mod 256;
    J := (J + SBox[I]) mod 256;

    // Swap bytes
    Temp := SBox[I];
    SBox[I] := SBox[J];
    SBox[J] := Temp;

    // XOR operation for the current character
    ResultBytes[T] := TextBytes[T] xor SBox[(SBox[I] + SBox[J]) mod 256];
  end;

  // Return binary data as a readable hex string
  for I := 0 to Length(ResultBytes) - 1 do
    Result := Result + IntToHex(ResultBytes[I], 2);
end;

// RC4 decryption
{ If an incorrect security key is entered, an error message is
  displayed in debugger mode.

  Ignore Error Message:
  "In project Project1.exe, an exception of class EEncodingError occurred
  with the message 'No mapping exists for the Unicode character in the
  target multibyte code page". }
function RC4DecryptString(const AHexText, AKey: string): string;
var
  SBox: array[0..255] of Byte;
  KeyBytes, TextBytes, ResultBytes: TBytes;
  I, J, T, KeyLen, TextLen: Integer;
  Temp: Byte;
  HexChar: string;
begin
  Result := '';
  if (AHexText = '') or (AKey = '') then Exit;

  // Convert a hex string back into a byte array
  TextLen := Length(AHexText) div 2;
  SetLength(TextBytes, TextLen);
  for I := 0 to TextLen - 1 do
  begin
    HexChar := Copy(AHexText, (I * 2) + 1, 2);
    TextBytes[I] := StrToInt('$' + HexChar);
  end;

  KeyBytes := TEncoding.UTF8.GetBytes(AKey);
  KeyLen := Length(KeyBytes);
  SetLength(ResultBytes, TextLen);

  // 1. Initializing the S-Box
  for I := 0 to 255 do
    SBox[I] := I;

  J := 0;
  for I := 0 to 255 do
  begin
    J := (J + SBox[I] + KeyBytes[I mod KeyLen]) mod 256;
    Temp := SBox[I];
    SBox[I] := SBox[J];
    SBox[J] := Temp;
  end;

  // 2. Decryption
  I := 0;
  J := 0;
  for T := 0 to TextLen - 1 do
  begin
    I := (I + 1) mod 256;
    J := (J + SBox[I]) mod 256;

    Temp := SBox[I];
    SBox[I] := SBox[J];
    SBox[J] := Temp;

    ResultBytes[T] := TextBytes[T] xor SBox[(SBox[I] + SBox[J]) mod 256];
  end;

  // Convert UTF-8 bytes back into a Delphi Unicode string
  Result := TEncoding.UTF8.GetString(ResultBytes);
end;

// 64bit encrypter
function EncodeBase64(Value: String): String;
const
 b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  pad: PChar = '====';

  function EncodeChunk(const Chunk: String): String;
  var
    W: LongWord;
    i, n: Byte;
  begin
    n := Length(Chunk); W := 0;
    { The built-in function Ord() returns the numerical position (the index)
      of an ordinal value. This works for:
      Char / AnsiChar: Returns the numeric ASCII or Unicode value
      (e.g., 'A' yields the value 65). }
    for i := 0 to n - 1 do
      W := W + Ord(Chunk[i + 1]) shl ((2 - i) * 8);
      Result := b64alphabet[(W shr 18) and $3f] +
                b64alphabet[(W shr 12) and $3f] +
                b64alphabet[(W shr 06) and $3f] +
                b64alphabet[(W shr 00) and $3f];
    if n <> 3 then
      //add padding when out len isn't 24 bits
      Result := Copy(Result, 0, n + 1) + Copy(pad, 0, 3 - n);
  end;

begin
  Result := '';
  while Length(Value) > 0 do
  begin
    Result := Result + EncodeChunk(Copy(Value, 0, 3));
    Delete(Value, 1, 3);
  end;
end;

// 64bit decrypter
function DecodeBase64(Value: String): String;
const
  b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  function DecodeChunk(const Chunk: String): String;
  var
    W: LongWord;
    i: Byte;
  begin
    W := 0; Result := '';
    for i := 1 to 4 do
      if Pos(Chunk[i], b64alphabet) <> 0 then
        W := W + Word((Pos(Chunk[i], b64alphabet) - 1)) shl ((4 - i) * 6);
    for i := 1 to 3 do
      Result := Result + Chr(W shr ((3 - i) * 8) and $ff);
  end;
begin
  Result := '';
  if Length(Value) mod 4 <> 0 then Exit;
  while Length(Value) > 0 do
  begin
    Result := Result + DecodeChunk(Copy(Value, 0, 4));
    Delete(Value, 1, 4);
  end;
end;

// unicode encoder
function Encoder(const S :WideString; Key: Word): String;
var
  i          :Integer;
  RStr       :RawByteString;
  RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);  // encoding utf-8 format
  for i := 0 to Length(RStr)-1 do
  begin
    // calculating strings
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;

  for i := 0 to Length(RStr)-1 do
  begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

// unicode decoder
function Decoder(const S: String; Key: Word): String;
var
  i, tmpKey  :Integer;
  RStr       :RawByteString;
  RStrB      :TBytes Absolute RStr;
  tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;

  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;

  try
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    // build stirngs
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  except
    Result:= '';
    Exit;
  end;

  Result:= UTF8Decode(RStr);
end;

procedure CopyTextToClipboard(const S: string);
begin
  Clipboard.AsText := S;
end;

procedure TForm1.Gradient(Col1, Col2: TColor; Bmp: TBitmap);
type
  PixArray = array [1..3] of Byte;
var
  i, big, rdiv, gdiv, bdiv, h, w: Integer;
  ts: TStringList;
  p: ^PixArray;
begin
  // calculate rgb colors
  rdiv := GetRValue(Col1) - GetRValue(Col2);
  gdiv := GetgValue(Col1) - GetgValue(Col2);
  bdiv := GetbValue(Col1) - GetbValue(Col2);

  bmp.PixelFormat := pf24Bit;

  for h := 0 to bmp.Height - 1 do
  begin
    // get vertical pixels
    p := bmp.ScanLine[h];
    // draw horizontal pixels
    for w := 0 to bmp.Width - 1 do
    begin
      // draw rgb gradient color channels
      p^[1] := GetBvalue(Col1) - Round((w / bmp.Width) * bdiv);
      p^[2] := GetGvalue(Col1) - Round((w / bmp.Width) * gdiv);
      p^[3] := GetRvalue(Col1) - Round((w / bmp.Width) * rdiv);
      Inc(p);
    end;
  end;
end;

procedure TForm1.Image10Click(Sender: TObject);
begin
  CopyTextToClipboard(Edit2.Text);
  Edit4.Text := Edit2.Text;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  if Edit8.PasswordChar = '*' then
  begin
    Edit8.PasswordChar := #0;
  end else begin
    Edit8.PasswordChar := '*';
  end;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  // copy website acc
  CopyTextToClipboard(Edit1.Text);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  // copy user acc
  CopyTextToClipboard(Edit3.Text);
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  // copy password acc
  CopyTextToClipboard(Edit4.Text);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  // copy url acc
  CopyTextToClipboard(Edit5.Text);
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
  // copy email acc
  CopyTextToClipboard(Edit6.Text);
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
  // copy comment acc
  CopyTextToClipboard(Edit7.Text);
end;

// xor Encryption function
function Encode(Source, Key: string): string;
var
  I: Integer;
  C: Byte;
begin
  Result := '';
  for I := 1 to Length(Source) do
  begin
    if Length(Key) > 0 then
      C := Byte(Key[1 + ((I - 1) mod Length(Key))]) xor Byte(Source[I])
    else
      C := Byte(Source[I]);

    Result := Result + AnsiLowerCase(IntToHex(C, 2));
  end;
end;

// xor Decryption function
function Decode(Source, Key: string): string;
var
  I: Integer;
  C: Char;
begin
  Result := '';
  for I := 0 to Length(Source) div 2 - 1 do
  begin
    C := Chr(StrToIntDef('$' + Copy(Source, (I * 2) + 1, 2), Ord(' ')));
    if Length(Key) > 0 then
      C := Chr(Byte(Key[1 + (I mod Length(Key))]) xor Byte(C));
      Result := Result + C;
  end;
end;

// fast search and select node in TreeView
function FindNodeByText(TV: TTreeView; const SearchText: string;
          CaseSensitive: Boolean): TTreeNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to TV.Items.Count - 1 do
  begin
    if CaseSensitive then
    begin
      if TV.Items[i].Text = SearchText then
      begin
        Result := TV.Items[i];
        Break;
      end;
    end
    else
    begin
      if SameText(TV.Items[i].Text, SearchText) then
      begin
        Result := TV.Items[i];
        Break;
      end;
    end;
  end;
end;

// deleting file using like ShellSpi
function DeleteFile(const AFile: string): boolean;
var
 sh: SHFileOpStruct;
begin
  // clear memory
  ZeroMemory(@sh, sizeof(sh));

  with sh do
   begin
     Wnd := Application.Handle;
     wFunc := fo_Delete;
     pFrom := PChar(AFile +#0);
     fFlags := fof_Silent or fof_NoConfirmation;
   end;

  result := SHFileOperation(sh) = 0;
end;

// Loading the files into the TreeView
procedure AddFilesToTree(ParentNode: TTreeNode; Path: string; TreeView: TTreeView);
var
  SearchRec: TSearchRec;
  Node: TTreeNode;
begin
  if FindFirst(IncludeTrailingPathDelimiter(Path) +
      // All files are being searched for here.
      '*.*', faAnyFile, SearchRec) = 0 then
  begin
    try
      repeat
        // Exclude directories
        if (SearchRec.Attr and faDirectory) = faDirectory then
        begin
          if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          begin
            Node := TreeView.Items.AddChild(ParentNode, SearchRec.Name);
            // Recursive call for subfolders
            AddFilesToTree(Node, IncludeTrailingPathDelimiter(Path) + SearchRec.Name, TreeView);
          end;
        end
        else
        begin
          // Add File
          TreeView.Items.AddChild(ParentNode, SearchRec.Name);
        end;
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
  end;
end;

// Determines the file path of the node.
function GetTreeNodePath (aNode: TTreeNode; aDiv: String): String;
begin
  if Assigned (aNode) then
    if Assigned (aNode.Parent) then
      GetTreeNodePath := GetTreeNodePath (aNode.Parent, aDiv) + aDiv + aNode.Text
    else
      GetTreeNodePath := aNode.Text
  else
    GetTreeNodePath := '';
end;

{ Calculate the password strength and visualize it using a color gradient. }
procedure TForm1.Edit2Change(Sender: TObject);
var
  bmp: TBitmap;
  count : String;
  i: Integer;
  hist: array[byte] of Integer;
begin
  // get string counts
  count := Edit2.Text;

  for i := 1 to Length(count) do begin
    inc(hist[Ord(count[i])]);
  end;

  bmp := TBitMap.Create;
  try
    bmp.Width := 114; // set non color bitmap width
    bmp.Height := 10;
    Gradient(clLime, clRed, bmp);
    // draw gradient color in image
    Image2.Width := i*4;
    Image2.Picture.Bitmap.Assign(bmp);

    // for non strings clear the image
    if Edit2.Text = '' then Image2.Picture.Graphic := nil;
  finally
    bmp.Free;
  end;

end;

procedure TForm1.Edit8Change(Sender: TObject);
var
  bmp: TBitmap;
  count : String;
  i : Integer;
  hist: array[byte] of Integer;
  Memo: TMemo;                  // dynamic memo box for encrypted strings
  acc, s : string;
  Node: TTreeNode;
  SeedKey : integer;            // UCrypt decrypter
  rc4, Key, DecryptRC: string;  // RC4 decryption
  Ci, Cj, Cn : integer;         // Cascade decryption
  Cc : Char;                    // "
  CSigns, CCharacters: String;  // "
  Vigenere : string;            // Vigenere decrypter
begin
  count := Edit8.Text;
  for i := 1 to Length(count) do begin
    inc(hist[Ord(count[i])]);
  end;

  bmp := TBitMap.Create;
  try
    bmp.Width := 324;
    bmp.Height := 10;
    Gradient(clLime, clRed, bmp);
    Image1.Width := i*12;
    Image1.Picture.Bitmap.Assign(bmp);

    if Edit8.Text = '' then Image1.Picture.Graphic := nil;
  finally
    bmp.Free;
  end;

  try
    // Determine file path
    StatusBar1.Panels[1].Text := path;
    if Edit8.Text = '' then Exit;
    if Path = '' then Exit;

    // If no path exists, abort; this is important to avoid access errors.
    if not FileExists(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path) then Exit;

    Memo:=TMemo.Create(self);     // create Memo on Form
    Memo.Visible := false;        // hide Memobox
    Memo.Width := 10;
    Memo.Height := 10;
    Memo.ScrollBars := ssBoth;    // Very important otherwise the encryption will fail.
    Memo.Parent := Form1;
    // Load the content into the memo box.
    Memo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);
    if CheckBox7.Checked = false then
    begin
      case ComboBox2.ItemIndex of
          // xor decrypt content from the account file
      0 : begin
            Memo.Text := Decode(Memo.Text, Edit8.Text);
          end;

      1 : // UCrypt decrypter by type the security key
          begin
            try
              if Edit8.Text = '' then Exit;
              SeedKey := StrToInt(Edit8.Text); // security key
              Memo.Text := Decrypt(Memo.Text,SeedKey);
            except
              on E: Exception do
                ShowMessage(E.Message);
            end;
          end;

      2 : // unicode decoder
          begin
            Memo.Text := Decoder(Memo.Text, StrToInt(Edit8.Text));
          end;

      3 : // 64bit decoder
          begin
            Memo.Text := DecodeBase64(Memo.Text);
          end;

      4 : // pdu decryption
          begin
            try
              Memo.Text:= DecodePDU7bits(Memo.Text);
            except
            end;
          end;

      5 : // ceasar decryption
          begin
            Memo.Text := CaesarDecrypt(Memo.Text, StrToInt(Edit8.Text));
          end;

      6 : // rc4 decryption
          begin
            try
              rc4 := Memo.Lines.Text;
              DecryptRC :=  RC4DecryptString(rc4, Edit8.Text);
              Memo.Lines.Text := DecryptRC;
            except
            end;
          end;

      7 : // Cascade Decryption
          begin
            for Cj := 0 to Memo.Lines.count do
            begin
                CSigns := Memo.Lines[Cj];
                if length(CSigns) > 0 then
                begin
                  CCharacters := '';
                  for Ci := 1 to  length(CSigns) do
                  begin
                    Cc := CSigns[Ci];
                    Cn := ord(Cc) + StrToInt(Edit8.Text);
                    CCharacters := CCharacters + chr(Cn);
                  end;
                Memo.Lines[Cj] := CCharacters;
                end;
            end;
          end;

      8 : // vigener decrypter
          begin
            Vigenere := DecryptVigenere(Memo.Text, Edit8.Text);
            Memo.Text := Vigenere;
          end;

      END;

      // Account Data
      Edit1.Text := Memo.Lines[0];  // website
      Edit3.Text := Memo.Lines[1];  // user
      Edit4.Text := Memo.Lines[2];  // password
      Edit5.Text := Memo.Lines[3];  // url
      Edit6.Text := Memo.Lines[4];  // email
      Edit7.Text := Memo.Lines[5];  // comment

      Memo.Lines.Clear;
    end;
  finally
    // Don't forget, this is very important, memory conflicts could occur.
    Memo.Free;
  end;
end;

procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  // UCrypt,Encoder, Ceasar keyboard layout
  if (ComboBox2.ItemIndex = 1) or (ComboBox2.ItemIndex = 2) or
     (ComboBox2.ItemIndex = 5)  then
  begin
    Edit8.MaxLength := 10;
    if not (Key in [#08, '0'..'9']) then Key := #0;
  end else begin
    Edit8.MaxLength := 0;
  end;

  // Cascade keyboard layout
  if ComboBox2.ItemIndex = 7 then
  begin
    Edit8.MaxLength := 2;
    if not (Key in [#08, '0'..'9']) then Key := #0;
  end else begin
    Edit8.MaxLength := 0;
  end;

  // Vegenere keyboard layout
  if ComboBox2.ItemIndex = 8 then
  begin
    if not (Key in ['a'..'z', 'A'..'Z', #8]) then
    begin
      Key := #0; // Block input
    end;
  end;
end;

procedure TForm1.Edit8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Cascade keyboard layout
  if ComboBox2.ItemIndex = 7 then
  begin
    if Edit8.Text = '' then Exit;
    if StrToInt(Edit8.Text) > 30 then Edit8.Text := '30';
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  NewEntry1.Click;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i : integer;
begin
  StatusBar1.SetFocus;
  Beep;
  IF MessageDlg('Do you really want to remove the account data?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
  BEGIN
    // find alll edit boxes 1-7
    for i := 1 to 7 do
      begin
        TEdit(findcomponent('Edit' + IntToStr(i))).Clear;
      end;
  END;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Search1.Click;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  Memo: TMemo;
  i, f : integer;
  s : string;
  SeedKey : integer;            // UCrypt encryption
  rc4, Key, EncryptRC: string;  // RC4 encryption
  Ci, Cj, Cn: Integer;          // Ceasar encryption
  Cc : Char;                    // "
  CSigns, CCharacters: String;  // "
  Vigenere : string;            // Vigenere encrypter
begin
  Beep;
  IF MessageDlg('Would you like to overwrite the ' + path + ' Account?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
  BEGIN
    // Create encrypted account file
    try
      Memo:=TMemo.Create(self);    // create Memo on Form
      Memo.ScrollBars := ssBoth;   // Very important otherwise the encryption will fail.
      Memo.Width := 10;
      Memo.Height := 10;
      Memo.Visible := false;       // hide memo
      Memo.Parent := Form1;        // Determine the form on which the memo should be displayed.

      // Account Data
      Memo.Lines.Add(Edit1.Text);  // website
      Memo.Lines.Add(Edit3.Text);  // user
      Memo.Lines.Add(Edit4.Text);  // password
      Memo.Lines.Add(Edit5.Text);  // url
      Memo.Lines.Add(Edit6.Text);  // email
      Memo.Lines.Add(Edit7.Text);  // comment

      case ComboBox2.ItemIndex of
      0 : // xor encryption string Data
          Memo.Text := Encode(Memo.Text, Edit8.Text);

      1 : // UCrypt encrypter
          begin
            try
                SeedKey := StrToInt(Edit8.Text); // security ley
                Memo.Text := Encrypt(Memo.Text,SeedKey);
            except
              on E: Exception do
                  ShowMessage(E.Message);
            end;
          end;

      2 : // unicode encoding
          begin
            try
              Memo.Text :=  Encoder(Memo.Text, StrToInt(Edit8.Text));
            except
            end;

          end;

      3 : // 64bit Encoding
          begin
            Memo.Text :=  EncodeBase64(Memo.Text);
          end;

      4 : // pdu hex encryption
          begin
            Memo.Text:= EncodePDU7bits(Memo.Text);
          end;

      5 : // Ceasar Encryption
          begin
            Memo.Text := CaesarEncrypt(Memo.Text, StrToInt(Edit8.Text));
          end;

      6 : // RC4 Encryption
          begin
            rc4 := Memo.Lines.Text;
            EncryptRC := RC4EncryptString(rc4, Edit8.Text);
            Memo.Text := EncryptRC;
          end;

      7 : // Cascade encryption
          begin
            for Cj := 0 to Memo.Lines.count do
            begin
              CSigns := Memo.Lines[Cj];
                if length(CSigns) > 0 then
                begin
                  CCharacters := '';
                    for Ci := 1 to  length(CSigns) do
                    begin
                      Cc := CSigns[Ci];
                      Cn := ord(Cc) - StrToInt(Edit8.Text);
                      CCharacters := CCharacters + chr(Cn);
                    end;
                  Memo.Lines[Cj] := CCharacters;
                end;
            end;
          end;

      8 : // Vigenere encrypter
          begin
            Vigenere := EncryptVigenere(Memo.Text, Edit8.Text);
            Memo.Text := Vigenere;
          end;
      END;

      // Unicode
      case ComboBox1.ItemIndex of
        0 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.Default);  // default
        1 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.UTF8);     // utf-8
        2 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.ASCII);    // ascii
        3 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.ANSI);     // ansi
        4 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.Unicode);  // utf-16 le
        5 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + path, TEncoding.BigEndianUnicode); // utf-16 be
      end;
      // Not so important, but better if it happens.
      Memo.Lines.Clear;
    finally
      // Don't forget, this is very important, memory conflicts could occur.
      Memo.Free;
    end;
  END;
end;

// password generator
procedure TForm1.Button1Click(Sender: TObject);
  var
    Result,str,str1,str2,str3,str4:String;
    PLen:Integer;
  begin
    Randomize;
    str:='';
    str1:='19283746504378192560';
    str2:='abcdefghijklmnopqastuvwxyz';
    str3:='ABCDEFGHIJKLMNOPQASTUVWXYZ';
    str4:='!@#$%^&*()_+|\=-<>.,/?''; :"][}{';
    Result:='';
    PLen:=SpinEdit1.Value;
      if (CheckBox1.Checked=True) then str:=str+str1; // only numbers
      if (CheckBox2.Checked=True) then str:=str+str2; // lower aplphabetic
      if (CheckBox3.Checked=True) then str:=str+str3; // Upper aplphabetic
      if (CheckBox4.Checked=true) then str:=str+str4; // special character
      if  (CheckBox1.Checked=False)
      and (CheckBox2.Checked=False)
      and (CheckBox3.Checked=False)
      and (CheckBox4.Checked=False)
      then
        MessageDlg('You must select a category to generate a password.!',mtInformation,[mbOK],0)
      else
        repeat
          Result:= Result+str[Random(Length(str))+1];
        until (Length(Result)=PLen);
          Edit2.Text:=Result;
   StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked = false then
  begin
    // make account data visible
    Edit1.PasswordChar := #0;
    Edit3.PasswordChar := #0;
    Edit4.PasswordChar := #0;
    Edit5.PasswordChar := #0;
    Edit6.PasswordChar := #0;
    Edit7.PasswordChar := #0;
  end else begin
    // hide the account data
    Edit1.PasswordChar := '*';
    Edit3.PasswordChar := '*';
    Edit4.PasswordChar := '*';
    Edit5.PasswordChar := '*';
    Edit6.PasswordChar := '*';
    Edit7.PasswordChar := '*';
  end;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  // For editing the secret key without changing the account data.
  if CheckBox7.Checked = true then
  begin
    Edit1.Enabled := false;
    Edit3.Enabled := false;
    Edit4.Enabled := false;
    Edit5.Enabled := false;
    Edit6.Enabled := false;
    Edit7.Enabled := false;
    Edit8.Font.Color := clNavy;
    BitBtn1.Enabled := false;
    BitBtn2.Enabled := false;
    BitBtn3.Enabled := false;
    NewEntry1.Enabled := false;
    Search1.Enabled := false;
    Delete1.Enabled := false;
    Rename1.Enabled := false;
  end else begin
    Edit1.Enabled := true;
    Edit3.Enabled := true;
    Edit4.Enabled := true;
    Edit5.Enabled := true;
    Edit6.Enabled := true;
    Edit7.Enabled := true;
    Edit8.Font.Color := clMaroon;
    BitBtn1.Enabled := true;
    BitBtn2.Enabled := true;
    BitBtn3.Enabled := true;
    NewEntry1.Enabled := true;
    Search1.Enabled := true;
    Delete1.Enabled := true;
    Rename1.Enabled := true;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  CurrentTree: TTreeView;
begin
  Edit8.Clear;
  Edit8.Enabled := true;
  CheckBox7.Enabled := true;
  {$R-}
  case ComboBox2.ItemIndex of
    0 : Label13.Caption := 'Unlimited ASCii Chars';         // xor
    1 : Label13.Caption := 'Only 10 Numbers';               // ucrypt
    2 : Label13.Caption := 'Only 10 Numbers';               // encoder
    3 : begin
          Label13.Caption := 'Not required';                // 64bit
          Edit8.Text := 'No password';
          Edit8.Enabled := false;
          Image1.Picture.Graphic := nil;
          CheckBox7.Enabled := false;
        end;
    4 : begin
          Label13.Caption := 'Not required';                // pdu
          Edit8.Text := 'No password';
          Edit8.Enabled := false;
          Image1.Picture.Graphic := nil;
          CheckBox7.Enabled := false;
        end;

    5 : Label13.Caption := 'Only 10 Numbers';               // ceasar

    6 : Label13.Caption := 'Unlimited ASCii Chars';         // rc4

    7 : begin
          Label13.Caption := 'Max numerical value 30';      // cascade
        end;

    8 : begin
          Label13.Caption := 'Letters only';                // vigenere
        end;
  end;

   // Cast Sender to TTreeView to access its properties
  if Sender is TTreeView then
  begin
    CurrentTree := TTreeView(Sender);
  end;
  StatusBar1.SetFocus;
end;

// delete account
procedure TForm1.Delete1Click(Sender: TObject);
var
  Node : TTreeNode;
begin
  if TreeView1.Items.Count = 0 then Exit;

  Beep;
  IF MessageDlg('ATTENTION!'+#13+
                'You delete the account file: "' + path + '" are you sure?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
    BEGIN
      try
        // removes the existing file
        DeleteFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);
        // Determines the selected node.
        Node := TreeView1.Selected;
        // Removes the node from the TreeView.
        TreeView1.Items.Delete(Node);
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    END;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  { so that the dynamic memo box does not flash when encrypting or decrypting
    It is created in the top-left corner and subsequently removed. }
  DoubleBuffered := true;

  // fill acc nodes in TreeView
  AddFilesToTree(nil, ExtractFilePath(Application.ExeName) +
                            'Data\Acc\', TreeView1);

  // count the account entrys
  StatusBar1.Panels[3].Text := IntToStr(TreeView1.Items.Count);

  // set hint show time to 50sec
  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  CheckBox7.Hint := 'Here you can set the password for a loaded account.';

  // hide security key
  Edit8.PasswordChar := '*';
  // This must happen to demonstrate the strength of the password.
  Edit8.OnChange(sender);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
  path := '';   // treeview main account paths
  StatusBar1.SetFocus;

  // set window topmost when starting the program
  //SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
    //         SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TForm1.NewEntry1Click(Sender: TObject);
var
  Node: TTreeNode;
  web : string;   // new entry name
  i : integer;
begin
  // Find the account edit boxes on the form (1-7) and clear content
  for i := 1 to 7 do
    begin
      TEdit(findcomponent('Edit' + IntToStr(i))).Clear;
    end;

  try
    // new account file name
    web := InputBox('New Entry', 'Website :', web);
    if web = '' then Exit;
    // create item entry new account in treeview
    TreeView1.Items.Add(nil, PChar(web));
    // Create the file and release it.
    FileClose(FileCreate(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + web));

    // sort nodes alphabetic
    TreeView1.AlphaSort;
    // remove entrie name from memory
    web := '';
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

// rename account file
procedure TForm1.Rename1Click(Sender: TObject);
var
  s : string;
  Memo: TMemo;
begin
  if TreeView1.Selected <> nil then
  begin
    // type new name for acoount file
    s := InputBox('Input Box', 'Prompt', path);
    try
      // rename the file
      if not RenameFile(ExtractFilePath(Application.ExeName) +
                        'Data\Acc\' + path,ExtractFilePath(Application.ExeName) +
                        'Data\Acc\' + s) then Exit;
      if TreeView1.Selected <> nil then
        TreeView1.Selected.Text := s;
    except
       on E: Exception do
          ShowMessage(E.Message);
    end;

    // update treeview
    // It's not always important, but it's better if it's done.
    TreeView1.Refresh;
    TreeView1.Update;
  end;
end;

// Searching for an entry in the TreeView
procedure TForm1.Search1Click(Sender: TObject);
var
  FoundNode: TTreeNode;
  acc : string;
begin
  // no entry go out
  if TreeView1.Items.Count = 0 then Exit;

  // Implementation of a box for the search string
  acc := InputBox('Search Account', 'Type :', acc);

  // search for the string
  FoundNode := FindNodeByText(TreeView1, acc, False);
  if Assigned(FoundNode) then
  begin
    TreeView1.Selected := FoundNode;

    // select founded string and make him bold
    FoundNode.MakeVisible;
    TreeView1.SetFocus;
  end;

  if not Assigned(FoundNode) then
  begin
    Beep;
    MessageDlg('Account Name was not found in the list!',mtWarning, [mbOK], 0);
  end;
end;

// Account file selection
procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  Memo: TMemo;
  acc, s : string;
  i : integer;
  
begin
  // Determine file path
  path := GetTreeNodePath (Node, '/');
  StatusBar1.Panels[1].Text := path;
  CheckBox7.Enabled := true;

  if Edit8.Text = '' then Exit;

  try
    // If no path exists, abort; this is important to avoid access errors.
    if not FileExists(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path) then Exit;

    Memo:= TMemo.Create(self);    // create Memo on Form
    Memo.ScrollBars := ssBoth;    // Very important otherwise the encryption will fail.
    Memo.Width := 10;
    Memo.Height := 10;
    Memo.Visible := false;        // hide the memo box
    Memo.Parent := Form1;         // create memo in top left corner on form
    Edit8.Clear;                  // user mzst type the security key

    // Load the content into the memo box.
    Memo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);

    if CheckBox7.Checked = false then
    begin
      case ComboBox2.ItemIndex of
      3 : // 64bit decrypt without password
          begin
            CheckBox7.Enabled := false;
            Memo.Text := DecodeBase64(Memo.Text);
          end;

      4 : // pdu decoder without password
          begin
          CheckBox7.Enabled := false;
            try
              Memo.Text:= DecodePDU7bits(Memo.Text);
            except
            end;
          end;
      END;

      // Account Data
      Edit1.Text := Memo.Lines[0];  // website
      Edit3.Text := Memo.Lines[1];  // user
      Edit4.Text := Memo.Lines[2];  // password
      Edit5.Text := Memo.Lines[3];  // url
      Edit6.Text := Memo.Lines[4];  // email
      Edit7.Text := Memo.Lines[5];  // comment

      Memo.Lines.Clear;
    end;
  finally
    // Don't forget, this is very important, memory conflicts could occur.
    Memo.Free;
  end;
end;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if Node = Sender.Selected then
    with Sender.Canvas do
    begin
      Font.Color := clNavy;
      Font.Style := [fsBold];
    end;
  DefaultDraw := True;
end;

end.


