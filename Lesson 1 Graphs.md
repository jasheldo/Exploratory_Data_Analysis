Exploratory Data Analysis
=========================

Lesson 1: Graphs
----------------

 

### Principles of Analytic Graphics

1.  Show comparisons

    -   Evidence for a hypothesis is always *relative* to another competing
        hypothesis

    -   Always ask “Compared to what?”

2.  Show causality, mechanism, explanation, systematic structure

    -   Explain why the results are actually happening.

3.  Show multivariate data

    -   Multivariate = \>2 variables

    -   The real world is multivariate

    -   Need to “escape flatland”

4.  Integrate evidence

    -   Completely integrate words, numbers, images and diagrams

    -   Data graphics should make use of many modes of data presentation

    -   Don’t let the tool drive the analysis

5.  Describe and document the evidence with appropriate labels, scales, sources,
    etc.

    -   A data graphic should tell a complete story that is credible

6.  Content is king

    -   Analytical presentations ultimately stand or fall depending on the
        quality, relevance and integrity of their content

    -   If you don’t have an interesting story to tell, you’re going nowhere.

REFERENCE:  Edward Tufte (2006). [Beautiful Evidence](www.edwardtufte.com),
Graphics Press LLC.

 

### Exploratory Graphs Part 1

Graphs you make for yourself to help:

-   understand data properties

-   find patterns

-   suggest modeling strategies

-   “debug” analyses

-   communicate results

 

Characteristics of exploratory graphics include:

-   speedily made

-   many are made

-   the goal of their existence is for understanding

-   Axes/legends are generally cleaned up later

-   Color/sizes are used primarily for information

 

Some simple 1-Dimensional summaries of the data include

-   Five-number summary   `summary(table$col)`

-   boxplots    `boxplot(table$col)`

-   histograms   `hist(table$col)`

-   density plot

-   barplot  `barplot(table$col)`

`abline(h = 12)` overlays a line on the last graph, in this case `y=12`.

 

### Exploratory Graphics Part 2

2-Dimensional graphics include

-   Multiple/overlayed 1-D plots (Lattice/ggplot2)

-   Scatterplots

-   Smooth scatterplots

Plots that exceed 2-D include:

-   Overlayed/Multiple 2-D plots; coplots

-   Adding color, size and shape to add dimension

-   Spinning plots

-   Actual 3-D plots (not all that useful)

 

Multiple Box Plots

`boxplot(pm25 ~ region, data = pollution, col = “red”)`

 

Multiple Histograms

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(mfrow=c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25)
hist(subset(pollution, region == "west")$pm25)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Scatterplot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple scatterplots

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(mfrow = c(1,2), mar = (c(5,4,2,1))
with(subset(pollution, region =="west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region =="east"), plot(latitude, pm25, main = "East"))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
