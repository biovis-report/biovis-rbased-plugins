library(shiny)
library(shinyBS)
library(shinyjs)
library(plotly)

choices <- getGeneSummary(data)$Hugo_Symbol
aaColChoices <- colnames(data@data)
names(aaColChoices) <- aaColChoices

shinyUI(fluidPage(
  useShinyjs(),
  tags$head(
    tags$style("
      .chart-title-area {margin: -20px; width: 100%;}
      .chart-title-area .title {display: flex; justify-content: center; font-size: 16px;}
      .chart-title-area .content {margin-left: 70px;}

      #main {display: flex; flex-direction: column; align-items: flex-end;}
      #showpanel {width: 120px; margin-bottom: 10px; background-color: #f5f5f5; box-shadow: none}
    "),
    tags$script(src="http://nordata-cdn.oss-cn-shanghai.aliyuncs.com/biovis-report/2019-02-27-iframeResizer.contentWindow.min.js",
                type="text/javascript")
  ),
  sidebarLayout(
    mainPanel(
      id='main',
      bsButton("showpanel", "Show/hide", icon=icon('far fa-chart-bar'),
               type = "toggle", value = attrs$showpanel),
      plotlyOutput("lollipopPlot", height=700),
      tags$div(
        class="chart-title-area",
        tags$h2(class="title", attrs$title),
        tags$p(class="content", attrs$text)
      )
    ),
    sidebarPanel(
      id = "sidebar",
      checkboxInput("lollipop_plot_show_mut_rate",
                    "Show mutation rate?",
                    value = attrs$showMutationRate),
      checkboxInput("lollipop_plot_show_domain_label",
                    "Show domain label?",
                    value = attrs$showDomainLabel),
      checkboxInput("lollipop_plot_cbioportal",
                    "Adds annotations similar to cBioPortals MutationMapper?",
                    value = attrs$cBioPortal),
      checkboxInput("lollipop_plot_collapse_pos_label",
                    "Collapses overlapping labels at same position?",
                    value = attrs$collapsePosLabel),
      selectInput("lollipop_plot_gene", "HGNC symbol :",
                  choices = choices,
                  selected = attrs$geneName),
      selectInput("lollipop_plot_aa_col", "Column name for amino acid changes :",
                  choices = aaColChoices,
                  selected = attrs$AACol),
      # Bugs: geom_GeomTextRepel() has yet to be implemented in plotly.
      # https://github.com/ropensci/plotly/issues/1500
      # selectInput("lollipop_plot_label_pos", "Amino acid positions to label :",
      #              c('all' = 'all', 'none' = 'none'), selected='all'),
      # selectInput("lollipop_plot_label_pos_angle", "Angle for labels :",
      #             choices = c("0" = "0",
      #                         "45" = "45",
      #                         "90" = "90"),
      #             selected = attrs$labPosAngle),
      sliderInput("lollipop_plot_legend_txt_size", "Text size for legend : ",
                  min = 1, max = 30, value = attrs$legendTxtSize, step=1),
      sliderInput("lollipop_plot_domain_label_size", "Text size for domain labels : ",
                  min = 1, max = 30, value = attrs$domainLabelSize, step=1),
      sliderInput("lollipop_plot_point_size", "Size of lollipop heads : ",
                  min = 1, max = 30, value = attrs$pointSize, step=1),
      sliderInput("lollipop_plot_lab_pos_size", "label Position Size : ",
                  min = 1, max = 30, value = attrs$labPosSize, step=1)
    )
  )
))
