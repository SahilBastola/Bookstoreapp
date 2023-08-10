const mongoose = require("mongoose");

mongoose.connect('mongodb://127.0.0.1:27017/books', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(

    () => {
        console.log("connectted to mongodbs server")
    }).catch(
    (err) => console.log(err)
)
// connection to mongoose
// const mongoose = require("mongoose");
// const colors = require("colors");

// const connectDB = async() => {
//     try {
//         const conn = await mongoose.connect(process.env.MONGO_URI, {
//             useUnifiedTopology: true,
//             useNewUrlParser: true,
//         });
//         console.log(`MongoDB Connected: ${conn.connection.host}`.cyan.underline);
//     } catch (error) {
//         console.error(`Error: ${error.message}`.red.bold);
//         process.exit();
//     }
// };

// module.exports = connectDB