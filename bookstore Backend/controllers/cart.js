const Carts = require("../Models/cart");

//cerate order
const createCart = async (req, res, next) => {
    const newCart = new Carts({
        userid: req.user.id,
        Productid: req.query.Productid,

    });
  
    try {
      // Add this line to validate the order before saving it
      await newCart.validate();
      const savedCart = await newCart.save();
      res.status(200).json(savedCart);
    } catch (error) {
        console.log(error);
      next(error);
    }
  }; 

  const getAllCart = (req, res, next) => {
    Carts.find()
      .populate("userid")
      .populate("Productid")
      .then((Carts) => {
        res.status(200).json({
          success: true,
          message: "List of All Cart Products",
          data: Carts,
        });
      })
      .catch(next);
  };

  const deleteAllCart = (req, res, next) => {
    Carts.deleteMany()
      .then((reply) => {
        res.json(reply);
      })
      .catch(console.log);
  };




const Updatecart = async(req, res, next) => {
    try {
        const updatedcart = await Carts.findByIdAndUpdate(
            req.params.id, { $set: req.body }, { new: true }
        );

        res.status(200).json(updatedcart)
    } catch (error) {
        next(error)
    }
}


const deleteCart = async(req, res, next) => {
    try {
        const Deletedcart = await Carts.findByIdAndDelete(
            req.params.id,
        );

        res.status(200).json("Cart Item been Deleted")
    } catch (error) {
        next(error)
    }
}


const getCart = async(req, res, next) => {
    try {
        const cart = await Carts.find(
          req.params.id,
        );

        res.status(200).json(cart)
    } catch (error) {
        next(error)
    }
}

const getCartByUserId = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const Cart = await Carts.find({ userid: userId })
    .populate("userid")
    .populate("Productid")
    .then((Cart) => {
      res.status(200).json({
        success: true,
        message: "List of All Cart Products",
        data: Cart,
      });
    })
    .catch(next);


    res.status(200).json(Cart);
  } catch (err) {
    console.log(err);
  }
}


module.exports = { createCart,Updatecart, deleteCart, getAllCart, getCart,getCartByUserId ,deleteAllCart}