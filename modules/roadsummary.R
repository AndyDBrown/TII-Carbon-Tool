##### Road Summary submodule ##############################################################################################################

# Last modified by Julian Mann (01/10/2021)
# - JM (17/09/2021):  Displays pie chart showing pre-construction emissions breakdown by activity type for road option 1 and also
#                     textOutputs of total emissions by activity type
# - JM (22/09/2021):  Displays summary datatableoutput and pie chart in separate tabs
# - JM (01/10/2021):  Most tables (as in spreadsheet tool) now update based on reactivevalues passed in from other modules.  Pie charts and graphs added.

###########################################################################################################################################

roadsummary_ui <- function(id, tabName, summary_icon){
  ns <- NS(id)
  
  # if (stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
  #   summary_icon <- road_home_icon
  # } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
  #   summary_icon <- rail_home_icon
  # } else {
  #   print("what's going on here!")
  #   summary_icon <- road_home_icon
  # }
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 5,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), summary_icon, road_summary_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
                 ),
          column(width = 2, align = "right",
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), HTML("&nbsp;"))),
          ),
          column(width = 2,# align = "right",
                 h6(HTML("<br>")),
                 #numericInput(width = 200, inputId = ns("roadoptnum"), label = textOutput(ns("roadorraillabel")), value = 1, min = 1, max = 5)
          ),
          column(width = 3, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 #numericInput(width = 200, inputId = ns("roadoptnum"), label = textOutput(ns("roadorraillabel")), value = 1, min = 1, max = 5)
                 )
        ),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "breakdown", title = 
               downloadButton(outputId = ns("alltablesexport"), label = "Export All Tables"),
               
               tabPanel(title = "Emissions Breakdown By Stage", value = "breakdown",
                        hr(),
                        fluidRow(
                          column(width = 10,
                                 actionButton(inputId = ns("breakdownbutton"), label = "Show/Hide Graph", style=toggle_guid_btn_style)
                          ),
                          column(width = 2, align = "right",
                                 downloadButton(outputId = ns("breakdownexport"), label = "Export Table")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 hidden(
                                   div(id = ns("breakdownplotdiv"),
                                       plotly::plotlyOutput(ns("breakdownplot"))
                                   )
                                 )
                          )
                        ),
                        hr(),
                        fluidRow(
                          column(width = 12,
                                 div(style = "overflow-x:auto",DT::dataTableOutput(ns("breakdownDT")))
                          )
                        )
               ),
               
               tabPanel(title = "Embodied Carbon Emissions Breakdown", value = "embcarbonbdown",
                        hr(),
                        fluidRow(
                          column(width = 10,
                                 actionButton(inputId = ns("embcarbonbutton"), label = "Show/Hide Graph", style=toggle_guid_btn_style)
                          ),
                          column(width = 2, align = "right",
                                 downloadButton(outputId = ns("embcarbonexport"), label = "Export Table")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 hidden(
                                   div(id = ns("embcarbonbdowndiv"),
                                       plotly::plotlyOutput(ns("embcarbonbdownplot"))
                                   )
                                 )
                          )
                        ),
                        hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("embcarbonbdownDT"))
                          )
                        )
               ),
               
               tabPanel(title = "Detailed Breakdown", value = "detailed",
                        hr(),
                        fluidRow(
                          column(width = 10,
                                 actionButton(inputId = ns("detailedbutton"), label = "Show/Hide Graph", style=toggle_guid_btn_style)
                          ),
                          column(width = 2, align = "right",
                                 downloadButton(outputId = ns("detailedexport"), label = "Export Table")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 hidden(
                                   div(id = ns("detaileddiv"),
                                       plotly::plotlyOutput(ns("detailedplot"))
                                   )
                                 )
                          )
                        ),
                        hr(),
                        fluidRow(
                          column(width = 12,
                                 DT::dataTableOutput(ns("detailedDT")),
#                                 hr(),
#                                 numericInput(width = 200, inputId = ns("roadoptnum"), label = textOutput(ns("roadorraillabel")), value = 1, min = 1, max = 5),
#                                 plotly::plotlyOutput(ns("detailedplotlyPie"))
                          )
                        )
               ),
               
               tabPanel(title = "Emissions Intensity", value = "intensity",
                        hr(),
                        fluidRow(
                          column(width = 10,
                                 actionButton(inputId = ns("emisintensitybutton"), label = "Show/Hide Graph", style=toggle_guid_btn_style)
                          ),
                          column(width = 2, align = "right",
                                 downloadButton(outputId = ns("intensityexport"), label = "Export Table")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 #actionButton(inputId = ns("emisintensitybutton"), label = "Show/Hide Graph", style=toggle_guid_btn_style),
                                 hidden(
                                   div(id = ns("emisintensitydiv"),
                                       plotly::plotlyOutput(ns("emisintensityplot"))
                                   )
                                 )
                          )
                        ),
                        hr(),
                        fluidRow(
                          column(width = 12, align = "centre",
                                 div(style="overflow-x:auto",DT::dataTableOutput(ns("intensityDT")))
                          )
                        )
               ),
               
               tabPanel(title = "Carbon Savings Options", value = "carbonsavings",
                        hr(),
                        fluidRow(
                          column(width = 10,
                                 h4(strong("Carbon Savings Identified and Implemented"))
                          ),
                          column(width = 2, align = "right",
                                 downloadButton(outputId = ns("csavoexport"), label = "Export Table")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 div(style="overflow-x:auto",DT::dataTableOutput(ns("csavoptsimpl"))),
                                 hr(),
                                 h4(strong("Carbon Savings Identified but not Implemented")),
                                 div(style="overflow-x:auto",DT::dataTableOutput(ns("csavoptsnotimpl")))
                          )
                        )
               ),
               
               tabPanel(title = "Pie Charts", value = "piechart",
                        hr(),
                        fluidRow(
                          column(width = 2,
                                numericInput(width = 200, inputId = ns("roadoptnum"), label = textOutput(ns("roadorraillabel")), value = 1, min = 1, max = 5) 
                          ),
                          column(width = 2,
                                 selectizeInput(ns("pieStageSelect"), label = "Stage", choices = c("Product Stage (A1-A3)","Construction Process Stage (A4-5)",
                                                                                                                  "Operational Use (B1-B7)","User Emissions (B8)","End of Life (C1-C4)"),
                                                               selected = "Product Stage (A1-A3)")
                          )
                        ),
                        
                        fluidRow(
                          column(width = 6,
                                 plotly::plotlyOutput(ns("Summary_preconstPie"))
                          ),
                          column(width = 6,
                                 plotly::plotlyOutput(ns("Summary_allstagesPie"))
                          )
                        ), 
                        hr(),
                        fluidRow(
                          column(width = 12,
                                 plotly::plotlyOutput(ns("detailedplotlyPie"))
                          )
                        )
               ),
               
               ### COMMENTED OUT THIS TAB FOR NOW AS IT'S NOT USED ###
               # tabPanel(title = "Summary", value = "summ",
               #          hr(),
               #          fluidRow(
               #            column(width = 12,
               #                   h4(textOutput(ns("summarylabel"), inline = T), textOutput(ns("summarytotal"), inline = T)),
               #                   DT::dataTableOutput(ns("summaryDT")),
               #                   hr(),
               #                   plotOutput(outputId = ns("bigoldpie"))
               #            )
               #          )
               # )
        )
    )
  )
}

#----------------#
##### SERVER #####
#----------------#

roadsummary_server <- function(id, thetitle, summary_data_react, embcarbon_details, carbsaveimp_options, carbsavenotimp_options, projectdetails_values, RoadHome_serv, appR_returned){
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 # determine whether summary is for Road or Rail
                 roadorrail <- strsplit(id, split = "Summary")[[1]][1] # id must be in form "RoadSummary" or "RailSummary"
                 if (roadorrail == "Rail"){
                   roadorrail_text <- "Light Rail"
                 } else {
                   roadorrail_text <- roadorrail
                 }
                 
                 observe({
                   if (roadorrail == "Rail"){
                     num_of_options <- as.numeric(appR_returned$num_rail_opts_react())
                   } else {
                     num_of_options <- as.numeric(appR_returned$num_road_opts_react())
                   }
                 })
                 
                 output$some_title <- renderText({thetitle})
                 
                 output$roadorraillabel <- renderText({paste0(roadorrail_text, " Option Number")})
                 
                 output$summarylabel <- renderText({paste0("Total ", roadorrail_text, " Option ", input$roadoptnum, " carbon emissions (tCO2e):  ")})
                 

                 # Summary table (may or may not show in final version of UI)
                 # output$summaryDT <- DT::renderDataTable({
                 #   
                 #   DT::datatable(summary_data_react()[, Option := as.character(Option)],
                 #                 options = list(autoWidth=TRUE, pageLength=5, lengthMenu = c(5,10,20,50)), #scrollX = TRUE
                 #                 filter = c("top"), class = 'hover', rownames = FALSE, escape = FALSE) %>%
                 #     DT::formatCurrency(columns = "Value", currency = "", interval = 3, mark = ",", digits = 1)
                 #   
                 # })
                 # 
                 # output$summarytotal <- renderText({sum(summary_data_react()[Option == input$roadoptnum & Measure == "Total", c("Value")])})
                 # 
                 # output$bigoldpie <- renderPlot({
                 # 
                 #   tmpdf <- data.table(summary_data_react()) %>%
                 #     filter(Option == input$roadoptnum) %>%
                 #     select(-Option) %>%
                 #     filter(Measure != "Total")
                 # 
                 #   ggplot(tmpdf, aes(x = Stage, y = Value, fill = Measure)) +
                 #     geom_bar(stat = "identity")# +
                 #     #coord_polar(theta="y")
                 # 
                 # })
                 
                 
                 ############################################################                 
                 ##### EMISSIONS BREAKDOWN SUMMARY ##########################
                 ############################################################ 
                 
                 # Plot
                 output$breakdownplot <- plotly::renderPlotly({
                   #browser()
                   # tmpdf <- as.data.table(summary_data_react())
                   # tmpdf <- tmpdf[Measure != "Total" & Measure != "Waste Total", list(Value = sum(Value, na.rm = T)), 
                   #                by = c("Option","Stage")]
                   #x <- emissions_breakdown_reactiveTbl()
                   #x[1,c(3:8)]<-as.list(c(11853.8,23873.9,19004.6,0,202.6,54934.9))
                   #x[2,c(3:8)]<-as.list(c(2074.9,126761.4,187174.5,0,895.1,316905.9))
                     
                   tmpdf <- tidyr::pivot_longer(emissions_breakdown_reactiveTbl(), cols = c(3:8), names_to = "Stage") %>%
                     dplyr::select(-Name) %>%
                     dplyr::filter(Stage != "Total")

                   fig <- plot_ly(tmpdf, x = ~Option, y = ~value, type = "bar", color = ~Stage) %>% 
                     layout(yaxis = list(title = "tCO2e"), xaxis = list(range = c(0.5,total_num_options + 0.5), dtick = 1, tick0 = 1), barmode = "relative")

                 })
                 
                 # reactive expression for table
                 emissions_breakdown_reactiveTbl <- reactive({
                   #
                   if (roadorrail == "Rail"){
                     num_options <- appR_returned$num_rail_opts_react()
                   } else if (roadorrail == "Road"){
                     num_options <- appR_returned$num_road_opts_react()
                   } else if (roadorrail == "Greenway"){
                     num_options <- appR_returned$num_greenway_opts_react()
                   }
                   
                   
                   tmpdf <- as.data.table(summary_data_react()) %>%
                     filter(Measure == "Total" | Measure == "Vehicle Use" | Measure == "Waste Total")
                   
                   dt <- data.table(DF_emis_breakdown)
                   
                   for (i in 1:num_options){
                     
                     dt[i, "Name"] <- RoadHome_serv$data[i, `Option Names`]
                     
                     #dt[i, "Pre-Construction"] <- 0 # tmpdf[Option == i & Stage == "Pre-Construction", Value]
                     
                     dt[i, "Product Stage (A1-A3)"] <- tmpdf[Option == i & Stage == "Embodied Carbon", Value]
                     
                     dt[i, "Construction Process Stage (A4-5)"] <- sum(tmpdf[Option == i & Stage == "Construction" & Measure == "Total", Value],
                                                             tmpdf[Option == i & Stage == "Pre-Construction", Value])
                     
                     #dt[i, "Construction Waste"] <- 0 # tmpdf[Option == i & Stage == "Construction" & Measure == "Waste Total", Value]
                     
                     dt[i, "User Emissions (B8)"] <- tmpdf[Option == i & Stage == "User Emissions" & Measure == "Total", Value]
                     
                     dt[i, "Operational Use (B1-B7)"] <- sum(tmpdf[Option == i & Stage == "Operational Use" & Measure == "Total", Value],
                                                     tmpdf[Option == i & Stage == "Maintenance" & Measure == "Total", Value])
                     
                     #dt[i, "Maintenance"] <- 0 # tmpdf[Option == i & Stage == "Maintenance" & Measure == "Total", Value]
                     
                     dt[i, "End of Life (C1-C4)"] <- sum(tmpdf[Option == i & Stage == "End of Life", Value],
                                                 tmpdf[Option == i & Stage == "Construction" & Measure == "Waste Total", Value])
                     
                     dt[i, "Total"] <- sum(#dt[i, "Pre-Construction"],
                                           dt[i, "Product Stage (A1-A3)"],
                                           dt[i, "Construction Process Stage (A4-5)"],
                                           #dt[i, "Construction Waste"],
                                           #dt[i, "Use"],
                                           dt[i, "Operational Use (B1-B7)"],
                                           dt[i, "User Emissions (B8)"],
                                           #dt[i, "Maintenance"],
                                           dt[i, "End of Life (C1-C4)"])
                   }
                   
                   dt <- dt[1:num_options, ]
                   
                   return(dt)
                   
                 })
                 
                 # Render Table
                 output$breakdownDT <- DT::renderDataTable({
                   #browser()
                   # x<-emissions_breakdown_reactiveTbl()
                   # x[1,c(3:8)]<-as.list(c(11853.8,23873.9,19004.6,0,202.6,54934.9))
                   # x[2,c(3:8)]<-as.list(c(2074.9,126761.4,187174.5,0,895.1,316905.9))

                   DT::datatable(emissions_breakdown_reactiveTbl(),
                                 options = list(autoWidth=FALSE, pageLength=5, lengthMenu=c(5,10), dom="t", scrollX=FALSE
                                                ),# filter = c("top"),
                                 class = c("hover","row-border","stripe"), rownames=FALSE, escape=FALSE) %>%
                     DT::formatCurrency(columns = names(emissions_breakdown_reactiveTbl())[3:length(emissions_breakdown_reactiveTbl())],
                                        currency="", interval=3, mark=",", digits=1)

                 })
                 
                 # export data
                 output$breakdownexport <- downloadHandler(
                   filename = function(){paste0("emissions_breakdown",roadorrail,".csv")}, 
                   content = function(fname){
                     write.csv(emissions_breakdown_reactiveTbl(), fname)
                   }
                 )
                 
                 ####
                 ####
                 
                 
                 ###################################################################################
                 ##### EMBODIED CARBON DETAILED BREAKDOWN BY MATERIAL ##############################
                 ###################################################################################
                 
                 # Plot
                 output$embcarbonbdownplot <- plotly::renderPlotly({
                   
                   fig <- plot_ly(embcarbon_details()[Option > 0], x = ~Option, y = ~`Embodied tCO2e`, type = "bar", color = ~Category) %>% 
                     layout(yaxis = list(title = "tCO2e"), xaxis = list(range = c(0.5,total_num_options + 0.5), dtick = 1, tick0 = 1), barmode = "stack")
                   
                 })
                 
                 # reactive
                 embodied_carbon_reactiveTbl <- reactive({
                   
                   if (roadorrail == "Road"){
                     dt <- data.table(DF_emis_embcarbon)
                     num_options <- appR_returned$num_road_opts_react()
                   } else if (roadorrail == "Rail"){
                     dt <- data.table(DF_emis_embcarbon_rail)
                     num_options <- appR_returned$num_rail_opts_react()
                   } else if (roadorrail == "Greenway"){
                     dt <- data.table(DF_emis_embcarbon)
                     num_options <- appR_returned$num_greenway_opts_react()
                   }
                   
                   for (j in 1:num_options){
                     
                     dt[j, names(dt)[2] := RoadHome_serv$data[j, `Option Names`]]
                     
                     for (i in 3:length(names(dt))){
                       
                       dt[j, names(dt)[i] := sum(embcarbon_details()[Option == j & Category == names(dt)[i], "Embodied tCO2e"], na.rm=T)]
                       
                     }
                   }
                   
                   dt <- dt[1:num_options, ]
                   
                   return(dt)
                   
                 })
                 
                 # Table
                 output$embcarbonbdownDT <- DT::renderDataTable({
                   
                   DT::datatable(embodied_carbon_reactiveTbl(),
                                 options = list(autoWidth=TRUE, scrollX = TRUE, pageLength=5, lengthMenu = c(5,10), dom="t"), 
                                 class = c("hover","row-border","stripe"), rownames = FALSE, escape = FALSE) %>%  # filter = c("top"), 
                     DT::formatCurrency(columns = names(embodied_carbon_reactiveTbl())[3:length(embodied_carbon_reactiveTbl())],
                                        currency = "", interval = 3, mark = ",", digits = 2)
                   
                 })
                 
                 
                 # export data
                 output$embcarbonexport <- downloadHandler(
                   filename = function(){paste0("embodied_carbon",roadorrail,".csv")}, 
                   content = function(fname){
                     write.csv(embodied_carbon_reactiveTbl(), fname)
                   }
                 )
                 ####
                 ####

                 
                 ###########################################################
                 ##### DETAILED EMISSIONS BREAKDOWN ########################
                 ###########################################################
                 
                 detailed_emissions_reactiveTbl <- reactive({
                   
                   #print("Updating DETAILED EMISSIONS BREAKDOWN reactiveValues...")
                   tmpdf <- as.data.table(summary_data_react()) %>%
                     filter(Measure != "Total")
                   
                   
                   if (roadorrail == "Road"){
                     dt <- data.table(DF_emis_detailed)
                     lookupDT <- DF_detailed_lookup
                     num_options <- appR_returned$num_road_opts_react()
                   } else if (roadorrail == "Rail"){
                     dt <- data.table(DF_emis_detailed_rail)
                     lookupDT <- DF_detailed_lookup_rail
                     num_options <- appR_returned$num_rail_opts_react()
                   } else if (roadorrail == "Greenway"){
                     dt <- data.table(DF_emis_detailed)
                     lookupDT <- DF_detailed_lookup
                     num_options <- appR_returned$num_greenway_opts_react()
                   }

                   the_stages <- c("Pre-Construction","Embodied Carbon","Construction","Operational Use","Maintenance","User Emissions","End of Life")
                   #if (roadorrail == "Rail"){the_stages <- the_stages[c(1,2,3,4,5,7)]} # temp fix for rail user emissions not being dealt with yet
                   
                   for (i in 1:num_options){ # road option number
                     
                     dt[i, Name := RoadHome_serv$data[i, `Option Names`]]
                     
                     for (j in 1:length(the_stages)){
                       
                       the_measures <- as.character(lookupDT[Stage == the_stages[j]]$Detailed)
                       
                       for (k in 1:length(the_measures)){
                         
                         measure_update <- lookupDT[Stage == the_stages[j] & Detailed == the_measures[k]]$Measure
                         detailed_update <- the_measures[k]
                         
                         val_to_update <- tmpdf[Option == i & Stage == the_stages[j] & Measure == measure_update, Value]
                         
                         dt[i, c(detailed_update) := val_to_update]
                         
                       }
                     }
                   }
                   
                   dt$Total <- rowSums(dt[, 3:(length(dt)-1)])
                   
                   dt <- dt[1:num_options, ]
                   
                   return(dt)
                   
                 })


                 # Plot
                 output$detailedplot <- plotly::renderPlotly({
                   #
                   
                   tmpdf <- detailed_emissions_reactiveTbl() %>%
                     select(-Name) %>%
                     melt(., id.vars = "Option") %>%
                     filter(variable != "Total")

                   fig <- plot_ly(tmpdf, x = ~Option, y = ~`value`, type = "bar", color = ~variable) %>%  #, mode = 'markers')
                     layout(yaxis = list(title = "tCO2e"), xaxis = list(range = c(0.5,total_num_options + 0.5), dtick = 1, tick0 = 1), barmode = "relative") # barmode="stack"
                   
                 })

                 # Table
                 output$detailedDT <- DT::renderDataTable({
                   
                   if (roadorrail == "Road"){
                     tbl_container <- tblheader_DF_emis_detailed
                   } else if (roadorrail == "Rail"){
                     tbl_container <- tblheader_DF_emis_detailed_rail
                   } else if (roadorrail == "Greenway"){
                     tbl_container <- tblheader_DF_emis_detailed
                   }

                   DT::datatable(detailed_emissions_reactiveTbl(), container = tbl_container, 
                                 class = c("hover","row-border","stripe"), #class = 'hover'
                                 options = list(autoWidth=TRUE, scrollX = TRUE, pageLength=5, lengthMenu = c(5,10), dom = "t"),
                                 rownames = FALSE, escape = FALSE) %>%  # filter = c("top"), 
                     DT::formatCurrency(columns = names(detailed_emissions_reactiveTbl())[3:length(detailed_emissions_reactiveTbl())],
                                        currency = "", interval = 3, mark = ",", digits = 2)
                   
                 })

                 # Pie chart
                 output$detailedplotlyPie <- plotly::renderPlotly({
                   #
                   
                   tmpdf <- detailed_emissions_reactiveTbl() %>%
                     select(-Name) %>%
                     melt(., id.vars = "Option") %>%
                     filter(variable != "Total") %>%
                     filter(Option == input$roadoptnum) %>%
                     select(-Option) %>%
                     filter(value > 0)
                   
                   fig <- plot_ly(tmpdf, labels = ~variable, values = ~value, type = "pie", rotation = 270) %>% # rotation = 90
                     layout(title = paste0(roadorrail_text," Option ", input$roadoptnum, " Detailed Breakdown"),
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
                   
                 })
                 
                 
                 # export data
                 output$detailedexport <- downloadHandler(
                   filename = function(){paste0("detailed_breakdown",roadorrail,".csv")}, 
                   content = function(fname){
                     write.csv(detailed_emissions_reactiveTbl(), fname)
                   }
                 )
                 ####
                 ####
                 
                 
                 
                 ################################################
                 ##### EMISSIONS INTENSITY ######################
                 ################################################

                 emissions_intensity_reactiveTbl <- reactive({
                   
                   if (roadorrail == "Road"){
                     num_options <- appR_returned$num_road_opts_react()
                   } else if (roadorrail == "Rail"){
                     num_options <- appR_returned$num_rail_opts_react()
                   } else if (roadorrail == "Greenway"){
                     num_options <- appR_returned$num_greenway_opts_react()
                   }
                   
                   tmpdf <- data.table(summary_data_react()) %>%
                     filter(Measure == "Total")
                   
                   roadhometmpdf <- data.table(RoadHome_serv$data)

                   dt <- data.table(DF_emis_intensity)
                   
                   if (projectdetails_values$projValue <= 0){
                     tmp_proj_val <- 1e15
                   } else {
                     tmp_proj_val <- projectdetails_values$projValue
                   }
                   
                   
                   for (i in 1:num_options){ # num road/rail options
                     
                     tmp_dist <- roadhometmpdf[Option == i, "Total Distance"]
                     if (tmp_dist <= 0.0){
                       dt[Option == i, `tCO2e per km of road` := 0.0]
                     } else {
                       dt[Option == i, `tCO2e per km of road` := (sum(tmpdf[Option == i, "Value"]) / tmp_dist)]
                     }
                     
                     dt[Option == i, `tCO2e per Euro spent` := (sum(tmpdf[Option == i, "Value"]) / tmp_proj_val)]
                     
                   }
                   
                   if (roadorrail == "Rail"){
                     names(dt)[3] <- "tCO2e per km of rail"
                   }
                   
                   dt <- dt[1:num_options, ]
                   
                   return(dt)
                   
                 })
                 
                 
                 # Table
                 output$intensityDT <- DT::renderDataTable({
                   
                   DT::datatable(emissions_intensity_reactiveTbl(),
                                 options = list(autoWidth=TRUE, 
                                                columnDefs = list(list(width = '200px', targets = c(0,1,2,3))),
                                                pageLength=5, 
                                                lengthMenu = c(5,10), 
                                                scrollX = F), 
                                 filter = c("top"), # options = list(scrollX = TRUE)
                                 class = c("hover","row-border","stripe"), 
                                 rownames = FALSE, escape = FALSE) %>%
                     DT::formatCurrency(columns = c(3,4), currency = "", interval = 3, mark = ",", digits = 5)
                   
                 })

                 # Plot
                 output$emisintensityplot <- plotly::renderPlotly({
                   
                   fig <- plot_ly(emissions_intensity_reactiveTbl()[Option > 0], x = ~Option, y = ~`tCO2e per Euro spent`, type = "bar") %>% 
                     layout(yaxis = list(title = "tCO2e per Euro spent"), xaxis = list(range = c(0.5,total_num_options + 0.5), dtick = 1, tick0 = 1), barmode = "stack")
                   
                 })
                 
                 # export data
                 output$intensityexport <- downloadHandler(
                   filename = function(){paste0("emissions_intensity",roadorrail,".csv")}, 
                   content = function(fname){
                     write.csv(emissions_intensity_reactiveTbl(), fname)
                   }
                 )
                 ####
                 ####
                 
                 
                 ###################################################
                 ##### CARBON SAVINGS ##############################
                 ###################################################
                 
                 #emissions_intensity_reactiveTbl <- reactive({})
                 # Table
                 output$csavoptsimpl <- DT::renderDataTable({
                   
                   DT::datatable(carbsaveimp_options(),
                                 options = list(autoWidth=TRUE, pageLength=5, lengthMenu = c(5,10), columnDefs = list(list(targets = 3, width = "600px"))), 
                                 filter = c("top"), class = c("hover","row-border","stripe"), rownames = FALSE, escape = FALSE)
                 })
                 
                 output$csavoptsnotimpl <- DT::renderDataTable({
                   
                   DT::datatable(carbsavenotimp_options(),
                                 options = list(autoWidth=TRUE, pageLength=5, lengthMenu = c(5,10), columnDefs = list(list(targets = 3, width = "600px"))),
                                 filter = c("top"), class = c("hover","row-border","stripe"), rownames = FALSE, escape = FALSE)
                 })
                 
                 # export data
                 # output$csavoexport <- downloadHandler(
                 #   filename = function(){
                 #     paste0("carbon_savings",roadorrail,".zip")
                 #     },
                 #   
                 #   content = function(fname){
                 #     
                 #     write.csv(carbsaveimp_options(), paste0("carbon_savings_impl",roadorrail,".csv"))
                 #     write.csv(carbsavenotimp_options(), paste0("carbon_savings_notimpl",roadorrail,".csv"))
                 #     
                 #     files <- c(paste0("carbon_savings_impl",roadorrail,".csv"), paste0("carbon_savings_notimpl",roadorrail,".csv"))
                 #     
                 #     zip(fname, files)
                 #   }
                 # )
                 
                 csavo_export_react <- reactive({
                   list(carbon_savings_impl = carbsaveimp_options(),
                        carbon_savings_notimpl = carbsavenotimp_options())
                 })
                 # download handler
                 output$csavoexport <- downloadHandler(
                   filename = function(){
                     paste0("carbon_savings",roadorrail,".xlsx")
                   },
                   content = function(file){
                     writexl::write_xlsx(csavo_export_react(), file)
                   }
                 )
                   
                 #output$csavonotimpexport <- downloadHandler(
                  # filename = function(){paste0("carbon_savings_not_impl",roadorrail,".csv")}, 
                   #content = function(fname){
                    # write.csv(carbsavenotimp_options(), fname)
                  # }
                 #)
                 ####
                 ####
                 
                 
                 
                 ### EXPORT ALL TABLES IN ONE CLICK ###
                 
                 # output$alltablesexport <- downloadHandler(
                 #   
                 #   filename = function(){
                 #     #paste0("all_tables_export",roadorrail,".zip")
                 #     paste("TII-all-tables-export-", roadorrail, "-", format(Sys.time(), "%Y-%m-%d-%H%M"), ".zip", sep="")
                 #   },
                 #   
                 #   content = function(fname){
                 #     
                 #     write.csv(emissions_breakdown_reactiveTbl(), paste0("emissions_breakdown",roadorrail,".csv"))
                 #     write.csv(embodied_carbon_reactiveTbl(), paste0("embodied_carbon",roadorrail,".csv"))
                 #     write.csv(detailed_emissions_reactiveTbl(), paste0("detailed_breakdown",roadorrail,".csv"))
                 #     write.csv(emissions_intensity_reactiveTbl(), paste0("emissions_intensity",roadorrail,".csv"))
                 #     write.csv(carbsaveimp_options(), paste0("carbon_savings_impl",roadorrail,".csv"))
                 #     write.csv(carbsavenotimp_options(), paste0("carbon_savings_notimpl",roadorrail,".csv"))
                 #     
                 #     files <- c(paste0("emissions_breakdown",roadorrail,".csv"),
                 #                paste0("embodied_carbon",roadorrail,".csv"),
                 #                paste0("detailed_breakdown",roadorrail,".csv"),
                 #                paste0("emissions_intensity",roadorrail,".csv"),
                 #                paste0("carbon_savings_impl",roadorrail,".csv"),
                 #                paste0("carbon_savings_notimpl",roadorrail,".csv"))
                 #     
                 #     zip(fname, files)
                 #   }
                 # )
                 
                 # possible workaround to zipfile export by using XLSX instead - probably better end-user experience as well
                 all_tables_export_react <- reactive({
                   list(emissions_breakdown = emissions_breakdown_reactiveTbl(),
                        embodied_carbon = embodied_carbon_reactiveTbl(),
                        detailed_breakdown = detailed_emissions_reactiveTbl(),
                        emissions_intensity = emissions_intensity_reactiveTbl(),
                        carbon_savings_impl = carbsaveimp_options(),
                        carbon_savings_notimpl = carbsavenotimp_options()
                   )
                 })
                 # download handler
                 output$alltablesexport <- downloadHandler(
                   filename = function(){
                     paste("TII-all-tables-export-", roadorrail, "-", format(Sys.time(), "%Y-%m-%d-%H%M"), ".xlsx", sep="")
                   },
                   content = function(file){
                     writexl::write_xlsx(all_tables_export_react(), file)
                   }
                 )

                 
                 
                 ##########################################
                 ##### PIE CHARTS #########################
                 ##########################################
                 
                 # Demo pie chart for display on roadsummary page
                 output$Summary_preconstPie <- plotly::renderPlotly({
                   #
                   if (roadorrail=="Rail"){
                     lookupDT <- DF_new_detailed_lookup_rail
                   } else {
                     lookupDT <- DF_new_detailed_lookup
                   }
                   
                   tmpdf <- transpose(detailed_emissions_reactiveTbl(), keep.names = "Measure", make.names = "Option") %>%
                     tidyr::pivot_longer(., cols = c(2:ncol(.)), names_to = "Option", values_to = "Value") %>%
                     dplyr::left_join(., lookupDT, by = c("Measure" = "Detailed")) %>%
                     dplyr::filter(Stage == input$pieStageSelect & Option %in% input$roadoptnum)
                   
                   fig <- plot_ly(tmpdf, labels = ~Measure, values = ~Value, type = "pie", rotation=270) %>% # rotation=90
                     layout(title = paste0(input$pieStageSelect," ", roadorrail_text," Option ", input$roadoptnum),
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
                 })
                 
                 output$Summary_allstagesPie <- plotly::renderPlotly({
                   #
                   tmpdf <- tidyr::pivot_longer(emissions_breakdown_reactiveTbl(), cols = c(3:8), names_to = "Stage") %>%
                     dplyr::select(-Name) %>%
                     dplyr::filter(Stage != "Total" & Option %in% input$roadoptnum)
                   
                   fig <- plot_ly(tmpdf, labels = ~Stage, values = ~value, type = "pie", rotation=270) %>% # rotation=90
                     layout(title = paste0(roadorrail_text," Option ",input$roadoptnum," All Stages Totals"),
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
                   
                 })
                 ####
                 ####
                 
                 observeEvent(input$breakdownbutton, {
                   shinyjs::toggle("breakdownplotdiv")
                 })

                 observeEvent(input$detailedbutton, {
                   shinyjs::toggle("detaileddiv")
                 })
                 
                 observeEvent(input$embcarbonbutton, {
                   shinyjs::toggle("embcarbonbdowndiv")
                 })
                 
                 observeEvent(input$emisintensitybutton, {
                   shinyjs::toggle("emisintensitydiv")
                 })
               }, session = getDefaultReactiveDomain()
  )
}
