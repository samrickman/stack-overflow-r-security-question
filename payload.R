payload_fun <- function() {
    payload <- "I am running remote code!"
    message(payload)
    return(TRUE)
}

payload_fun()
