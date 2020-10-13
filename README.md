# jwtpubsigner
This little script signs JWT token (header+payload) using server public key and HMAC 256/512 alg. Useful for RS -> HS JWT attacks.
A little note: header and payload must be already base64url-encoded.

**Usage: ./jwtpubsigner.sh [example.com] [header.payload]**
![alt text](https://downloader.disk.yandex.ru/preview/713b0f6bf50a3791e5a23fbb546a26d9fabfee9b9b4437f6233a43d4e025ccf7/5f85b061/Jb9isi8SkQEja0n30iLPAup6ZkYSFUZLnaQ37S1ia1z3ADRgjJgElyb01dWH7LiU7L3oHKOOPXKIPjKMGLYI5w==?uid=0&filename=Screenshot+2020-10-13+124834.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=61982139&size=2560x1262)
