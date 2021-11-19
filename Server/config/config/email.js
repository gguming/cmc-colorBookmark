const nodemailer = require('nodemailer');

const smtpTransport = nodemailer.createTransport({
    service: "Naver",
    auth: {
        user: "kimkm95@naver.com",
        pass: "Rlarudals12!"
    },
    tls: {
        rejectUnauthorized: false
    }
});

module.exports={
    smtpTransport
}