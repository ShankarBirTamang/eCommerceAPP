const router = require('express').Router();
const cartController = require('../controllers/cartControllers');
const {verifyToken} = require('../middleware/verifyToken')          
/*This line imports the verifyToken middleware function 
from the ../middleware/verifyToken file. 
This middleware will be used to verify the authenticity of the JSON Web Token (JWT) provided in the request header.
*/

router.get('/find/',verifyToken, cartController.getCart)
router.post('/',verifyToken, cartController.addCart)
router.delete('/:cartItem',verifyToken, cartController.deleteCartItem)


module.exports = router
