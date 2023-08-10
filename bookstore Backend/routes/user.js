const express = require("express");
const { registerUser, authUser } = require("../controllers/userControllers");

const router = express.Router();

//routes
router.route("/registeruser").post(registerUser);
router.route("/loginuser").post(authUser);

module.exports = router;





// const express = require("express");
// const { verify } = require("jsonwebtoken");
// const { updateUser, deleteUser, getUser, getUsers } = require("../controllers/user");
// const { verifyAdmin, verifyUser } = require("../middleware/verifyToken")
// const router = express.Router();


// //update
// router.put("/:id", updateUser);
// router.delete("/:id", deleteUser);
// router.get("/:id", getUser);
// router.get("/", getUsers);


// module.exports = router;