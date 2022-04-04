payload_fun <- function() {
    payload <- "I am running remote code!"
    message(payload)
    return(1)
}

payload_fun()
