import unittest
import mcmail
import ../config/secure/testData

let msgHtml = """ 
    Hello <b>Guest</b> and <i>Welcome to mac</i>!"""
let subject =  "mConnect Go Universal!!!"

let mailer = EmailConfigType(
  username: emailUser,
  password: emailPass,
  serverUrl: emailServer,
  port: emailPort,
  msgFrom: emailFrom,
)

let emailMsg = EmailMessage(
  msgTo: toEmail,
  msgCc: @[],
  msgSubject: subject,
  msgBody: msgHtml,
)

test "should respond with successful message: ":
    let res = sendEmail(mailer, emailMsg, "html")
    echo "send-mail response: ", res
    check res.code == "success"
    check res.message.contains("Email successfully sent") == true
    check res.resCode.repr == "200"
