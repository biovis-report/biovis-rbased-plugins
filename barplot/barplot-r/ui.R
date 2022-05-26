library(shiny)
library(shinyBS)
library(shinyjs)
library(shinycssloaders)
library(plotly)

choices <- colnames(data)
names(choices) <- colnames(data)

shinyUI(fluidPage(
  useShinyjs(),
  tags$head(
    tags$style("
      .chart-title-area {margin: -20px; width: 100%;}
      .chart-title-area .title {display: flex; justify-content: center; font-size: 16px;}
      .chart-title-area .content {margin-left: 70px;}

      #main {display: flex; flex-direction: column; align-items: flex-end;}
      #showpanel {width: 120px; margin-bottom: 10px; background-color: #f5f5f5; box-shadow: none;}
      .shiny-spinner-output-container {width: 100%;}
    "),
    tags$script(src="http://nordata-cdn.oss-cn-shanghai.aliyuncs.com/biovis-report/2019-02-27-iframeResizer.contentWindow.min.js",
                type="text/javascript")
  ),
  sidebarLayout(
    mainPanel(
      id='main',
      bsButton("showpanel", "Show/hide", icon=icon('far fa-chart-bar'),
               type = "toggle", value = attrs$showpanel),
      withSpinner(plotlyOutput("barPlot", height=700)),
      tags$div(
        class="chart-title-area",
        tags$p(class="content", attrs$text)
      )
    ),
    sidebarPanel(
      id = "sidebar",
      checkboxInput("bar_plot_compute_se", "Compute SE?",
                    value = attrs$enableSE),
      selectInput("bar_plot_x", "X variable :",
                  choices = choices,
                  selected = attrs$xAxis),
      selectInput("bar_plot_y", "Y variable :",
                  choices = choices,
                  selected = attrs$yAxis),
      selectInput("bar_plot_color", "Color mapping variable :",
                  choices = c("None" = 'none', choices),
                  selected = attrs$colorAttr),
      sliderInput("bar_plot_xy_labelsize", "X&Y labels size :",
                  min = 11, max = 30, value = attrs$xyLabelSize),
      sliderInput("bar_plot_title_size", "X&Y title size :",
                  min = 11, max = 30, value = attrs$xyTitleSize),
      sliderInput("bar_plot_legend_labelsize", "Legend labels size :",
                  min = 11, max = 30, value = attrs$legendLabelSize),
      sliderInput("bar_plot_errorbar_width", "Error bar width :",
                  min = 0.1, max = 1, value = attrs$errorBarWidth, step = 0.1),
      tags$p(
        # actionButton("heatmap-r-reset-zoom", 
        #              HTML("<span class='glyphicon glyphicon-search' aria-hidden='true'></span> Reset Zoom"))
        actionButton("bar_plot_change_color", 
                     HTML("<span class='glyphicon glyphicon-screenshot' aria-hidden='true'></span> Change Color"))
      )
    )
  )
))
