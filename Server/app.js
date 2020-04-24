const express=require("express")
const app=express();
const db=require("./db");
const auth=require("./auth/authController")
const question=require("./question/questionController")

app.get("/",(req,res)=>{
    res.status(200).send("Welcome to authentication");
})

app.use("/auth",auth);

app.use("/question",question);


const port=process.env.PORT || 3000;

app.listen(port,()=>{
    console.log(`Express listening at port ${port}`)
})