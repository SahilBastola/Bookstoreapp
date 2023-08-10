const supertest = require("supertest");
const app = require("../app");

const api = supertest(app);
// User Model
const User = require("../models/userModel");
// To execute function. [find() , findOne() , deleteMany()]
const mongoose = require("mongoose");

const user = {
    Username: "testuser",
    email: "testuser@test",
    password: "testuser",
};



const loginUser = {
    Username: "testuser",
    password: "testuser",
};



const token =
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZGIyNWFkYTJmNmM1MTIzYTZlZDNkOSIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2NzgxNzAwMjEsImV4cCI6MTY3ODI1NjQyMX0.mysPPPBjkGlacS7KLwc-be86yXpgS_gb4BLdh7qYAAI"// Just clear all data from the database connection.
// Before running the test.
beforeAll(async () => {
    await User.deleteMany({});
});

// test("get all mechanic testing", async () => {
//     await api.get("/api/mechanics/").set("Authorization", `bearer ${token}`).expect(201);
// });

test("register user testing", async () => {
    await api.post("/api/user/registeruser").send(user).expect(201);
});



test("Testing login for user", async () => {
    await api
        .post("/api/user/loginuser")
        .send(loginUser)
        .expect(200)
});



// close the connection after all the test is completed
afterAll(async () => {
    await mongoose.connection.close();
});
