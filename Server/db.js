const mongoose=require("mongoose")

mongoose.connect("mongodb+srv://samip:mongoDB@cluster0-tgqgy.mongodb.net/test?retryWrites=true&w=majority",{ useNewUrlParser: true,useUnifiedTopology: true })
        .then(()=>{console.log("DB connected")})