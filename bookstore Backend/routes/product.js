const express = require("express");
const { addProduct, updateProduct ,deleteProduct,getProduct,getAllProducts} = require("../controllers/product");
const router = express.Router();

//routes
router.route("/addproduct").post(addProduct);
router.route("/:id").put(updateProduct);
router.route("/:id").delete(deleteProduct);
router.get("/:id",getProduct);
router.get("/", getAllProducts);
// router.get("/", getUsers);
module.exports = router;