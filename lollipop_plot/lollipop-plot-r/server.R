library(shiny)
# For more information, please see https://github.com/freezecoder/mutsneedle
library(maftools)
library(RColorBrewer)

shinyServer(function(input, output) {
  plotAttr <- reactiveValues(maf=data, gene=attrs$gene, AACol=attrs$AACol, labPosSize=attrs$labPosSize,
                             showMutationRate=attrs$showMutationRate, labelPos=NULL,
                             showDomainLabel=attrs$showDomainLabel,
                             cBioPortal=attrs$cBioPortal, repel=attrs$repel,
                             collapsePosLabel=attrs$collapsePosLabel,
                             legendTxtSize=attrs$legendTxtSize, labPosAngle=attrs$labPosAngle,
                             domainLabelSize=attrs$domainLabelSize, printCount=attrs$printCount,
                             colors=NULL, axisTextSize = c(9, 12), domainColors=NULL,
                             labelOnlyUniqueDoamins=attrs$labelOnlyUniqueDoamins,
                             defaultYaxis=attrs$defaultYaxis, titleSize=c(12, 10),
                             pointSize=attrs$pointSize)

  observeEvent(input$lollipop_plot_gene, {
    plotAttr$gene <- input$lollipop_plot_gene
  })

  observeEvent(input$lollipop_plot_aa_col, {
    plotAttr$AACol <- input$lollipop_plot_aa_col
  })

  observeEvent(input$lollipop_plot_label_pos, {
    if (input$lollipop_plot_label_pos == 'none') {
      plotAttr$labelPos <- NULL
    } else {
      plotAttr$labelPos <- input$lollipop_plot_label_pos
    }
  })

  observeEvent(input$lollipop_plot_show_mut_rate, {
    plotAttr$showMutationRate <- input$lollipop_plot_show_mut_rate
  })

  observeEvent(input$lollipop_plot_show_domain_label, {
    plotAttr$showDomainLabel <- input$lollipop_plot_show_domain_label
  })

  observeEvent(input$lollipop_plot_cbioportal, {
    plotAttr$cBioPortal <- input$lollipop_plot_cbioportal
  })

  observeEvent(input$lollipop_plot_repel, {
    plotAttr$repel <- input$lollipop_plot_repel
  })

  observeEvent(input$lollipop_plot_collapse_pos_label, {
    plotAttr$collapsePosLabel <- input$lollipop_plot_collapse_pos_label
  })

  observeEvent(input$lollipop_plot_legend_txt_size, {
    plotAttr$legendTxtSize <- input$lollipop_plot_legend_txt_size
  })

  observeEvent(input$lollipop_plot_label_pos_angle, {
    plotAttr$labPosAngle <- as.integer(input$lollipop_plot_label_pos_angle)
  })

  observeEvent(input$lollipop_plot_domain_label_size, {
    plotAttr$domainLabelSize <- input$lollipop_plot_domain_label_size
  })

  observeEvent(input$lollipop_plot_print_count, {
    plotAttr$printCount <- input$lollipop_plot_print_count
  })

  observeEvent(input$lollipop_plot_label_only_unique_doamins, {
    plotAttr$labelOnlyUniqueDoamins <- input$lollipop_plot_label_only_unique_doamins
  })

  observeEvent(input$lollipop_plot_default_yaxis, {
    plotAttr$defaultYaxis <- input$lollipop_plot_default_yaxis
  })

  observeEvent(input$lollipop_plot_point_size, {
    plotAttr$pointSize <- input$lollipop_plot_point_size
  })

  observeEvent(input$lollipop_plot_lab_pos_size, {
    plotAttr$labPosSize <- input$lollipop_plot_lab_pos_size
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

    output$lollipopPlot <- renderPlotly({
      p <- do.call(maftools::lollipopPlot, reactiveValuesToList(plotAttr))

      ggplotly(p) %>% layout(autosize = TRUE)
    })
  })
})
