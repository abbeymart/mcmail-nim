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
proc sendEmail*(mailer: EmailConfigType; recipients: seq[string]; message: string; subject: string; emailType: string): ResponseMessage = 
    try:
        # TODO: configure and send-mail

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
        