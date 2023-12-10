const nodemailer = require('nodemailer');
function sendResetEmail(email, token) {
  // Configure nodemailer to send email (replace with your email service details)
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'your_email@gmail.com',
      pass: 'your_email_password',
    },
  });

  // Compose email message
  const mailOptions = {
    from: 'your_email@gmail.com',
    to: email,
    subject: 'Password Reset',
    text: `To reset your password, click on the following link: http://localhost:3000/reset-password?email=${email}&token=${token}`,
  };

  // Send email
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error('Error sending email:', error);
    } else {
      console.log('Email sent:', info.response);
    }
  });
}

module.exports = { sendResetEmail };
