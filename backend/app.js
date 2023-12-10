require('dotenv').config();
let express = require('express');
let path = require('path');
let cookieParser = require('cookie-parser');
let logger = require('morgan');
const { databaseConnect } = require('./database/connectedDatabase');

let indexRouter = require('./routes/index');
let usersRouter = require('./routes/users');
let productsRouter = require('./routes/products');
let registerRouter = require('./routes/register');
let loginRouter = require('./routes/login');
let forgotPasswordRouter = require('./routes/forgotPassword');
let resetPasswordRouter = require('./routes/resetPassword');
let userDataRouter = require('./routes/userData');
let app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

databaseConnect();

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/products', productsRouter);
app.use('/register', registerRouter);
app.use('/login', loginRouter);
app.use('/forgot-password', forgotPasswordRouter);
app.use('/reset-password', resetPasswordRouter);
app.use('/data-user', userDataRouter);

console.log(`Server is running http://localhost:3000`);

module.exports = app;
