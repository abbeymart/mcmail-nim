import smtp
import tables
import mcresponse

# types
type
    EmailConfigType* = object
        username*: string
        password*: string
        port*: int
        serverUrl*: string
        msgFrom*: string
        apiKey*: string
        tls*: bool

    EmailMessage* = object
        msgTo*: seq[string]
        msgCc*: seq[string]
        msgSubject*: string
        msgOtherHeaders*: Table[string, string]
        msgBody*: string

    EmailPropsType* = Table[string, string]

    EmailSubjectProc* = proc(props: EmailPropsType): string

    EmailProc* = proc(props: EmailPropsType): string

    TemplateDataType* = Table[string, string]

    EmailTemplatesType* = object 
        subject*: EmailSubjectProc
        text*: EmailProc
        html*: EmailProc
    
    MessageObjectType* = Table[string, string]

# SendEmail sends text and html messages, attachment etc.
proc sendMessage*(mailer: EmailConfigType; params: EmailMessage; emailType = "text"): ResponseMessage = 
    try:
        # TODO: configure and send-mail

        var msg = createMessage(params.msgSubject, params.msgBody, params.msgTo)

        let smtpConn = newSmtp(useSsl = mailer.tls, debug=true)
        smtpConn.connect(mailer.serverUrl, Port mailer.port)
        smtpConn.auth("username", "password")
        smtpConn.sendMail("username@gmail.com", @["foo@gmail.com"], $msg)

        result = getResMessage("success", ResponseMessage(
            message: "Email successfully sent",
            value: nil
        ))
    except:
        echo "Unable to send email message: " & getCurrentExceptionMsg()
        result = getResMessage("sendmailError", ResponseMessage(
            message: "Unable to send email message:" & getCurrentExceptionMsg(),
            value: nil
        ))
        