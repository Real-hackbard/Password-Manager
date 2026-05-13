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

<img src="https://github.com/user-attachments/assets/98537a6f-6cc0-4788-b9d9-89da8c1b2d05" />

</br></br>

Data encryption does not take place in main memory, but rather on a dynamically recreated memo component, ensuring that external programs cannot intercept the operations occurring in memory.

# Encryption
Encryption is performed at two locations here. If custom encryption methods are to be used, the calls at these encryption points must be modified accordingly.  

```pascal
  { encryption string Data }
  Memo.Text := Encode(Memo.Text, Edit8.Text);
```




