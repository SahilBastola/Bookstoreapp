
const mongoose = require("mongoose");
const { boolean } = require("webidl-conversions");

const OrderSchema = new mongoose.Schema(
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
    }
  },
  { timestamps: true }
);

const Orders = mongoose.model("Order", OrderSchema);
module.exports = Orders;