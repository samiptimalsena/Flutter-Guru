const mongoose=require("mongoose")

const questionSchema=mongoose.Schema({
    type: String,
    question: String ,
    option1: String,
    option2: String,
    option3: String,
    option4: String,
    correctAnswer: String
})

mongoose.model("Question",questionSchema);

module.exports=mongoose.model("Question")