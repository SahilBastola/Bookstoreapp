const express = require("express");
const {
  createOrder,updateOrder, deleteOrder, getAllOrder, getOrder,getOrdersByUserId ,deleteAllOrder
} = require("../controllers/order");
const { verifyAdmin, verifyUser ,verifyToken} = require("../middleware/verifyToken")
const router = express.Router();

//routes
router.post("/createOrder",verifyToken, createOrder);
router.put("/:id", updateOrder);
router.delete("/:id", deleteOrder);
router.delete("/", deleteAllOrder);
router.get("/getorder", getAllOrder);
router.get("/myorder", verifyToken,getOrdersByUserId);
router.get("/getorderss", getOrder);
module.exports = router;