//simplyfying showing the error and making it pretty
const notFound = (req, res, next) => {
    const error = new Error(`erro not foun ${req.originalurl}`);
    res.statusCode(404);
    next(error);
}
//error handler
const errorHandler = (err, req, res, next) => {
const statusCode = res.statusCode === 200 ? 500 : res.statusCode;
res.status(statusCode).json({
    message: err.message,
    stack: process.env.NODE_ENV === 'production' ? null : err.stack
});
}

module.exports = {
notFound,
errorHandler
};