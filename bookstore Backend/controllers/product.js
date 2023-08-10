const Product = require("../models/product");

const addProduct = async (req, res, next) => {
  const newProduct = new Product({
    title: req.body.title,
    desc: req.body.desc,
    img: req.body.img,
    categories: req.body.categories,
    Author: req.body.Author,
    price: req.body.price,
  });
  try {
    const savedProduct = await newProduct.save();
    res.status(200).json({
      success : true,
      message:"list of product",
      data: savedProduct
      
    });
  } catch (error) {
    next(error);
  }
};

const updateProduct = async (req, res, next) => {
  try {
    const updateproduct = await Product.findByIdAndUpdate(
      req.params.id,
      {
        $set: req.body,
      },
      { new: true }
    );
    res.status(200).json(updateproduct);
  } catch (error) {
    next(error);
  }
};

const deleteProduct = async (req, res, next) => {
  try {
    const deleteproduct = await Product.findByIdAndDelete(req.params.id);
    res.status(200).json(deleteproduct);
  } catch (error) {
    next(error);
  }
};

const getProduct = async (req, res, next) => {
  try {
    const getproduct = await Product.findById(req.params.id);
    res.status(200).json(getproduct);
  } catch (error) {
    next(error);
  }
};

const getAllProducts = async (req, res, next) => {
  const qNew = req.query.new;
  const qCategory = req.query.category;
  try {
    let products;
    if (qNew) {
      products = await Product.find().sort({ createdAt: -1 }).limit(5);
    } else if (qCategory) {
      products = await Product.find({ categories: { $in: [qCategory] } });
    } else {
      products = await Product.find();
    }
    res.status(200).json({
      success : true,
      message:"list of product",
      data: products});
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = {
  addProduct,
  updateProduct,
  deleteProduct,
  getProduct,
  getAllProducts,
};