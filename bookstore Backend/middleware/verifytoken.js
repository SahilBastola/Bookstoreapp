const jwt = require("jsonwebtoken")


const verifyToken = (req, res, next) => {

    if(!req.headers.authorization) {
        let err = new Error("Authorization token is missing")
        res.status(400)
        return next(err)
        
    }
    // console.log(req.headers.authorization)
    token = req.headers.authorization.split(' ')[1]
    console.log(token)
    jwt.verify(token, process.env.JWT, (err, decoded) => {
        if(err) return next(err)
        req.user = decoded
        next()
    })
}


const verifyUser = (req, res, next) => {
    verifyToken(req, res, next, () => {
        if (req.params.id === req.user.id || req.user.isAdmin) {
            next();
        } else {
            return next(createError(401, "You are not authenticated"));
        }
    });
};

const verifyAdmin = (req, res, next) => {
    verifyToken(req, res, next, () => {
        if (req.user.isAdmin) {
            next();
        } else {
            return next(createError(401, "You are not authenticated"));
        }
    });
};

module.exports = { verifyAdmin, verifyToken, verifyUser }