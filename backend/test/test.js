const request = require('supertest');
const app = require('../app');

describe('API Tests', () => {
  // Test the registration route
  it('should register a new user', async () => {
    const res = await request(app).post('/api/register').send({
      email: 'test@example.com',
      username: 'testuser',
      password: 'testpassword',
      phone: '123456789',
      name: 'Test User',
    });

    expect(res.statusCode).toBe(201);
    expect(res.body.message).toBe('User registered successfully');
  });

  // Test the login route
  it('should login a user', async () => {
    const res = await request(app).post('/api/login').send({
      username: 'testuser',
      password: 'testpassword',
    });

    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe('Login successful');
  });
});
