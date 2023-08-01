const jwt = require('jsonwebtoken');
const User = require('../models/Users');

const verifyToken = (req ,res , next) => {
    const authHeader = req.headers.token ;
    if(authHeader){
        const token = authHeader.split(" ")[1];
        jwt.verify(token , process.env.JWT_SEC, async (err,user)=>{
            if(err) res.status(403).json('Invalid token');
            req.user = user ; 
            next()
        })
    }else{
        return res.status(401).json('You are not authenticated')
    }
}

module.exports = { verifyToken } ;

/* 
The code above is a middleware function named `verifyToken`. 
This middleware is used to authenticate and verify JWT (JSON Web Token) provided in the request headers 
and add the decoded user information to the `req.user` object for further processing in subsequent request handlers. 
Let's go through the code step by step:

1. `const jwt = require('jsonwebtoken');`:
   This line imports the `jsonwebtoken` library, which is used to work with JSON Web Tokens in Node.js.

2. `const User = require('../models/Users');`:
   This line imports the `User` model from the `../models/Users` file. 
   It suggests that the application uses a `User` model to represent user information 
   and might be interacting with the database for authentication purposes.

3. `const verifyToken = (req, res, next) => { ... }`:
   This defines the `verifyToken` middleware function, 
   which takes three parameters: `req` (request), `res` (response), and `next`. 
   In Express, middleware functions have access to the request and response objects 
   and can modify them before passing control to the next middleware or request handler.

4. `const authHeader = req.headers.token;`:
   This line extracts the value of the "token" header from the request headers. 
   The assumption here is that the client must include the JWT in the "token" header when making authenticated requests.

5. `if (authHeader) { ... } else { ... }`:
   The middleware checks whether the "token" header exists in the request. 
   If it does, it proceeds with token verification. If the "token" header is missing, 
   the middleware responds with a status code of 401 and a JSON response saying "You are not authenticated."

6. `const token = authHeader.split(" ")[1];`:
   Assuming that the "token" header value is provided in the format "Bearer {token}", 
   this line splits the header value by the space character and extracts the token part (second part) for verification.

7. `jwt.verify(token, process.env.JWT_SEC, async (err, user) => { ... })`:
   This line verifies the JWT using `jwt.verify()`. It takes the token, the JWT secret (`process.env.JWT_SEC`), 
   and a callback function as arguments. If the verification is successful, 
   the `user` object (decoded payload of the JWT) is provided in the callback. 
   If there's an error during verification (e.g., token expired or invalid signature), 
   the `err` parameter will be non-null.

8. `if (err) res.status(403).json('Invalid token');`:
   If there's an error during token verification, the middleware responds with a status code of 403 
   and a JSON response saying "Invalid token." This indicates that the token 
   provided by the client is either not valid or has expired.

9. `req.user = user;`:
   If the token verification is successful, the `user` object (decoded payload) is attached to the `req.user` property, 
   making it accessible in the subsequent request handlers.

10. `next();`:
    After successful token verification and setting the `req.user`, 
    the middleware calls the `next()` function to pass control to the next middleware or request handler in the chain.

11. `return res.status(401).json('You are not authenticated');`:
    If the "token" header is missing from the request, this line will be executed, 
    responding with a status code of 401 and a JSON response saying "You are not authenticated."

12. `module.exports = { verifyToken };`:
    Finally, the `verifyToken` middleware function is exported so that it can be used in other parts of the application.

Overall, this middleware is used to protect certain routes or operations that require authentication. 
It checks the presence of a valid JWT in the request header, verifies its validity, 
and then grants access to the protected route or resource if the token is valid. 
If the token is missing, expired, or invalid, it responds with appropriate error messages.

*/