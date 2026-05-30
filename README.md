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

#  Encryption
Nine encryption methods are available, featuring various algorithms both password-protected and unprotected.
With this feature, the security key for existing account entries can also be edited something that was not possible with the old version.

</br>

| Encryption | Security | Bitsize | Description |
| :----------- | :------------ | :----------- | :----------- |
| ```XOR```     | yes    | 8-256     | [XOR encryption](https://en.wikipedia.org/wiki/XOR_cipher) is a symmetric algorithm that combines plaintext with a secret key using the bitwise XOR (exclusive OR) operation. |
| ```UEncrypt```     | yes     | 64     | Transforms plain text into unreadable ciphertext using cryptographic algorithms and keys. |
| ```Encoder```     | yes     | 1-32     | [Unicode](https://en.wikipedia.org/wiki/Unicode) itself is a 21-bit character set capable of representing over 1.1 million characters. ```UTF-8``` Variable-length (1 to 4 bytes or 8 to 32 bits), ```UTF-16``` Variable-length (2 or 4 bytes or 16 to 32 bits) |
| ```Base64```     | no     | 6     | [Base64](https://en.wikipedia.org/wiki/Base64) is a binary-to-text encoding that uses 64 printable characters to represent each 6-bit segment of a sequence of byte values- |
| ```PDU```     | no     | 7     | [Hexadecimal](https://en.wikipedia.org/wiki/Hexadecimal) (hex for short) is a positional numeral system for representing a numeric value as base 16.     |
| ```Cascade```     | yes     | 128     | A cipher cascade (or cascade encryption) involves running data through multiple different encryption algorithms in a sequence, usually applying distinct, independent keys for each layer.     |
| ```RC4```     | yes     | 40-128     | The [RC4](https://en.wikipedia.org/wiki/RC4) stream cipher supports a variable key size ranging from 40 to 2048 bits. In practice, it was most commonly implemented with 40-bit (early export restrictions) or 128-bit (standard) keys.     |
| ```Ceasar```     | yes     | 128/256     | The [Caesar cipher](https://en.wikipedia.org/wiki/Caesar_cipher) does not have a traditional bit size (like modern 128-bit or 256-bit encryption algorithms) because it relies on character shifts rather than binary keys.     |
| ```Vigenere```     | yes     | n/a     | The classical [Vigenère cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher) does not have a fixed "bit size" in the way modern computer encryption algorithms (like AES or RSA do). Instead, it is a polyalphabetic substitution cipher operating on character sets (usually the 26-letter English alphabet).     |

</br>

Modern ciphers are more secure than classical ciphers and are designed to withstand a wide range of attacks. An attacker should not be able to find the key used in a modern cipher, even if they know any specifics about the plaintext and its corresponding ciphertext.

</br>

# RC4 Decryption problem
If the RC4 encryption method is used, an ```EEncodingError``` is raised in debugger mode when entering the security key; this error can be ignored.

Message:
```
"In project Project1.exe, an exception of class EEncodingError occurred
  with the message 'No mapping exists for the Unicode character in the
  target multibyte code page"
````

The Delphi [EEncodingError exception](https://docwiki.embarcadero.com/Libraries/Sydney/en/System.SysUtils.EEncodingError) (typically raised as "No mapping for the Unicode character exists in the target multi-byte code page") occurs when you try to convert a modern Unicode string into an older, restricted encoding (like ANSI or ASCII) that doesn't support the specific character you are using.

The exception error is triggered in this part of the code, but it is irrelevant, as the text to be decrypted resides in a dynamic component that is discarded immediately after encryption.

</br>

```pascal
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
```

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
