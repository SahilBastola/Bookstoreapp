const asyncHandler = require('express-async-handler')
const User = require('../models/userModel')
const bcrypt = require("bcryptjs")
const jwt = require('jsonwebtoken')

//register funtion
const registerUser = asyncHandler(
    async(req, res) => {
        const { name, email, password, pic } = req.body;

        const userExits = await User.findOne({ email });

        if (userExits) {
            res.status(400)
            throw new Error("User already exits");
        }

        const user = await User.create({ name, email, password, pic });

        if (user) {
            res.status(201).json({
                _id: user._id,
                name: user.name,
                email: user.email,
                isAdmin: user.isAdmin,
                pic: user.pic,
            })
        } else {
            res.status(400)
            throw new Error("error occured")
        }
    }

);



const authUser = asyncHandler(
    async(req, res) => {
        const { name, password, } = req.body;
        const user = await User.findOne({ name });
        if (!user) return res.status(400).json({ message: "User not found" });

        if (user == null) {
                    let err = new Error(`User ${req.body.name} not been found `);
                    res.status(404);
                    return next(err);
                  }
  

        const token = jwt.sign({ id: user._id, isAdmin: user.isAdmin }, process.env.JWT, {
            expiresIn: "1h"
        });

        if (user && (await user.matchpassword(password))) {
            res.json({
                _id: user._id,
                Username: user.name,
                email: user.email,
                isAdmin: user.isAdmin,
                pic: user.pic,
                token
            })

            const { name,password, isAdmin, ...otherDetails } = user._doc
            res.cookie("Acess token", token, {
                httpOnly: true
            }).status(200).json({
                details: {...otherDetails },
                isAdmin,
                token
            })
        } else {
            res.status(400)
            throw new Error("Invalid Username or Password")
        }
    }

);


module.exports = { registerUser, authUser }