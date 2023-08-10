const mongoose = require("mongoose")
const bcrypt = require("bcryptjs")

//model for login user
const userSchema = mongoose.Schema({
    name: {

        type: String,
        required: true,
    },
    email: {

        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    pic: {
        type: String,
        required: true,
        default: "https://th.bing.com/th/id/R.88a6a68e235ccdb2e12f9573a296492d?rik=%2f8ojC8JRbK0mxQ&riu=http%3a%2f%2fclipground.com%2fimages%2fuser-icon-png-free-2.jpg&ehk=F%2fbwK6CA3%2bXvYOQmRwhQCMDldyyq6QIs0g5wf2hlfoU%3d&risl=&pid=ImgRaw&r=0",
    },
    isAdmin: {
        type: Boolean,
        required: true,
        default: false,
    },

}, {
    timestamps: true,
});

//encryting password
userSchema.pre("save", async function(name) {
    if (!this.isModified('password')) {
        next();
    }
    const salt = await bcrypt.genSalt(10)
    this.password = await bcrypt.hash(this.password, salt)
});

//comapring password
userSchema.methods.matchpassword = async function(enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
}

const User = mongoose.model("User", userSchema)

module.exports = User