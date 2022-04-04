# Import data
df  <- structure(list(source = c("facebook", "twitter", "youtube", "facebook",
"twitter", "youtube", "facebook", "twitter", "youtube"), word = structure(c("word1",
"word2", "word3", "word4", "word5", "word6", "word7", "word8",
"word9"), encoding = "intToUtf8"), x = c(112L, 97L, 121L, 108L,
111L, 97L, 100L, 46L, 82L), y = c(-21L, -98L, 0L, -2L, -181L,
71L, 172L, 35L, -56L)), row.names = c(NA, -9L), class = "data.frame")
df
#     source  word   x   y
# 1 facebook word1 113 -20
# 2  twitter word2  46   3
# 3  youtube word3  82   0

draw_plot <- function(df, draw_text = TRUE, x_col_name = "x",
                      y_col_name = "y", text_column = "word",
                      text_color_column = "source", 
                      encoding = attr(df[[text_column]], "encoding")) {

    plot(
        df[[x_col_name]],
        df[[y_col_name]],
        col = factor(df[[text_color_column]]),
        xlab = x_col_name,
        ylab = y_col_name,
        panel.first = {
            axis(1, tck=1, col.ticks="light gray")
            x_text = do.call(encoding, list(df[[x_col_name]]))
            axis(1, tck=-0.015, col.ticks="black")
            axis(2, tck=1, col.ticks="light gray", lwd.ticks="1")
            sapply(x_text, text_color_column)
            axis(2, tck=-0.015)
            box()      
        }
    )
}

