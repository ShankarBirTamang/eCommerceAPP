const router = require('express').Router();
const userController = require('../controllers/usersControllers');
const {verifyToken} = require('../middleware/verifyToken')          
/*This line imports the verifyToken middleware function 
from the ../middleware/verifyToken file. 
This middleware will be used to verify the authenticity of the JSON Web Token (JWT) provided in the request header.
*/

router.get('/',verifyToken, userController.getUser)
/*  This line defines a GET route for the root path /. 
The route is protected using the verifyToken middleware, 
which means that a valid JWT is required in the request header for accessing this route. 
If the token is valid, the request is passed to the userController.getUser function to handle the request.
*/

router.delete('/',verifyToken,userController.delete)
/*  This line defines a DELETE route for the path /. 
Similar to the previous route, it uses the verifyToken middleware to authenticate 
the request before calling the delete controller function. 
The delete function likely handles the logic to delete user data.
*/

module.exports = router
