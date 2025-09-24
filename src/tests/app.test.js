const request = require('supertest');
const app = require('../app'); // your Express app

describe('Hello Route', () => {

  it('should return 200 OK', async () => {
    const res = await request(app).get('/hello');
    expect(res.statusCode).toBe(200);
  });

  it('should return Hello World message', async () => {
    const res = await request(app).get('/hello');
    expect(res.text).toBe('Hello, World!');
  });

  it('should return 404 for unknown routes', async () => {
    const res = await request(app).get('/unknown');
    expect(res.statusCode).toBe(404);
  });

});


