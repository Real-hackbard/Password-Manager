unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls,  System.ImageList, Vcl.ImgList,
  IniFiles, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Menus, WinApi.ShellAPI, Vcl.Clipbrd;

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
  private
    { Private declarations }
    procedure Gradient(Col1, Col2: TColor; Bmp: TBitmap);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  path : string;

implementation

{$R *.dfm}

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
  rdiv := GetRValue(Col1) - GetRValue(Col2);
  gdiv := GetgValue(Col1) - GetgValue(Col2);
  bdiv := GetbValue(Col1) - GetbValue(Col2);

  bmp.PixelFormat := pf24Bit;

  for h := 0 to bmp.Height - 1 do
  begin
    p := bmp.ScanLine[h];
    for w := 0 to bmp.Width - 1 do
    begin
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
  CopyTextToClipboard(Edit1.Text);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  CopyTextToClipboard(Edit3.Text);
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  CopyTextToClipboard(Edit4.Text);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  CopyTextToClipboard(Edit5.Text);
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
  CopyTextToClipboard(Edit6.Text);
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
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

procedure TForm1.Edit2Change(Sender: TObject);
var
  bmp: TBitmap;
  count : String;
  i: Integer;
  hist: array[byte] of Integer;
begin
  count := Edit2.Text;
  for i := 1 to Length(count) do begin
    inc(hist[Ord(count[i])]);
  end;

  bmp := TBitMap.Create;
  try
    bmp.Width := 114;
    bmp.Height := 10;
    Gradient(clLime, clRed, bmp);
    Image2.Width := i*4;
    Image2.Picture.Bitmap.Assign(bmp);

    if Edit2.Text = '' then Image2.Picture.Graphic := nil;
  finally
    bmp.Free;
  end;

end;

procedure TForm1.Edit8Change(Sender: TObject);
var
  bmp: TBitmap;
  count : String;
  i: Integer;
  hist: array[byte] of Integer;

  Memo: TMemo;
  acc, s : string;
  Node: TTreeNode;
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
    //path := GetTreeNodePath (Node, '/');

    // If no path exists, abort; this is important to avoid access errors.
    if not FileExists(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path) then Exit;

    Memo:=TMemo.Create(self);     // create Memo on Form
    Memo.Visible := false;
    Memo.ScrollBars := ssBoth;    // Very important otherwise the encryption will fail.
    Memo.Parent := Form1;
    // Load the content into the memo box.
    Memo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);

    // decrypt content from the account file
    Memo.Text := Decode(Memo.Text, Edit8.Text);

    // Account Data
    Edit1.Text := Memo.Lines[0];  // website
    Edit3.Text := Memo.Lines[1];  // user
    Edit4.Text := Memo.Lines[2];  // password
    Edit5.Text := Memo.Lines[3];  // url
    Edit6.Text := Memo.Lines[4];  // email
    Edit7.Text := Memo.Lines[5];  // comment

    Memo.Lines.Clear;
  finally
    // Don't forget, this is very important, memory conflicts could occur.
    Memo.Free;
    StatusBar1.Panels[1].Text := path;
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
begin
  Beep;
  IF MessageDlg('Would you like to overwrite the ' + path + ' Account?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
  BEGIN
    // Create encrypted account file
    try
      Memo:=TMemo.Create(self);    // create Memo on Form
      Memo.ScrollBars := ssBoth;   // Very important otherwise the encryption will fail.
      Memo.Visible := false;
      Memo.Parent := Form1;

      // Account Data
      Memo.Lines.Add(Edit1.Text);  // website
      Memo.Lines.Add(Edit3.Text);  // user
      Memo.Lines.Add(Edit4.Text);  // password
      Memo.Lines.Add(Edit5.Text);  // url
      Memo.Lines.Add(Edit6.Text);  // email
      Memo.Lines.Add(Edit7.Text);  // comment

      // encryption string Data
      Memo.Text := Encode(Memo.Text, Edit8.Text);


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
      if (CheckBox1.Checked=True) then str:=str+str1;
      if (CheckBox2.Checked=True) then str:=str+str2;
      if (CheckBox3.Checked=True) then str:=str+str3;
      if (CheckBox4.Checked=true) then str:=str+str4;
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
    Edit1.PasswordChar := #0;
    Edit3.PasswordChar := #0;
    Edit4.PasswordChar := #0;
    Edit5.PasswordChar := #0;
    Edit6.PasswordChar := #0;
    Edit7.PasswordChar := #0;
  end else begin
    Edit1.PasswordChar := '*';
    Edit3.PasswordChar := '*';
    Edit4.PasswordChar := '*';
    Edit5.PasswordChar := '*';
    Edit6.PasswordChar := '*';
    Edit7.PasswordChar := '*';
  end;
end;

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  // fill acc nodes in TreeView
  AddFilesToTree(nil, ExtractFilePath(Application.ExeName) +
                            'Data\Acc\', TreeView1);
  StatusBar1.Panels[3].Text := IntToStr(TreeView1.Items.Count);
  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  Edit8.PasswordChar := '*';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Edit8.OnChange(sender);

  // set window topmost
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TForm1.NewEntry1Click(Sender: TObject);
var
  Node: TTreeNode;
  web : string;
  i : integer;
begin
  // find alll edit boxes 1-7
  for i := 1 to 7 do
    begin
      TEdit(findcomponent('Edit' + IntToStr(i))).Clear;
    end;

  try
    web := InputBox('New Entry', 'Website :', web);
    if web = '' then Exit;
    TreeView1.Items.Add(nil, PChar(web));
    FileClose(FileCreate(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + web));

    // sort nodes alphabetic
    TreeView1.AlphaSort;
    web := '';
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

// // rename account file
procedure TForm1.Rename1Click(Sender: TObject);
var
  s : string;
  Memo: TMemo;
begin
  if TreeView1.Selected <> nil then
  begin
    s := InputBox('Input Box', 'Prompt', path);
    try
      TreeView1.Selected.Text := s;  // Determines the selected node text.
      Memo:=TMemo.Create(self);    // create Memo on Form
      Memo.ScrollBars := ssBoth;   // Very important otherwise the encryption will fail.
      Memo.Visible := false;
      Memo.Parent := Form1;
      Memo.Lines.Add(Edit1.Text);  // website
      Memo.Lines.Add(Edit3.Text);  // user
      Memo.Lines.Add(Edit4.Text);  // password
      Memo.Lines.Add(Edit5.Text);  // url
      Memo.Lines.Add(Edit6.Text);  // email
      Memo.Lines.Add(Edit7.Text);  // comment
      Memo.Text := Encode(Memo.Text, Edit8.Text);

      // Delete the old file from the folder.
      DeleteFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);

      // Create and release the file
      FileClose(FileCreate(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + s));
      Sleep(25);

      // unicode
      case ComboBox1.ItemIndex of
        0 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.Default);  // utf-8
        1 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.UTF8);     // utf-9 boom
        2 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.ASCII);    // ascii
        3 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.ANSI);     // ansi
        4 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.Unicode);  // utf-16 le
        5 : Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                                'Data\Acc\' + s, TEncoding.BigEndianUnicode);  // utf-16 be
      end;

      // Sort the TreeView tree alphabetically.
      TreeView1.AlphaSort;

      // Remove the memo from the form and memory.
      Memo.Free;

    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  end;
end;

// Searching for an entry in the TreeView
procedure TForm1.Search1Click(Sender: TObject);
var
  FoundNode: TTreeNode;
  acc : string;
begin
  if TreeView1.Items.Count = 0 then Exit;

  // Implementation of a box for the search string
  acc := InputBox('Search Account', 'Type :', acc);

  // search for the string
  FoundNode := FindNodeByText(TreeView1, acc, False);
  if Assigned(FoundNode) then
  begin
    TreeView1.Selected := FoundNode;

    // select founded string
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
  try
    // Determine file path
    path := GetTreeNodePath (Node, '/');

    // If no path exists, abort; this is important to avoid access errors.
    if not FileExists(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path) then Exit;

    Memo:=TMemo.Create(self);     // create Memo on Form
    Memo.ScrollBars := ssBoth;    // Very important otherwise the encryption will fail.
    Memo.Visible := false;
    Memo.Parent := Form1;
    // Load the content into the memo box.
    Memo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'Data\Acc\' + path);

    // decrypt content from the account file
    Memo.Text := Decode(Memo.Text, Edit8.Text);

    // Account Data
    Edit1.Text := Memo.Lines[0];  // website
    Edit3.Text := Memo.Lines[1];  // user
    Edit4.Text := Memo.Lines[2];  // password
    Edit5.Text := Memo.Lines[3];  // url
    Edit6.Text := Memo.Lines[4];  // email
    Edit7.Text := Memo.Lines[5];  // comment

    Memo.Lines.Clear;
  finally
    // Don't forget, this is very important, memory conflicts could occur.
    Memo.Free;
    StatusBar1.Panels[1].Text := path;
  end;

end;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if Node = Sender.Selected then
    with Sender.Canvas do
    begin
      Font.Color := clNavy;
      //Font.Style := [fsUnderline];
      Font.Style := [fsBold];
    end;
  DefaultDraw := True;
end;

end.


