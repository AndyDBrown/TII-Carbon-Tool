##### Use submodule ##############################################################################################################

# Last modified by Andy Brown (12/01/2022)
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

##################################################################################################################################

maint_ui <- function(id,tabName){
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
                 h3(tagList(HTML("&nbsp;"), maint_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, "Total Maintenance Emissions (tCO2e):  ", textOutput(outputId = ns("sum_maint_tCO2"), inline = T), 
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML(paste0("<br> </br>The <b> Maintenance</b> page calculates emissions associated with the fuel used for the maintenance of the infrastructure scheme during its use.<br><br>
                          Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                          The data input tables require:<br>
                            <ul><li>Input of fuel use for maintenance plant (per year)</li></ul><br>

                          Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each activity detailed, as applicable.")))
                              ))))),
        
        tags$style(".nav-tabs {background: #f4f4f4;}"),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "maintfuel",
               
               
               tabPanel(title = tagList("Maintenance Plant Fuel Use", icon("arrow-circle-right")), value = "maintfuel",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Maintenance Plant Fuel Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_mpfu_tCO2"), inline = T), tags$sup(icon("question-circle"))) #HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime"), inline = T)),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("maintf_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("maintf_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("mpfuTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("mpfuTbl"), rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("mpfu_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("mpfu_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("mpfu_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("mpfuTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("mpfu_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("mpfu_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
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

maint_server <- function(id, option_number, thetitle, theoutput, appR_returned, projectdetails_values){
  
  # Switch selection depending on Road or Rail Option
  # if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
  #   dropdown_options <- wasteTbl_dropdown_opts_road
  #   trans_mode_options <- transmodewasteTbl_dropdown_opts_road
  # } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
  #   dropdown_options <- wasteTbl_dropdown_opts_rail
  #   trans_mode_options <- transmodewasteTbl_dropdown_opts_rail
  # } else {
  #   print("No matching data")
  # }
  
  ### Initial Waste Type values for DF waste tables
  # waste_init_options <- dropdown_options %>% pull(`Waste Type`) %>% unique
  
  # definition of data.tables for each use stage table
  # DF_energyuse = data.table(`Energy Use Category` = "Lighting",
  #                           `Energy Type` = "Grid Electricity - Ireland",
  #                           `Annual Consumption` = c(0.0,0.0,0.0,0.0,0.0),
  #                           Unit = "kWh", 
  #                           `Annual Emissions tCO2e` = 0.0,
  #                           `Comments` = "",
  #                           stringsAsFactors = F, check.names = FALSE)
  # 
  # DF_wateruse = data.table(`Water Use` = "Water Use - UK Average",
  #                          `Annual Water Consumption` = c(0.0,0.0,0.0,0.0,0.0),
  #                          `Unit` = "litres",
  #                          `Annual Emissions tCO2e` = 0.0,
  #                          `Comments` = "",
  #                          stringsAsFactors = F, check.names = FALSE)
  # 
  # DF_operwaste = data.table(`Waste Type` = as.character(rep(waste_init_options[1], 5)), #+# change 5 to object defined in global.r
  #                             `Waste Route` = as.character(NA),
  #                             `Annual Quantity` = 0.0,
  #                             Unit = as.character(NA),
  #                             `Transport Mode` = as.character(NA),
  #                             `Annual Distance` = 0.0,
  #                             `Distance Unit` = as.character(NA),
  #                             `Waste Processing Carbon tCO2e` = 0.0,
  #                             `Transport tCO2e` = 0.0,
  #                             Comments = as.character(NA),
  #                             stringsAsFactors = F, check.names = FALSE)
  
  DF_mpfueluse = data.table(`Fuel Type` = "Grid Electricity - Ireland",
                            `Annual Quantity` = c(0.0,0.0,0.0,0.0,0.0),
                            Unit = "kWh", 
                            `Annual Emissions tCO2e` = 0.0,
                            `Comments` = "",
                            stringsAsFactors = F, check.names = FALSE)
  
  # DF_vehuse = data.table(`REM Outputs: Do Nothing Scenario (tCO2e)` = c(0.0,0.0,0.0,0.0,0.0),
  #                        `REM Outputs: Do Something Scenario (tCO2e)` = 0.0,
  #                        `Difference DS-DN Scenarios (tCO2e)` = 0.0, 
  #                        #`Time period covered by REM data (years)` = 0.0,
  #                        `Comments` = "",
  #                        stringsAsFactors = F, check.names = FALSE)
  
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                              `Rationale for why the option has not been taken forward for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                            `Rationale for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  
  #oeuvalues <- reactiveValues(data=DF_energyuse)
  #owuvalues <- reactiveValues(data=DF_wateruse)
  #operwastevalues <- reactiveValues(data=DF_operwaste)
  
  mpfuvalues <- reactiveValues(data=DF_mpfueluse)
  
  #vehuvalues <- reactiveValues(data=DF_vehuse)
  
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  
  # sum_oeu_tCO2 <- reactiveValues(data=0.0) # sum(DF_energyuse$`Emissions tCO2e`))
  # sum_owu_tCO2 <- reactiveValues(data=0.0) # sum(DF_wateruse$`Emissions tCO2e`))
  # sum_owaste_tCO2 <- reactiveValues(data=0.0)
  # sum_owaste_trans_tCO2 <- reactiveValues(data=0.0)
  sum_mpfu_tCO2 <- reactiveValues(data=0.0) # sum(DF_mpfueluse$`Emissions tCO2e`))
  # sum_vehu_tCO2 <- reactiveValues(data=0.0) # sum(DF_vehuse$`Difference DS-DN Scenarios (tCO2e)`))
  
  sum_maint_tCO2 <- reactiveValues(data=0.0)
  
  
  DF_returned <- data.table(Option = rep(option_number, 2),
                            Stage = rep("Maintenance", 2),
                            Measure = c("Maintenance Plant Fuel Use","Total"),
                            Value = rep(0.0, 2),
                            stringsAsFactors = F, check.names = FALSE)
  
  maint_returned <- reactiveValues(data=DF_returned,
                                 carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                           Stage = c("Maintenance"),
                                                           Description = c(""), Rationale = c("")),
                                 carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                        Stage = c("Maintenance"),
                                                        Description = c(""), Rationale = c("")),
                                 mpfuTblResave = DF_mpfueluse,
                                 csavoNoImplTblResave = DF_csavoNoImpl,
                                 csavoImplTblResave = DF_csavoImpl)
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 # Sum of total carbon emissions for each activity type
                 # output$sum_oeu_tCO2<- renderText({formatC(round(sum_oeu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 # output$sum_owu_tCO2<- renderText({formatC(round(sum_owu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 # output$sum_owaste_tCO2 <- renderText({formatC(round(sum(sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 # 																	  
                 
                 output$sum_mpfu_tCO2<- renderText({formatC(round(sum_mpfu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 # output$sum_vehu_tCO2<- renderText({formatC(round(sum_vehu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_maint_tCO2<- renderText({formatC(round(sum_maint_tCO2$data, digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')})

                 output$some_title <- renderText({thetitle})

                 output$lifeTime <- reactive({projectdetails_values$lifeTime})
                 # output$lifeTime2 <- reactive({projectdetails_values$lifeTime})
                 # output$lifeTime3 <- reactive({projectdetails_values$lifeTime})
                 # output$lifeTime4 <- reactive({projectdetails_values$lifeTime})
                 # output$lifeTime5 <- reactive({projectdetails_values$lifeTime})
                 
                 
                 # Observe Event on load button click (via global reactive expression) - clears rhandsontable once on press
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   MAINT   appR_returned$loadReact")
                   # oeuvalues$data = DF_energyuse
                   # owuvalues$data = DF_wateruse
                   mpfuvalues$data = DF_mpfueluse
                   # vehuvalues$data = DF_vehuse
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   # sum_oeu_tCO2$data = 0.0
                   # sum_owu_tCO2$data = 0.0
                   # sum_owaste_tCO2$data = 0.0
                   # sum_owaste_trans_tCO2$data = 0.0
                   sum_mpfu_tCO2$data = 0.0
                   # sum_vehu_tCO2$data = 0.0
                   sum_maint_tCO2$data = 0.0
                   
                   maint_returned$data$Value = c(0.0,0.0)
                   
                   maint_returned$carbsaveimp$Description = c("")
                   maint_returned$carbsaveimp$Rationale = c("")
                   maint_returned$carbsavenotimp$Description = c("")
                   maint_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_mpfuTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_mpfuTbl")]] # id
                   colnames(tmpData) <- colnames(DF_mpfueluse)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   mpfuvalues$data <- tmpData
                   maint_returned$mpfuTblResave = tmpData
                   
                   sum_mpfu_tCO2$data = sum(na.omit(tmpData$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   
                   
                   sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                   
                   maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   maint_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData

                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Maintenance", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   maint_returned$carbsavenotimp = tmpdat



                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   maint_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData

                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Maintenance", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   maint_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
                 # Operational Energy Use - change to datatables ----
                 output$mpfuTbl <- DT::renderDT({
                   DT = mpfuvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(4), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$mpfu_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("mpfu_add_col1"), label = "Fuel Type", choices = use_oeu_energytype_dropdown),
                     numericInput(ns("mpfu_add_col2"), label = "Annual Quantity", value = 0),
                     uiOutput(ns("mpfu_add_col3_out")),
                     textInput(ns("mpfu_add_col4"), label = "Comments"),
                     actionButton(ns("mpfu_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 output$mpfu_add_col3_out <- renderUI({
                   selectizeInput(ns("mpfu_add_col3"), label = "Unit", choices = mpfu_unit_choices())
                 })
                 
                 mpfu_unit_choices <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$mpfu_add_col1) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$mpfu_add_row_go, {
                   #browser()
                   new_row = data.frame(input$mpfu_add_col1,
                                        input$mpfu_add_col2,
                                        input$mpfu_add_col3,
                                        "Annual Emissions tCO2e" = 0,
                                        input$mpfu_add_col4) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.mpfu_add_col1" = "Fuel")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.mpfu_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   mpfuvalues$data <- data.table(rbind(mpfuvalues$data, new_row, use.names = F))
                   
                   sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get annual carbon emissions
                   # update total sum of carbon emissions when any table cell changes value
                   sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                   maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
                   maint_returned$mpfuTblResave = mpfuvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$mpfu_Del_row_head,{
                   showModal(
                     if(length(input$mpfuTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$mpfuTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("mpfu_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$mpfu_del_row_ok, {
                   #browser()
                   mpfuvalues$data=mpfuvalues$data[-input$mpfuTbl_rows_selected,]
                   
                   sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get annual carbon emissions
                   # update total sum of carbon emissions when any table cell changes value
                   sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                   maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
                   maint_returned$mpfuTblResave = mpfuvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$mpfu_mod_row_head,{
                   showModal(
                     if(length(input$mpfuTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("mpfu_mod_col1"), label = "Fuel Type", choices = use_oeu_energytype_dropdown,
                                        selected = mpfuvalues$data[input$mpfuTbl_rows_selected,1]),
                         numericInput(ns("mpfu_mod_col2"), label = "Annual Quantity", value = mpfuvalues$data[input$mpfuTbl_rows_selected,2]),
                         uiOutput(ns("mpfu_mod_col3_out")),
                         textInput(ns("mpfu_mod_col4"), label = "Comments", value = mpfuvalues$data[input$mpfuTbl_rows_selected,5]),
                         
                         hidden(numericInput(ns("mpfu_mod_rown"), value = input$mpfuTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("mpfu_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$mpfu_mod_col3_out <- renderUI({
                   selectizeInput(ns("mpfu_mod_col3"), label = "Unit", choices = mpfu_unit_choices_mod())
                 })
                 
                 mpfu_unit_choices_mod <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$mpfu_mod_col1) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$mpfu_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$mpfu_mod_col1,
                                        input$mpfu_mod_col2,
                                        input$mpfu_mod_col3,
                                        "Annual Emissions tCO2e" = 0,
                                        input$mpfu_mod_col4) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.mpfu_mod_col1" = "Fuel")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.mpfu_mod_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   mpfuvalues$data[input$mpfu_mod_rown,] <- new_row
                   
                   sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get annual carbon emissions
                   # update total sum of carbon emissions when any table cell changes value
                   sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                   maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
                   maint_returned$mpfuTblResave = mpfuvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$mpfu_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Maintenance_MPFU.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Maintenance_MPFU.xlsx",to = file)}
                 )
                 
                 observeEvent(input$mpfu_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$mpfu_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(mpfuvalues$data)[1:3])){
                     
                     if (typeof(templateIn$`Annual Quantity`) == "character"){templateIn$`Annual Quantity` <- as.numeric(templateIn$`Annual Quantity`)}
                     
                     templateIn_data <- bind_rows(mpfuvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Fuel Type" = "Fuel")) %>%
                       dplyr::mutate(`Annual Emissions tCO2e` = `Annual Quantity` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Annual Quantity` > 0)
                     
                     mpfuvalues$data <- templateIn_data
                     
                     sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get annual carbon emissions
                     sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                     maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsavenotimp <- tmpdf
                   maint_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_Del_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoNoImplTbl_rows_selected),"rows?" ),
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsavenotimp <- tmpdf
                   maint_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsavenotimp <- tmpdf
                   maint_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsaveimp <- tmpdf
                   maint_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_Del_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoImplTbl_rows_selected),"rows?" ),
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsaveimp <- tmpdf
                   maint_returned$csavoImplTblResave = csavoImplvalues$data
                   
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
                                       Stage = rep("Maintenance", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   maint_returned$carbsaveimp <- tmpdf
                   maint_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(
                   projectdetails_values$lifeTime, # observe if any changes to scheme design life changes
                   {
                     # sum_oeu_tCO2$data = sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get total carbon emissions
                     # sum_owu_tCO2$data = sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get total carbon emissions
                     # sum_owaste_tCO2$data = sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                     # sum_owaste_trans_tCO2$data = sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                     sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     # sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DN Scenarios (tCO2e)`)) * projectdetails_values$lifeTime # get total carbon emissions
                     
                     # update total sum of carbon emissions when scheme design life changes
                     sum_maint_tCO2$data = sum(sum_mpfu_tCO2$data)
                     
                     maint_returned$data$Value = c(sum_mpfu_tCO2$data, sum_maint_tCO2$data)
                     
                   }
                 )
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
               }, session = getDefaultReactiveDomain()
  )
  
  return(maint_returned)
  
}
