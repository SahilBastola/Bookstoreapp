const express = require("express");
const {
  createCart,Updatecart, deleteCart, getAllCart, getCart,getCartByUserId ,deleteAllCart
} = require("../controllers/cart");
const { verifyToken } = require("../middleware/verifyToken");
const router = express.Router();

//routes
router.route("/createcart").post(verifyToken,createCart);
router.route("/:id").put(Updatecart);
router.route("/:id").delete(deleteCart);
router.get("/mycart",verifyToken, getCartByUserId);
router.get("/", getAllCart);
router.get("/getcart", getCart);
module.exports = router;