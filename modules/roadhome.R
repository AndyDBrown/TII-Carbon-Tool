
roadhome_ui <- function(id,tabName){
  ns <- NS(id)
  
  #
  # determine whether Road or Rail
  roadorrail <- strsplit(tabName, split = "Home")[[1]][1] # id must be in form "RoadHome" or "RailHome"
  
  if (roadorrail == "Road"){
    home_icon <- road_home_icon
    proj_phase_list <- road_proj_phase_list
    roadorrail_text <- roadorrail
  } else if(roadorrail == "Rail"){
    home_icon <- rail_home_icon
    proj_phase_list <- rail_proj_phase_list
    roadorrail_text <- "Light Rail"
  } else if(roadorrail == "Greenway"){
    home_icon <- gway_home_icon
    proj_phase_list <- road_proj_phase_list
    roadorrail_text <- "Greenway"
  } 

  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 8,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), home_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 4, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")))
          )
          #column(width = 12,
          #       h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 180)), HTML("&nbsp;"), HTML("&nbsp;"), home_icon, HTML("&nbsp;"),
          #                  textOutput(ns("some_title"), inline = T)))
          #)
        ),
        
        hr(),
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "prevData",
               
               tabPanel(title = "Previous Data", value = "prevData",
                        fluidRow(
                          column(width = 12,
                                 h4(HTML(paste0("<b>Welcome to the ", roadorrail_text, " Section of the tool</b>"))),
                                 h5("Transport Infrastructure Ireland (TII) road & light rail projects follow the following a series of project phases. 
                             One version of the tool should be completed for each project phase. Each stage of the tool should be completed in as much detail as possible. 
                             In the earlier stages of a project, some data requested by the tool may not be available or may not have been quantified; where this is the case, 
                             the data entry boxes should be left blank and a comment left for clarification and follow-up."),
                             # selectInput(width = 500, inputId = ns("Phase"), label = paste0("Select which phase of the ", roadorrail_text," project you are currently working on:"), 
                             #             choices = proj_phase_list),
                             h4(HTML(paste0("<br> </br><b>Phase of the ", roadorrail_text," project you are currently working on:</b>")), 
                                h5(textOutput(outputId = ns("projPhase"), inline = T))),
                             
                             br(),
                             h4(HTML("<b>Input or copy data from previously completed version of the tool into this table</b>")),
                             h5("The data to be used to populate this table should be taken (copied and pasted) from the summary table at the top of the 
                             'Detailed Outputs Page' of the previously populated version of the tool. If this is the first time that the tool is being 
                             used for this particular project, this table should be left blank.")
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 DT::DTOutput(ns("prevDataTbl"))
                                 # rHandsontableOutput(ns("prevDataTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("prevDataTbl"), rhandsontable_headstyle))
                          ),
                          br(),
                          tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                          div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("prevData_Template_download"),label = "Download Template", class="butt5") ),
                          tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                          tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                  fileInput2(inputId = ns("prevData_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                             accept = ".xlsx", multiple = F, width = "100px", progress = F))
                        )
               ),
               
               tabPanel(title = "High Level Design", value = "highLevel",
                        actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style = toggle_guid_btn_style),
                        #hidden(
                          div(id = ns("guid_notes"),
                                  p(HTML("<br> </br>The <b>High Level Design Stage</b> collates information on the design of the infrastructure, including the length of the route, the number and length 
                         of bridges and tunnels, the number of interchanges and provides a space to describe the route corridor and any loss of previously untouched 
                         land that might occur."))
                              ),
                        
                        fluidRow(
                          column(6,offset = 6,
                                 HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                 ### tags$head() This is to change the color of "Add a new row" button
                                 # tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                 # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("cada_Add_row_head"),label = "Add", class="butt2") ),
                                 tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("highLevel_mod_row_head"),label = "Edit", class="butt4") ),
                                 # tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                 # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("cada_Del_row_head"),label = "Delete", class="butt3") ),
                                 ### Optional: a html button
                                 # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                 HTML('</div>') ),
                          column(width = 12,br(), h5("Enter details of the planned route corridor options and the baseline conditions."),
                                 DT::DTOutput(ns("highLevelTbl"))
                                 # rHandsontableOutput(ns("highLevelTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("highLevelTbl"), rhandsontable_headstyle))
                          ),
                          br(),
                          tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                          div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("highLevel_Template_download"),label = "Download Template", class="butt5") ),
                          tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                          tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                  fileInput2(inputId = ns("highLevel_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                             accept = ".xlsx", multiple = F, width = "100px", progress = F))
                        )
               )
        )
    )
  )
}

roadhome_server <- function(id, thetitle, appR_returned, projectdetails_values){
  
  
  DF_prevData = data.table(`Option` = as.character(paste("Option ", 1:10)), 
                           `Product Stage Carbon (tCO2e)` = 0.0,
                           `Construction Process Stage Carbon (tCO2e)` = 0.0,
                           `Operational Use Carbon (tCO2e)` = 0.0,
                           `User Carbon Emissions (tCO2e)` = 0.0,
                           `End of Life Carbon (tCO2e)` = 0.0,
                           # `Pre-Construction Carbon (tCO2e)` = 0.0,
                           # `Embodied Carbon (tCO2e)` = 0.0,
                           # `Construction Activities Carbon (tCO2e)` = 0.0,
                           # `Construction Waste Carbon (tCO2e)` = 0.0,
                           # `Operational Use Carbon (tCO2e)` = 0.0,
                           # `User Carbon Emissions (tCO2e)` = 0.0,
                           # `Maintenance Carbon (tCO2e)` = 0.0,
                           # `End of life Carbon (tCO2e)` = 0.0,
                           `Total Carbon (tCO2e)` = 0.0,
                           stringsAsFactors = F, check.names = FALSE)
  
  
  DF_highLevel = data.table(`Option` = as.character(paste("Option ", 1:10)), 
                            Names = as.character(NA),
                            Description = as.character(NA),
                            `Distance (km)` = 0.0,
                            `Number of Bridges` = 0.0,
                            `Total length of Bridges (m)` = 0.0,
                            `Number of Tunnels` = 0.0,
                            `Total length of Tunnels (m)` = 0.0,
                            `Number of Interchanges` = 0.0,
                            `Loss of previously untouched land (description)` = as.character(NA),
                            stringsAsFactors = F, check.names = FALSE)
  
  DF_returned <- data.table(`Option` = c(1:10),
                            `Option Names` = as.character(NA),
                            `Total Distance` = rep(0.0, rhot_rows),
                            stringsAsFactors = F, check.names = FALSE)
  
  
  RoadHome_returned <- reactiveValues(data = DF_returned,
                                      prevDataTblResave=DF_prevData,
                                      highLevelTblResave=DF_highLevel)
  
  moduleServer(id,
               function(input, output, session){
                 output$some_title <- renderText({thetitle})
                 
                 prevDatavalues <- reactiveValues(data=DF_prevData)
                 highLevelvalues <- reactiveValues(data=DF_highLevel)
                 
                 ns <- session$ns
                 
                 output$prevDataTbl <- DT::renderDT({
                   DT = prevDatavalues$data
                   datatable(DT, escape=F, rownames= FALSE, options = list(dom = "t")) %>%
                     DT::formatCurrency(columns = c(2:7), currency = "", interval = 3, mark = ",", digits = 2)
                 })
                 
                 output$prevData_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_PreviousData.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_PreviousData.xlsx",to = file)}
                 )
                 
                 observeEvent(input$prevData_Template_upload$name, {
                   dat_upload <- readxl::read_xlsx(input$prevData_Template_upload$datapath)
                   
                   if (identical(names(dat_upload), names(prevDatavalues$data))){
                     prevDatavalues$data <- dat_upload
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 output$highLevelTbl <- DT::renderDT({
                   DT = highLevelvalues$data
                   datatable(DT, escape=F, rownames= FALSE, options = list(dom = "t")) %>%
                     DT::formatCurrency(columns = c(4:9), currency = "", interval = 3, mark = ",", digits = 2)
                 })
                 
                 observeEvent(input$highLevel_mod_row_head,{
                   
                   showModal(
                     if(length(input$highLevelTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         textInput(ns("highLevel_mod_col2"), label = "Names", value = highLevelvalues$data[input$highLevelTbl_rows_selected,2]),
                         textInput(ns("highLevel_mod_col3"), label = "Description", value = highLevelvalues$data[input$highLevelTbl_rows_selected,3]),
                         numericInput(ns("highLevel_mod_col4"), label = names(highLevelvalues$data)[4], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 4]),
                         numericInput(ns("highLevel_mod_col5"), label = names(highLevelvalues$data)[5], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 5]),
                         numericInput(ns("highLevel_mod_col6"), label = names(highLevelvalues$data)[6], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 6]),
                         numericInput(ns("highLevel_mod_col7"), label = names(highLevelvalues$data)[7], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 7]),
                         numericInput(ns("highLevel_mod_col8"), label = names(highLevelvalues$data)[8], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 8]),
                         numericInput(ns("highLevel_mod_col9"), label = names(highLevelvalues$data)[9], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 9]),
                         textInput(ns("highLevel_mod_col10"), label = names(highLevelvalues$data)[10], value = highLevelvalues$data[input$highLevelTbl_rows_selected, 10]),
                         
                         hidden(numericInput(ns("highLevel_mod_rown"), value = input$highLevelTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("highLevel_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$highLevel_confirm_mod, {
                   #browser()
                   new_row = data.frame("Option" = highLevelvalues$data[input$highLevelTbl_rows_selected,1],
                                        input$highLevel_mod_col2,
                                        input$highLevel_mod_col3,
                                        input$highLevel_mod_col4,
                                        input$highLevel_mod_col5,
                                        input$highLevel_mod_col6,
                                        input$highLevel_mod_col7,
                                        input$highLevel_mod_col8,
                                        input$highLevel_mod_col9,
                                        input$highLevel_mod_col10)
                   
                   highLevelvalues$data[input$highLevel_mod_rown,] <- new_row
                   
                   removeModal()
                 })
                 
                 
                 output$highLevel_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_HighLevelData.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_HighLevelData.xlsx",to = file)}
                 )
                 
                 observeEvent(input$highLevel_Template_upload$name, {
                   
                   dat_upload <- readxl::read_xlsx(input$highLevel_Template_upload$datapath)
                   
                   if (identical(names(dat_upload), names(highLevelvalues$data))){
                     
                     highLevelvalues$data <- dat_upload
                     
                     RoadHome_returned$data$`Total Distance` <- highLevelvalues$data$`Distance (km)`
                     RoadHome_returned$data$`Option Names` <- highLevelvalues$data$Names
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 #RoadHome_returned$prevDataTblResave = prevDatavalues$data
                 
                 #RoadHome_returned$highLevelTblResave = highLevelvalues$data
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
                 output$projPhase <- reactive({
                   
                   projPhase <- projectdetails_values$projPhase
                   # Get the project type from the phase selection
                   # Split on "Phase" and keep first element
                   schemeChars <- strsplit(projPhase, split = "Phase")[[1]][1]
                   # Look for Road, Rail or Greenway in schemeChars string
                   projPhaseInitials <- regmatches(schemeChars, regexpr("Road|Rail|Greenway", text = schemeChars))
                   # Extract first 2 characters only
                   
                   projPhaseInitials <- substr(projPhaseInitials, 0, 2)
                   
                   
                   if(projPhaseInitials == substr(id, 0, 2)){
                     projectdetails_values$projPhase
                   } else {
                     #paste0("Scheme type has been specified as ",substr(projPhase, 0, schemeChars), " in Project Details")
                     paste0("Scheme type has been specified as ",schemeChars, " in Project Details")                   }
                 })
                 
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   HOME   appR_returned$loadReact")
                   #
                   prevDatavalues$data = DF_prevData
                   highLevelvalues$data = DF_highLevel
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_prevDataTbl")]]
                   if (is.null(tmpData)){ # don't try to overwrite with old save file version of prevData table
                     #print("don't load roadhome")
                     prevDatavalues$data = DF_prevData
                   } else {
                     prevDatavalues$data <- tmpData
                   }
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_highLevelTbl")]]
                   if (is.null(tmpData)){
                     highLevelvalues$data <- DF_highLevel
                   } else {
                     highLevelvalues$data <- tmpData
                   }
                   
                   
                   
                   RoadHome_returned$data$`Total Distance` <- highLevelvalues$data$`Distance (km)`
                   RoadHome_returned$data$`Option Names` <- highLevelvalues$data$Names
                   
                   
                   loadedInput <- appR_returned$data$inputs_data_frame
                   
                   numModInputs <- "Phase"
                   
                   for (i in 1:length(numModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(Module %in% id) %>% filter(idInput %in% numModInputs[i])
                     loadedInputValue  <- loadedInputValue[1,4]
                     updateNumericInput(getDefaultReactiveDomain(), input = numModInputs[i], value = loadedInputValue)
                     
                   }
                 })
                 
                 
               }, session = getDefaultReactiveDomain()
  )
  
  return(RoadHome_returned)
  
}
