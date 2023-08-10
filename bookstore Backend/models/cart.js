const mongoose = require("mongoose")
const bcrypt = require("bcryptjs")

//model for login user
const cartSchema = mongoose.Schema(
  {

    userid: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required:true
    },
    Productid: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      required:true
    },
  },
  { timestamps: true }
);
const Carts = mongoose.model("Cart", cartSchema)
module.exports = Carts