const express=require("express")
const router=express.Router();

const bodyParser=require("body-parser")

router.use(bodyParser.json());
router.use(bodyParser.urlencoded({extended:false}))

const Question=require("../model/question")

router.get("/",(req,res)=>{
    res.status(200).send("You are on question set. So be Prepared.");
})

router.get("/getQuestion",(req,res)=>{
   Question.find({ type:req.query.type},(err,question)=>{
        if(err) return res.status(500).send("Error on the server");

        if(!question) return res.status(404).send("No result found");

        res.status(200).send(question);
    })
    
})

router.post("/postQuestion",(req,res)=>{
    Question.create({
        type: req.body.type,
        question: req.body.question,
        option1: req.body.option1,
        option2: req.body.option2,
        option3: req.body.option3,
        option4: req.body.option4,
        correctAnswer: req.body.correctAnswer
    },
    (err,question)=>{
        if(err) return res.status(500).send("Question addition unsuccessful");

        res.status(200).send("Successful");
    }
    
    )
})

module.exports=router;