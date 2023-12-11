
# BACKEND PROJECT UKM PROGRAMMING 2023

Kami menggunakan backendnya yaitu ExpressJS yang bertujuan untuk membuat RESTFUL API yang akan dikirimkan ke tim **ANDROID**.

## Install
- [NodeJS](https://nodejs.org/en)
- [MySQL](https://www.mysql.com/)



## REST API

#### Login dan Register

| Parameter | Method     | Description                |
| :-------- | :------- | :------------------------- |
| `/api/register` | `POST` | Registrasi akun terdiri dari (email, username, password, phone, name) |
| `/api/login` | `POST` | Login akun tediri dari (username, password)|
| `/api/forgot-password` | `POST` | Ingin untuk mengganti password terdiri dari (email) dan terdapat token yang harus didapati |
| `/api/reset-password` | `POST` | Masukkan token yand didapati dari `/api/forgot-password` dan masukkan terdiri dari (email, token, newPassword) |
| `/api/data-user` | `GET` | Menampilkan semua data user |
| `/api/data-user/:userId` | `GET` | Menampilkan semua data user berdasarkan id |
| `/api/data-user/:userId` | `DELETE` | Menghapus data user berdasarkan id |
| `/api/data-user/:userId` | `PATCH` | Mengupdate salah satu / beberapa data user yang terdiri dari (email, username, phone, name, confirmPasswod) berdasarkan id |

## Documentation

- [NodeJS](https://nodejs.org/en)
- [ExpressJS](https://expressjs.com/)


## Run Locally

Install dependencies

```bash
  npm install
```

Start the server

```bash
  npm start
```


## Authors

- [William Tanuwijaya](https://www.github.com/williamtanuwijaya)