const request = require('supertest');
const app = require('../app'); // your Express app instance

describe('Contact API', () => {
  let contactId;

  it('should create a new contact', async () => {
    const response = await request(app)
      .post('/contact/createcontact')
      .send({
        Fullname: 'John Doe',
        Email: 'johndoe@example.com',
        Address: '123 Main St',
        Description: 'A new contact',
      })
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.data).toHaveProperty('_id');
    contactId = response.body.data._id;
  });

  it('should get all contacts', async () => {
    const response = await request(app)
      .get('/contact')
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.data.length).toBeGreaterThan(0);
  });

  it('should update a contact', async () => {
    const response = await request(app)
      .put(`/contact/${contactId}`)
      .send({
        Fullname: 'Jane Doe',
      })
      .expect(200);

    expect(response.body.Fullname).toBe('Jane Doe');
  });

  it('should delete a contact', async () => {
    const response = await request(app)
      .delete(`/contact/${contactId}`)
      .expect(200);

    expect(response.body).toBe('Product has been Deleted');
  });
});