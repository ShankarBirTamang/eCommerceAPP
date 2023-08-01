
/*THis line imports the mongoose library, which is an Object Data Modeling (ODM) library 
for MongoDB in Node.js. It allows you to define schemas, models, 
and interact with MongoDB using a more structured and organized approach.
*/
const mongoose = require("mongoose")
/*
This block defines the schema for the "User" collection. 
It specifies the fields that each document should have and their corresponding data types and validation rules. 
The { timestamps: true } option automatically adds createdAt and updatedAt fields to each document, which represent the date 
and time of document creation and the last update, respectively.
*/

const UsersSchema = new mongoose.Schema({
    username: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    location: { type: String, default: "Kathmandu" },
}, { timestamps: true });

/*
This line exports the Mongoose model for the "User" collection based on the defined schema.
 The model allows you to interact with the "User" collection in the MongoDB database 
 using Mongoose methods like find, create, update, and delete.
*/
module.exports = mongoose.model("User", UsersSchema)