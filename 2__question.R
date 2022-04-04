# Import data

df  <- structure(list(source = c("facebook", "twitter", "youtube", "facebook",
"twitter", "youtube", "facebook", "twitter", "youtube", "facebook",
"twitter", "youtube", "facebook", "twitter", "youtube", "facebook",
"twitter"), word = structure(c("word1", "word2", "word3", "word4",
"word5", "word6", "word7", "word8", "word9", "word10", "word11",
"word12", "word13", "word14", "word15", "word16", "word17"), encoding = "intToUtf8"),
x = c(104L, 116L, 116L, 112L, 115L, 58L, 47L, 47L, 116L,
46L, 108L, 121L, 47L, 81L, 80L, 68L, 89L), y = c(-29L, -152L,
92L, 30L, -31L, -32L, -88L, -59L, -112L, -51L, 143L, 16L,
44L, 13L, 76L, -92L, 6L)), row.names = c(NA, -17L), class = "data.frame")

df
#      source   word   x    y
# 1  facebook  word1 104  146
# 2   twitter  word2 116   -9
# 3   youtube  word3 116  -89
# 4  facebook  word4 112   28
# 5   twitter  word5 115   32
# 6   youtube  word6  58  -41
# 7  facebook  word7  47  -13
# 8   twitter  word8  47    9
# 9   youtube  word9 116 -121
# 10 facebook word10  46   20
# 11  twitter word11 108  -33
# 12  youtube word12 121   41
# 13 facebook word13  47    3
# 14  twitter word14  81  -88
# 15  youtube word15  80   -1
# 16 facebook word16  68  -71
# 17  twitter word17  89 -176

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

draw_plot(df)