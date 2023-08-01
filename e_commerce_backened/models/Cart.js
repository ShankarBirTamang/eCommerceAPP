
/*This line imports the mongoose library, which is an Object Data Modeling (ODM) library 
for MongoDB in Node.js. It allows you to define schemas, models, 
and interact with MongoDB using a more structured and organized approach.
*/

const mongoose = require("mongoose");

const CartSchema = new mongoose.Schema({
   userId : {type:String , required : true} ,
   products : [
    {
        cartItem : {
            type : mongoose.Schema.Types.ObjectId,
            ref : "Product"
        },
        quantity : { type : Number , default : 1 }
    }
   ]
   
},{timestamps:true});

module.exports = mongoose.model("Cart",CartSchema )

/*  The code above defines a Mongoose schema for a shopping cart collection named "Cart" in MongoDB. 
The schema structure is designed to store information about items in a user's shopping cart, 
including the user's ID and the products in the cart. Let's break down the schema definition:

1. userId:
This field represents the user's ID and is of type String. 
It is required (required: true) as every cart entry must be associated with a specific user.

2. products:
This field is an array of objects, each representing a product in the cart. 
The array contains one or more items, and each item is an object with two properties:

a. cartItem:
This field is of type mongoose.Schema.Types.ObjectId. It stores the reference to the "Product" collection in MongoDB. 
This allows you to associate products in the cart with documents in the "Product" collection. 
The ref: "Product" indicates that the cartItem field will be populated with data from the "Product" collection when querying the cart.

b. quantity:
This field represents the quantity of the product in the cart and is of type Number. 
It has a default value of 1, indicating that if the quantity is not specified when adding a product to the cart, it will default to 1.

3. { timestamps: true }:
This option adds createdAt and updatedAt fields to each document in the "Cart" collection. 
The createdAt field stores the date and time when the cart entry is created, 
and the updatedAt field stores the date and time when the cart entry is updated.

With this schema, you can create documents in the "Cart" collection to represent the shopping carts of different users. 
Each document will have a userId field to identify the associated user, 
and the products field will store an array of products added to the cart, along with their quantities.
*/