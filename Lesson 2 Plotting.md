Exploratory Data Analysis
=========================

Lesson 2: Plotting
------------------

 

### Plotting Systems in R

3 core plotting systems

 

1.  The Base Plotting System

    -   The oldest system

    -   It’s called the Artist’s palette model

    -   start with a blank canvas and build up from there.

    -   Use annotation functions to add/modify `text, lines, points, axis`

    -   This system is intuitive. Can’t go back though. Difficult to translate
        to others. Plot is just a series of R commands.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(datasets)
data(cars)
with(cars, plot(speed, dist))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

1.  The Lattice System

-   Plots are created with a single function call `xyplot, bwplot, etc`.

    -   Most useful for conditioning types of plots: Looking at how `y` changes
        with `x` across levels of `z`.

    -   margin/spacing and other elements set automatically

    -   good for putting many plots on a screen

    -   Sometimes not good for a single function call.

    -   annotation to plot is not intuitive

    -   Use of panel functions and subscripts difficult and requires intense
        preparation

    -   cannot add to the plot once it is created

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

1.  The `ggplot2` System

-   meets in the middle of the prior two.

    -   Similar to lattice but easier/more intuitive to use

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

 

### Base Plotting System Part 1

All core plotting system is wrapped up in two packages: `library(graphics)` and
`library(grDevices)`

 

1.  `graphics` package contains the base system including

    1.  `plot`

    2.  `hist`

    3.  `boxplot`

    4.  Many others

2.  `grDevices` package allows implementing different graphics devices such as

    1.  X11

    2.  PDF

    3.  PostScript

    4.  PNG

    5.  Many other

 

The lattice plotting system is called by `library(lattice)` and `library(grid)`

1.  `lattice` produces trellis graphics using commands such as `xyplot`,
    `bwplot`, and `levelplot`

2.  `grid` implements a different graphics system independent of the base
    system. This function is seldom called directly.

 

 

#### Ask yourself which system do you want/need to use:

-   **Base** graphics are usually piecemeal. Usually simpler and lets the
    plotting process mirror the thought process.

-   **Lattice** graphics are typically a single function call

-   **ggplot2** combines both but uses independent implementation

 

Here we focus on the base plotting system to create graphics on the screen.

 

### Base Graphics

Two phases: Initialize, Annotate

Lots of parameters that can be tweaked. `?par`

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(datasets)
hist(airquality$Ozone)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Scatterplot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(datasets)
with(airquality, plot(Wind, Ozone))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Boxplot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Important parameters

1.  `pch`: the plotting character. Default is open circle

2.  `lty`: line type. Default is solid line

3.  `lwd`: line width

4.  `col`: plotting color. Can be number, string or hex code. Can use `colors()`
    to produce a vector of colors by name.

5.  `xlab`: x-axis label

6.  `ylab`: y-axis label

Global parameters set in the `par()` function:

1.  `las`: axis label orientation

2.  `bg`: background color

3.  `mar`: margin size

4.  `oma`: outer margin size. Default is 0

5.  `mfrow`: number of plots per row, column. Plots are filled row-wise

6.  `mfcol`: number of plots per row, column. Plots are filled column-wise.

 

### Base Plotting System Part 2

#### Base Plotting Functions

-   `plot` produces a plot depending on the class of the object being plotted.

-   `lines` adds lines to a plot

-   `points` adds points to a plot

-   `text` adds text labels to a plot given specific x- and y-coordinates.

-   `title` adds the plot title, x- and y- axis labels, subtitle and outer
    margins

-   `mtext` arbitrary text to the margins

-   `axis` adds axis tick marks/labels

 

Examples:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"), type = "n")
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality) ##Fits data to model
abline(model, lwd = 2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Multiple base plots

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(mfrow = c(1,2)) ##One row, two columns.
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = TRUE)
})
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

### Base Plotting Demonstration
