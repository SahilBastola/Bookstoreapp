const request = require("supertest");
const app = require("../app");
const mongoose = require("mongoose");
const Hostel = require("../Models/product");

describe("Product API", () => {
  beforeAll(async () => {
    await Hostel.deleteMany();
  });
 
  describe("Add hostel", () => {
    it("should create a new hostel", async () => {
      const res = await request(app)
        .post("/api/product")
        .field("name", "Test Hostel")
        .field("type", "hostel")
        .field("desc", "Test Description")
        .field("address", "Test Address")
        .field("phone", "1234567890")
        .field("title", "Test Title")
        .field("rating", "4.5")
        .field("price", "1000")

      expect(res.statusCode).toEqual(201);
      expect(res.body.name).toEqual("Test Hostel");
      expect(res.body.type).toEqual("product");
      expect(res.body.desc).toEqual("Test Description");
      expect(res.body.address).toEqual("Test Address");
      expect(res.body.phone).toEqual("1234567890");
      expect(res.body.title).toEqual("Test Title");
      expect(res.body.rating).toEqual(4.5);
      expect(res.body.price).toEqual(1000);
    });

    it("should return 400 Bad Request if required fields are missing", async () => {
      const res = await request(app).post("/api/hostel");

      expect(res.statusCode).toEqual(400);
      expect(res.body.message).toEqual("Please provide all required fields.");
    });

    it("should return 500 Internal Server Error if file upload fails", async () => {
      const res = await request(app)
        .post("/api/product")
        .field("name", "Test Product")
        .field("type", "product")
        .field("desc", "Test Description")
        .field("address", "Test Address")
        .field("phone", "1234567890")
        .field("title", "Test Title")
        .field("rating", "4.5")
        .field("price", "1000")
        .attach("photos", "test/not-an-image.txt");

      expect(res.statusCode).toEqual(500);
    });
  });


  afterAll(async () => {
    await mongoose.connection.close();
  });

  describe("GET Hostel", () => {
    it("should return a hostel by id", async () => {
      const hostel = new Hostel({
        name: "Test Hostel",
        type: "hostel",
        desc: "Test Description",
        address: "Test Address",
        phone: "1234567890",
        title: "Test Title",
        rating: 4.5,
        price: 1000,
        photos: "/images/hotel_image/IMG-1234567890.jpg",
      });
      await hostel.save();

      const res = await request(app).get(`/api/hostel/${hostel._id}`);

      expect(res.statusCode).toEqual(200);
      expect(res.body.name).toEqual("Test Host")})})

});

