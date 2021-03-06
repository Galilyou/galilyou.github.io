---
layout: post
comments: true
permalink: "/blog/machine-key-asp-scalability"
title: Scalability Tip In ASP.NET And The MachineKey Element
date: '2010-01-06T10:27:00.000+02:00'
author: Galilyou
tags:
modified_time: '2010-01-06T10:38:56.367+02:00'
---

Yesterday, I came a cross a pretty annoying problem with a web application I'm working on nowadays.
In short, the app is an ASP.NET MVC 1 app, that uses forms authentications to handle users logins.
The app was working just fine, but when I started to scale the app and deploy it to more servers in the server farm, the weired behavior started to show up. When a user logs in to the application, the application preforms the operation successfully, logs in the user to the system and takes him to his personalized page. That sounds normal, however, if the user navigated to another part of the application (or just refreshes the current page), the application no longer recognizes him as a logged in user! If he refreshes two or three times, the app will see him as a logged in user again, a few more refreshes and he's nor more logged in and so on.

#### Similar Problem

I encountered  a similar problem before, but the other one was because of accidental session expiration, and this happened because I was saving SessionState InProc, which (as you may have guessed) will be stored on the server memory (i.e. will not be shared between all server in the web farm).

#### This Problem

This problem is different because I'm not using SessionState at all. I'm just using cookies and you know that cookies are stored on the client, and is sent to the server with every request, so it will be sent to all servers (i.e. all servers should be able to read the cookie and determine if the user is logged in or not).

#### How Cookies Are Written
This got me thinking, the problem must be with the cookie itself. It seems like some servers can read the cookie successfully, and some can't. Why would that be?!!

#### Different Encryption/Decryption Key/Algorithm
Aha .... Cookies are encrypted before they are written on the client and decrypted before they are read again by the server. When the server that served the login request wrote the cookie, it encrypted it first (using an AutoGenerated encryption key and its chosen encryption algorithm. So apparently the chosen encryption keys and/or algorithms are different across the severs!

#### The Solution
The solution is quite simple actually. All I need to do is to ensure that all the servers use the same encryption algorithms and keys.
This can be done by explicitly specifying the keys and algorithms in web.config inside the ```<machineKey>``` tag.

It should look something like this:

 ```
< machinekey decryption="AES" decryptionkey="C9D61286123285F6FA496CFA190FC219BEF44A0943705404CF023C15A1FFFE02" validation="SHA1" validationkey="4B04D08CAA210ABF91B5E6E86763E0EEA4044284B4C962B4E51227868DF44D1D6D20F7309FBA3CE323404FA0FC39E6C8C6CE9FB842C9481B9938EB268AF5F85D">
>
```

PS: The keys lengths depend on the algorithms selected

1. For SHA1, set the  **validationKey** to 64 bytes (128 hexadecimal characters).
1. For AES, set the  **decryptionKey** to 32 bytes (64 hexadecimal characters).
1. For 3DES, set the  **decryptionKey** to 24 bytes (48 hexadecimal characters).

The keys can be generated whatever way you like. Here's a simple function for generating these keys:

```csharp
static string GenerateKey(int requiredLength)
{
    byte[] buffer = new byte[requiredLength / 2];
    RNGCryptoServiceProvider rng = new
                            RNGCryptoServiceProvider();
    rng.GetBytes(buffer);
    StringBuilder sb = new StringBuilder(requiredLength);
    foreach (byte t in buffer)
        sb.Append(string.Format("{0:X2}", t));
    return sb.ToString();
}
```


 For more information about the ```<machinekey>``` tag see <a href="http://msdn.microsoft.com/en-us/library/w8h3skw9.aspx">here</a>, and <a href="http://msdn.microsoft.com/en-us/library/ms998288.aspx#paght000007_webfarmdeploymentconsiderations">here </a>to how to configure it, and if you wanna scroll a full page see <a href="http://msdn.microsoft.com/en-us/library/ms998288.aspx#paght000007_webfarmdeploymentconsiderations">this</a> for recommendations about deploying to server farms.

Hope this helps.

