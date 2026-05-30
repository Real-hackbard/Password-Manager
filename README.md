# Password-Manager

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/2e297e3d-5e01-46ee-9924-60a8930ff3da" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) <img src="https://github.com/user-attachments/assets/6263345f-a588-47a9-9206-3759819893b4" />  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

Password managers emerged to address the problem that users require secure passwords both for their own systems and for numerous user accounts across various online services. Using identical usernames and passwords for different services poses a significant security risk, as a single stolen password would grant access to all of those services. Consequently, a multitude of distinct passwords is required. Secure passwords are lengthy and consist of combinations of letters, numbers, and special characters that are difficult to memorize (see "Choosing Secure Passwords"). Password managers enable users to safeguard a large number of distinct and secure passwords against unauthorized access while still allowing for their convenient use.

In my opinion, a password manager does not need to be versatile or visually appealing, but rather practical and secure. The more practical and simple a program is designed, the more commonly it is used in everyday life.

</br>

<img src="https://github.com/user-attachments/assets/eb8f1b16-7573-49fd-8d1c-8193534ebd44" />

</br></br>

Data encryption does not take place in main memory, but rather on a dynamically recreated memo component, ensuring that external programs cannot intercept the operations occurring in memory.

# [XOR](https://en.wikipedia.org/wiki/XOR_cipher) Encryption
Encryption is performed at two locations here. If custom encryption methods are to be used, the calls at these encryption points must be modified accordingly.  

The XOR operator is extremely common as a component in more complex ciphers. By itself, using a constant repeating key, a simple XOR cipher can trivially be broken using [frequency analysis](https://en.wikipedia.org/wiki/Frequency_analysis). If the content of any message can be guessed or otherwise known then the key can be revealed. Its primary merit is that it is simple to implement, and that the XOR operation is computationally inexpensive. A simple repeating XOR (i.e. using the same key for xor operation on the whole data) cipher is therefore sometimes used for hiding information in cases where no particular security is required. The XOR cipher is often used in computer malware to make reverse engineering more difficult.

</br>

```pascal
  { encryption string Data }
  Memo.Text := Encode(Memo.Text, Edit8.Text);
```

</br>

Decryption also takes place at two points: when clicking on the ```TreeView```, or when entering the security key.

</br>

```pascal
  // decrypt content from the account file
  Memo.Text := Decode(Memo.Text, Edit8.Text);
```

</br>

```pascal
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
```

</br>

This encryption allows for a security key that can be of any length and utilizes the entire [ASCII character set](https://en.wikipedia.org/wiki/ASCII), including special characters.

</br>

# History
The first password manager software designed to securely store passwords was [Password Safe](https://en.wikipedia.org/wiki/Password_Safe) created by [Bruce Schneier](https://en.wikipedia.org/wiki/Bruce_Schneier), which was released as a free utility on September 5, 1997. Designed for Microsoft Windows 95, Password Safe used Schneier's [Blowfish algorithm](https://en.wikipedia.org/wiki/Blowfish_(cipher)) to encrypt passwords and other sensitive data. Although Password Safe was released as a free utility, due to [export restrictions on cryptography from the United States](https://en.wikipedia.org/wiki/Export_of_cryptography_from_the_United_States), only U.S. and Canadian citizens and permanent residents were initially allowed to download it.

As of October 2024, the built-in Google Password Manager in [Google Chrome](https://passwords.google.com/intro) has become the most used password manager.

List of password managers:
https://en.wikipedia.org/wiki/List_of_password_managers

</br>

# Password Generator
A random password generator is a software program or hardware device that takes input from a random or [pseudo-random](https://en.wikipedia.org/wiki/Pseudorandomness) number generator and automatically generates a password.

</br>

```pascal
// Example Code
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
```
