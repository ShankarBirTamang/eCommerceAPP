
/*This line imports the mongoose library, which is an Object Data Modeling (ODM) library 
for MongoDB in Node.js. It allows you to define schemas, models, 
and interact with MongoDB using a more structured and organized approach.
*/
const mongoose = require("mongoose");

const ProductSchema = new mongoose.Schema({
    id: { type: String, required: true },
    name: { type: String, required: true },
    category: { type: String, required: true },
    imageUrl: { type: [String], required: true },
    oldPrice: { type: String, required: true },
    sizes: {
        type: [
            {
                size: { type: String, required: true },
            }, 
            {
                isSelected: { type: Boolean, required: false, default: false },
            }
        ]
    },
    price: { type : String , required : true },
    description: { type : String , required : true },
    title: { type : String , required : true },
},{timestamps:true});  

module.exports = mongoose.model("Product",ProductSchema)