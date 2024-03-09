require('dotenv').config();
let express = require('express');
let path = require('path');
let cookieParser = require('cookie-parser');
let logger = require('morgan');
const { databaseConnect } = require('./database/connectedDatabase');

let indexRouter = require('./routes/index');
let usersRouter = require('./routes/users');
let productsRouter = require('./routes/products');
let registerRouter = require('./routes/login_and_register/register');
let loginRouter = require('./routes/login_and_register/login');
let forgotPasswordRouter = require('./routes/login_and_register/forgotPassword');
let resetPasswordRouter = require('./routes/login_and_register/resetPassword');
let userDataRouter = require('./routes/login_and_register/userData');
let app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

databaseConnect();

// app.use('/', indexRouter);
// app.use('/users', usersRouter);
app.use('/products', productsRouter);
app.use('/api/register', registerRouter);
app.use('/api/login', loginRouter);
app.use('/api/forgot-password', forgotPasswordRouter);
app.use('/api/reset-password', resetPasswordRouter);
app.use('/api/data-user', userDataRouter);

console.log(`Server is running http://localhost:3000`);

module.exports = app;
