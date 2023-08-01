// Importing dependencies and required routes
const express = require('express')
const app = express()
const dotenv = require('dotenv');
const mongoose = require("mongoose");
const productRoute = require('./routes/products')
const authRoute = require('./routes/auth')
const userRoute = require('./routes/users')
const ordersRoute = require('./routes/orders')
const cartRoute = require('./routes/cart')
const port = 3000

//Environment configuration and Database Connection
dotenv.config()
mongoose.connect(process.env.MONGO_URL).then(()=>console.log("db connected")).catch((err)=>console.log(err))

// app.get('/', (req, res) => res.send('Hello Sneakers!')) //browser display

//Middleware setup
app.use(express.json({limit:'10mb'}));
app.use(express.urlencoded({limit:'10mb',extended : true}))


// Route Handling
app.use('/api/',authRoute)
app.use('/api/products',productRoute)
app.use('/api/users',userRoute)
app.use('/api/orders',ordersRoute)
app.use('/api/cart',cartRoute)

//Server Startup
app.listen(process.env.PORT||port,
     () => console.log(`Example app listening on port ${process.env.PORT}!`)) 