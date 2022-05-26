library(shiny)
library(plyr)
library(plotly)
library(RColorBrewer)

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
    require(plyr)

    # New version of length which can handle NA's: if na.rm==T, don't count them
    length2 <- function (x, na.rm=FALSE) {
        if (na.rm) sum(!is.na(x))
        else       length(x)
    }

    # This is does the summary; it's not easy to understand...
    datac <- ddply(data, groupvars, .drop=.drop,
                   .fun= function(xx, col, na.rm) {
                           c( N    = length2(xx[,col], na.rm=na.rm),
                              mean = mean   (xx[,col], na.rm=na.rm),
                              sd   = sd     (xx[,col], na.rm=na.rm)
                              )
                          },
                    measurevar,
                    na.rm
             )

    # Rename the "mean" column    
    # datac <- rename(datac, c("mean"=measurevar))

    datac[, measurevar] <- datac$mean
    datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean

    # Confidence interval multiplier for standard error
    # Calculate t-statistic for confidence interval: 
    # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
    ciMult <- qt(conf.interval/2 + .5, datac$N-1)
    datac$ci <- datac$se * ciMult

    return(datac)
}

shinyServer(function(input, output, session) {
  dataFunc <- reactive({
    if (!input$line_plot_compute_se) {
      data
    } else {
      shape <- if (input$line_plot_shape == 'none') NULL else input$line_plot_shape
      color <- if (input$line_plot_color == 'none') NULL else input$line_plot_color
      dfc <- summarySE(data, measurevar=input$line_plot_y,
                       groupvars=c(color, input$line_plot_x, shape))
      dfc <- dfc[!is.na(dfc$sd), ]
      return(dfc)
    }
  })

  plotAttr <- reactiveValues(palette="Dark2")

  observeEvent(input$line_plot_change_color, {
    allPalettes <- rownames(brewer.pal.info)
    plotAttr$palette <- sample(allPalettes, size=1)
  })

  observeEvent(input$showpanel, {
    if(input$showpanel == TRUE) {
      removeCssClass("main", "col-sm-12")
      addCssClass("main", "col-sm-8")
      shinyjs::show(id = "sidebar")
      shinyjs::enable(id = "sidebar")
    }
    else {
      removeCssClass("main", "col-sm-8")
      addCssClass("main", "col-sm-12")
      shinyjs::hide(id = "sidebar")
    }

    output$linePlot <- renderPlotly({
      shape <- if (input$line_plot_shape == 'none') NULL else input$line_plot_shape
      color <- if (input$line_plot_color == 'none') NULL else input$line_plot_color

      p <- ggplot(dataFunc(), aes_string(x=input$line_plot_x,
                                         y=input$line_plot_y,
                                         linetype=shape,
                                         color=color)) + 
            geom_line(size=1) +
            geom_point(size=1) + 
            xlab(attrs$xTitle) +
            ylab(attrs$yTitle) +
            ggtitle(attrs$title) +
            scale_color_brewer(palette=plotAttr$palette) +
            theme(axis.text.x=element_text(angle=attrs$xAngle, hjust=1,
                                           size=input$line_plot_xy_labelsize),
                  axis.text.y=element_text(size=input$line_plot_xy_labelsize),
                  text=element_text(size=input$line_plot_title_size),
                  legend.text=element_text(size=input$line_plot_legend_labelsize),
                  legend.title=element_blank(),
                  panel.background=element_rect(fill = "white"),
                  axis.line=element_line(colour='black'))

      if (input$line_plot_log10) {
        p <- p + scale_x_log10()
      }

      if (input$line_plot_compute_se) {
        p <- p + geom_errorbar(aes(ymin=mean - se, 
                                   ymax=mean + se),
                               width=input$line_plot_errorbar_width,
                               position=position_dodge(width=0.01))
      }

      ggplotly(p) %>% layout(autosize=TRUE)
    })
  })
})
