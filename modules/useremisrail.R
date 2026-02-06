##### Use submodule ##############################################################################################################

# Last modified by Andy Brown (12/01/2022)
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

##################################################################################################################################

useremisrail_ui <- function(id,tabName){
  ns <- NS(id)
  
  # Switch selection depending on Road or Rail Option
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    #use_stage_icon <- use_road_icon
    roadorrail <- "Road"
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    #use_stage_icon <- use_rail_icon
    roadorrail <- "Rail"
  } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    #use_stage_icon <- use_road_icon
    roadorrail <- "Greenway"
  }
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 7,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), user_emis_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, paste0("Total ", roadorrail," User Emissions (tCO2e):  "), textOutput(outputId = ns("sum_useremis_tCO2"), inline = T), 
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            #hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML(paste0("<br> </br>The <b> Rail User Emissions</b> page calculates emissions associated with the changes in road use caused by operation of the light rail scheme.<br><br>
                          Use the Edit button to modify the row displayed, or use the download/upload template buttons below the table to import data from Excel. 
                          The data input tables require:<br>
                            <ul><li>Input of road user emissions data directly from the REM model for the project lifetime. Traffic modelling used for the REM model should be based on future traffic data for the 
                          Do-Minimum scenario without the light rail scheme and the Do-Something scenario with the light rail scheme in place</li>
                            <li>Input of annual energy consumption for operating the trains (in accordance with the units provided in the Units column of the table)</li></ul><br>
                          
                          Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each activity detailed, as applicable.")))
                              )))),
        
        tags$style(".nav-tabs {background: #f4f4f4;}"),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "vehicleuse",
               
               
               tabPanel(title = tagList("Road Use", icon("arrow-circle-right")), value = "vehicleuse",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="",#"This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Road Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_vehu_tCO2"), inline = T), HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 #h4(HTML("<br><br>")),
                                 #h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime"), inline = T)),
                                 # rHandsontableOutput(ns("vehuTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("vehuTbl"), rhandsontable_headstyle)),
                                 
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        # tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("vehu_mod_row_head"),label = "Edit", class="butt4") ),
                                        # tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 column(12,
                                        DT::DTOutput(ns("vehuTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("vehu_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("vehu_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F)),
                                 
                                 h4(HTML("<b>User Transport</b>")),
                                 h4("Total Do-Something Emissions (tCO2e): ", textOutput(outputId = ns("sum_DS_emissions1"), inline = T)),
                                 h4("Difference DS-DM Scenario (tCO2e): ", textOutput(outputId = ns("DS_minus_DN1"), inline = T))
                          )
                        )
               ),
               
               tabPanel(title = tagList("Train Operation", icon("arrow-circle-right")), value = "trainop",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Train Operation Emissions (tCO2e):  ", textOutput(outputId = ns("sum_train_tCO2"), inline = T), HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime1"), inline = T)),
                                 # rHandsontableOutput(ns("trainTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("trainTbl"), rhandsontable_headstyle)),
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        # tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("train_mod_row_head"),label = "Edit", class="butt4") ),
                                        # tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        # div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 column(12,
                                        DT::DTOutput(ns("trainTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("train_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("train_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F)),
                                 
                                 h4(HTML("<b>User Transport</b>")),
                                 h4("Total Do-Something Emissions (tCO2e): ", textOutput(outputId = ns("sum_DS_emissions2"), inline = T)),
                                 h4("Difference DS-DM Scenario (tCO2e): ", textOutput(outputId = ns("DS_minus_DN2"), inline = T))
                          )
                        )
               ),
               
               tabPanel(title = tagList("Carbon Saving Opportunities", icon("check-circle")), value = "csavo",
                        fluidRow(
                          column(width = 12,
                                 h4(strong("Carbon Savings Identified but not Implemented")),
                                 # rHandsontableOutput(ns("csavoNoImplTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("csavoNoImplTbl"), rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 column(12,
                                        DT::DTOutput(ns("csavoNoImplTbl"))
                                 )
                          )
                        ),
                        fluidRow(
                          column(width = 12,
                                 h4(strong("Carbon Savings Identified and Implemented")),
                                 # rHandsontableOutput(ns("csavoImplTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("csavoImplTbl"), rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 column(12,
                                        DT::DTOutput(ns("csavoImplTbl"))
                                 )
                          )
                        )
               )
        )
    )
  )
}

useremisrail_server <- function(id, option_number, thetitle, theoutput, appR_returned, projectdetails_values){
  

  
  DF_vehuse = data.table(`REM Outputs: Do Minimum Scenario (tCO2e)` = c(0.0),
                         `REM Outputs: Do Something Scenario (tCO2e)` = 0.0,
                         `Difference DS-DM Scenarios (tCO2e)` = 0.0,
                         `Comments` = "",
                         stringsAsFactors = F, check.names = FALSE)
  
  DF_train = data.table(`Energy Use Category` = "Train Operation",
                        `Energy Type` = "Grid Electricity - Ireland",
                        `Annual Consumption` = c(0.0),
                        Unit = "kWh (Net CV)", 
                        `Annual Emissions tCO2e` = 0.0,
                        `Total emissions from train operation for project lifetime` = 0.0,
                        stringsAsFactors = F, check.names = FALSE)
  
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                              `Rationale for why the option has not been taken forward for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                            `Rationale for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  
  
  vehuvalues <- reactiveValues(data=DF_vehuse)
  
  trainvalues <- reactiveValues(data=DF_train)
  
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  
  sum_vehu_tCO2 <- reactiveValues(data=0.0) # sum(DF_vehuse$`Difference DS-DN Scenarios (tCO2e)`))
  
  sum_vehuDS_tCO2 <- reactiveValues(data=0.0)
  sum_vehuDN_tCO2 <- reactiveValues(data=0.0)
  
  
  sum_train_tCO2 <- reactiveValues(data=0.0)
  
  sum_useremis_tCO2 <- reactiveValues(data=0.0)
  
  
  DF_returned <- data.table(Option = rep(option_number, 3),
                            Stage = rep("User Emissions", 3),
                            Measure = c("Vehicle Use","Train Operation","Total"),
                            Value = rep(0.0, 3),
                            stringsAsFactors = F, check.names = FALSE)
  
  useremis_returned <- reactiveValues(data=DF_returned,
                                 carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                           Stage = c("User Emissions"),
                                                           Description = c(""), Rationale = c("")),
                                 carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                        Stage = c("User Emissions"),
                                                        Description = c(""), Rationale = c("")),
                                 vehuTblResave = DF_vehuse,
                                 trainTblResave = DF_train,
                                 csavoNoImplTblResave = DF_csavoNoImpl,
                                 csavoImplTblResave = DF_csavoImpl)
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 output$sum_vehu_tCO2<- renderText({formatC(round(sum_vehu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_train_tCO2<- renderText({formatC(round(sum_train_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_useremis_tCO2<- renderText({formatC(round(sum_useremis_tCO2$data, digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 
                 output$some_title <- renderText({thetitle})
                 
                 output$lifeTime <- reactive({projectdetails_values$lifeTime})
                 output$lifeTime1 <- reactive({projectdetails_values$lifeTime})
                 
                 
                 output$sum_DS_emissions1 <- renderText({formatC(round(sum(sum_train_tCO2$data, sum_vehuDS_tCO2$data), digits = Emissions_DPlaces_menus), 
                                                                 format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 output$sum_DS_emissions2 <- renderText({formatC(round(sum(sum_train_tCO2$data, sum_vehuDS_tCO2$data), digits = Emissions_DPlaces_menus), 
                                                                 format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 
                 output$DS_minus_DN1 <- renderText({formatC(round(sum(sum_train_tCO2$data, sum_vehuDS_tCO2$data) - sum_vehuDN_tCO2$data, digits = Emissions_DPlaces_menus), 
                                                                 format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 output$DS_minus_DN2 <- renderText({formatC(round(sum(sum_train_tCO2$data, sum_vehuDS_tCO2$data) - sum_vehuDN_tCO2$data, digits = Emissions_DPlaces_menus), 
                                                            format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 
                 # Observe Event on load button click (via global reactive expression) - clears rhandsontable once on press
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   USER EMISSIONS (RAIL)   appR_returned$loadReact")
                   
                   vehuvalues$data = DF_vehuse
                   trainvalues$data = DF_train
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   
                   sum_vehu_tCO2$data = 0.0
                   sum_vehuDS_tCO2$data = 0.0
                   sum_train_tCO2$data = 0.0
                   sum_useremis_tCO2$data = 0.0
                   
                   useremis_returned$data$Value = c(0.0,0.0,0.0)
                   
                   useremis_returned$carbsaveimp$Description = c("")
                   useremis_returned$carbsaveimp$Rationale = c("")
                   useremis_returned$carbsavenotimp$Description = c("")
                   useremis_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id, "_vehuTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                  
                   
                   tmpData <- appR_returned$data[[paste0(id, "_vehuTbl")]]
                   colnames(tmpData) <- colnames(DF_vehuse)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   vehuvalues$data <- tmpData
                   useremis_returned$vehuTblResave = tmpData
                   
                   sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DM Scenarios (tCO2e)`))# * projectdetails_values$lifeTime
                   
                   sum_vehuDS_tCO2$data = sum(na.omit(vehuvalues$data$`REM Outputs: Do Something Scenario (tCO2e)`)) 
                   
                   
                   tmpData <- appR_returned$data[[paste0(id, "_trainTbl")]]
                   colnames(tmpData) <- colnames(DF_train)
                   trainvalues$data <- tmpData
                   useremis_returned$trainTblResave = tmpData
                   
                   sum_train_tCO2$data = sum(na.omit(trainvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   
                   sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                   
                   useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   useremis_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData

                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("User Emissions", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   useremis_returned$carbsavenotimp = tmpdat



                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   useremis_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData

                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("User Emissions", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   useremis_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
                 output$vehuTbl <- DT::renderDT({
                   DT = vehuvalues$data
                   datatable(DT, options = list(dom="t"),
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$vehu_mod_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     numericInput(ns("vehu_add_col1"), label = "REM Outputs: Do Minimum Scenario (tCO2e)", value = 0),
                     numericInput(ns("vehu_add_col2"), label = "REM Outputs: Do Something Scenario (tCO2e)", value = 0),
                     textInput(ns("vehu_add_col3"), label = "Comments"),
                     actionButton(ns("vehu_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$vehu_add_row_go, {
                   
                   new_row = data.frame(input$vehu_add_col1,
                                        input$vehu_add_col2,
                                        "Difference DS-DM Scenarios (tCO2e)" = 0,
                                        input$vehu_add_col3) %>%
                     dplyr::mutate(`Difference.DS.DM.Scenarios..tCO2e.` = input.vehu_add_col2 - input.vehu_add_col1)
                   
                   vehuvalues$data[1,] <- new_row
                   sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DM Scenarios (tCO2e)`))
                   
                   sum_vehuDS_tCO2$data = sum(na.omit(vehuvalues$data$`REM Outputs: Do Something Scenario (tCO2e)`))# * projectdetails_values$lifeTime
                   sum_vehuDN_tCO2$data = sum(na.omit(vehuvalues$data$`REM Outputs: Do Minimum Scenario (tCO2e)`))# * projectdetails_values$lifeTime
                   
                   # update total sum of carbon emissions when any table cell changes value
                   sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                   useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                   useremis_returned$vehuTblResave = vehuvalues$data
                   
                   removeModal()
                 })
                 
                 output$vehu_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_UserEmissions.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_UserEmissions.xlsx",to = file)}
                 )
                 
                 observeEvent(input$vehu_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$vehu_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(vehuvalues$data)[1:3])){
                     
                     templateIn_data <- templateIn %>% # overwrite
                       dplyr::mutate(`Difference DS-DM Scenarios (tCO2e)` = 
                                       `REM Outputs: Do Something Scenario (tCO2e)` - `REM Outputs: Do Minimum Scenario (tCO2e)`)
                     
                     vehuvalues$data <- templateIn_data
                     
                     sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DM Scenarios (tCO2e)`))
                     sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                     useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                     useremis_returned$vehuTblResave = vehuvalues$data
                     
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 output$trainTbl <- DT::renderDT({
                   DT = trainvalues$data
                   datatable(DT, options = list(dom="t"),
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$train_mod_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     
                     selectizeInput(ns("train_add_col1"), label = "Energy Use Category", choices = "Train Operation"),
                     selectizeInput(ns("train_add_col2"), label = "Energy Type", choices = "Grid Electricity - Ireland"),
                     numericInput(ns("train_add_col3"), label = "Annual Consumption", value = trainvalues$data[input$trainTbl_rows_selected,3]),
                     selectizeInput(ns("train_add_col4"), label = "Unit", choices = "kWh (Net CV)"),
                     actionButton(ns("train_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$train_add_row_go, {
                   
                   new_row = data.frame(input$train_add_col1,
                                        input$train_add_col2,
                                        input$train_add_col3,
                                        input$train_add_col4,
                                        "Annual Emissions tCO2e" = 0,
                                        "Total emissions from train operation for project lifetime" = 0) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.train_add_col2" = "Fuel")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.train_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::mutate(`Total.emissions.from.train.operation.for.project.lifetime` = 
                                     input.train_add_col3 * `kgCO2e per unit` * kgConversion * projectdetails_values$lifeTime) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   trainvalues$data[1,] <- new_row
                   sum_train_tCO2$data = sum(na.omit(trainvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get annual carbon emissions

                   # update total sum of carbon emissions when any table cell changes value
                   sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                   useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                   useremis_returned$trainTblResave = trainvalues$data
                   
                   removeModal()
                 })
                 
                 output$train_Template_download <- downloadHandler(
                   filename = function(){"Rail_UserEmissions_TrainOperation.xlsx"},
                   content =function(file){file.copy(from = "Templates/Rail_UserEmissions_TrainOperation.xlsx",to = file)}
                 )
                 
                 observeEvent(input$train_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$train_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(trainvalues$data)[1:3])){
                     
                     templateIn_data <- templateIn %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Energy Type" = "Fuel")) %>%
                       dplyr::mutate(`Annual Emissions tCO2e` = `Annual Consumption` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::mutate(`Total emissions from train operation for project lifetime` = `Annual Emissions tCO2e` * projectdetails_values$lifeTime) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Annual Consumption` > 0)
                     
                     trainvalues$data <- templateIn_data
                     
                     sum_train_tCO2$data <- sum(na.omit(trainvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     
                     sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                     useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                     useremis_returned$trainTblResave = trainvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 
                 # Carbon saving options (non-implementation) ----
                 output$csavoNoImplTbl <- DT::renderDT({
                   DT = csavoNoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoN_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoN_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoN_add_col2"), label = "Rationale for why the option has not been taken forward for implementation"),
                     actionButton(ns("csavoN_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoN_Add_row_go, {
                   new_row = data.frame(input$csavoN_add_col1, input$csavoN_add_col2)
                   csavoNoImplvalues$data <- data.table(rbind(csavoNoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsavenotimp <- tmpdf
                   useremis_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_Del_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure delete",length(input$csavoNoImplTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoN_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_del_row_ok, {
                   csavoNoImplvalues$data = csavoNoImplvalues$data[-input$csavoNoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsavenotimp <- tmpdf
                   useremis_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_mod_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoN_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,1]),
                         textInput(ns("csavoN_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoN_mod_rown"), value = input$csavoNoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoN_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_confirm_mod, {
                   new_row = data.frame(input$csavoN_mod_col1, input$csavoN_mod_col2)
                   csavoNoImplvalues$data[input$csavoN_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsavenotimp <- tmpdf
                   useremis_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 
                 # Carbon saving options (Implementation) ----
                 output$csavoImplTbl <- DT::renderDT({
                   DT = csavoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoI_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoI_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoI_add_col2"), label = "Rationale for implementation"),
                     actionButton(ns("csavoI_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoI_Add_row_go, {
                   new_row = data.frame(input$csavoI_add_col1, input$csavoI_add_col2)
                   csavoImplvalues$data <- data.table(rbind(csavoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsaveimp <- tmpdf
                   useremis_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_Del_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure delete",length(input$csavoImplTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoI_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_del_row_ok, {
                   csavoImplvalues$data = csavoImplvalues$data[-input$csavoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsaveimp <- tmpdf
                   useremis_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_mod_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoI_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,1]),
                         textInput(ns("csavoI_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoI_mod_rown"), value = input$csavoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoI_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_confirm_mod, {
                   new_row = data.frame(input$csavoI_mod_col1, input$csavoI_mod_col2)
                   csavoImplvalues$data[input$csavoI_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("User Emissions", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   useremis_returned$carbsaveimp <- tmpdf
                   useremis_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(
                   projectdetails_values$lifeTime, # observe if any changes to scheme design life changes
                   {
                     
                     sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DM Scenarios (tCO2e)`))# * projectdetails_values$lifeTime # get total carbon emissions
                     
                     sum_train_tCO2$data = sum(na.omit(trainvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     
                     trainvalues$data$`Total emissions from train operation for project lifetime` = trainvalues$data$`Annual Emissions tCO2e` * projectdetails_values$lifeTime
                     
                     # update total sum of carbon emissions when scheme design life changes
                     sum_useremis_tCO2$data = sum(sum_vehu_tCO2$data, sum_train_tCO2$data)
                     
                     
                     sum_vehuDS_tCO2$data = sum(na.omit(vehuvalues$data$`REM Outputs: Do Something Scenario (tCO2e)`))# * projectdetails_values$lifeTime
                     sum_vehuDN_tCO2$data = sum(na.omit(vehuvalues$data$`REM Outputs: Do Minimum Scenario (tCO2e)`))# * projectdetails_values$lifeTime
                     
                     
                     useremis_returned$data$Value = c(sum_vehu_tCO2$data, sum_train_tCO2$data, sum_useremis_tCO2$data)
                     
                   }
                 )
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
               }, session = getDefaultReactiveDomain()
  )
  
  return(useremis_returned)
  
}
