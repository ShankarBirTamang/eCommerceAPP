const router = require('express').Router();
const orderController = require('../controllers/ordersControllers');
const {verifyToken} = require('../middleware/verifyToken')          
/*This line imports the verifyToken middleware function 
from the ../middleware/verifyToken file. 
This middleware will be used to verify the authenticity of the JSON Web Token (JWT) provided in the request header.
*/

router.get('/',verifyToken, orderController.getUserOrders)


module.exports = router
