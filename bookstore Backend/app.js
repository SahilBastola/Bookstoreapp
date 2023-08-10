const express = require("express");
const dotenv = require("dotenv");
require("dotenv").config();
const cors = require('cors')
require("../t1-backend-web-api-SahilBastola/db/connection")
const userRoutes = require("../t1-backend-web-api-SahilBastola/routes/user")
const AuthRoutes = require("../t1-backend-web-api-SahilBastola/routes/auth")
const productRoutes = require("../t1-backend-web-api-SahilBastola/routes/product")
const OrderRoutes = require("../t1-backend-web-api-SahilBastola/routes/order")
const CartRoutes = require("../t1-backend-web-api-SahilBastola/routes/cart")

const app = express();
const port = 4000;

//middleware
app.use(cors())
app.use(express.json());


// routes
app.use("/api/user", userRoutes);
app.use("/api/users", AuthRoutes);
app.use("/api/product", productRoutes);
app.use("/api/order", OrderRoutes);
app.use("/api/cart", CartRoutes);

app.get("/", (req, res) => {
  res.send("Under Construction");
});


app.listen(port, () => {
  console.log(`App is running in ${port}`);
});





// const express = require('express');
// require("../t1-backend-web-api-SahilBastola/db/connection")
// const userRoutes = require('../t1-backend-web-api-SahilBastola/routes/auth');
// const { notFound, errorHandler } = require('./middleware/errorMiddleware');

// //mongodvconfid
// require("dotenv").config();
// // connectDB();

// const app = express()
// const port = 4000

// app.use(express.json())


// app.get('/', (req, res) => {
//     res.send('Under Construction');
// });

// //routes
// // app.use("/users", userRoutes);
// app.use("/user", userRoutes);
// app.use(notFound)
// app.use(errorHandler)


// //checking port
// app.listen(port, () => {
//     console.log(`App is running in ${port}`)
// })