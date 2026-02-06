##### End of life submodule ##############################################################################################################

# Last modified by Andy Brown (12/01/2022)
# - Added in tables for deconstruction/demolition and waste management. 
# - Some elements may need to be changed to feed through changes to global.r script. These have been taggeed with "#+#"
# - There is a bug in the transport components to waste management handsontable, line 327 onwards. col_chg object doesn't seem to pick up the correct column!!
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

###############################################################################################################################################
eolife_ui <- function(id,tabName){
  ns <- NS(id)
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 7,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), eol_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, "Total End of Life Emissions (tCO2e):  ", textOutput(outputId = ns("sum_eolife_tCO2"), inline = T), 
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML("<br> </br>The <b>End of Life Stage</b> considers the decommissioning of the scheme, including deconstruction and demolition 
                                  activities and waste disposal. <br><br>
                   Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                   The data input table requires:<br>
                   <ul><li> Drop-down selection of the decommissioning activity (e.g. plant type, fuel type)</li>
                   <li> Input of fuel use per hour (according to the units in the Unit column)</li>
                   <li> Input of operating time in hours</li>
                   <li> Drop-down selection of waste materials category, sub-category and route</li>
                   <li> The quantity of waste to be disposed (in the units provided in the Units column of the table)</li>
                   <li> The mode of transport of waste and the distance travelled in kilometres, if available. There are options for transport entry, as follows:</li>
                   <ol><li>If data availability allows entry of the mode of transport of the waste and distance travelled into the tool, please ensure that you have selected the ‘(excl. transport)’ options in the waste materials category.</li>
                   <li>If the mode of transport of the waste and distance is not available, please ensure that you have not selected the ‘(excl. transport)’ options in the waste materials category.</li>
                   </ol></ul><br>
                   For transport of decommissioning waste material, where the mode of transport and estimated kilometres travelled data are available, one mode of transport can be entered per type of waste.
                   Emissions are calculated automatically after data is entered.<br><br>
                   Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each material detailed, as applicable."))
                              )
                            )
                        )
        )
        ),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "deconAct",
               tabPanel(title = tagList("Deconstruction Activities", icon("arrow-circle-right")), value = "deconAct", #  tagList("Clearance and Demolition Activities ", icon("arrow-circle-right"))   check-circle
                        fluidRow(
                          column(width = 12,
                                 h4("Deconstruction Activities Emissions (tCO2e):  ", textOutput(outputId = ns("sum_act_tCO2"), inline = T)), HTML("<br> </br>"),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("decon_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("decon_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("deconTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("deconTbl"), rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("decon_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("decon_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("decon_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("deconTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("decon_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;", 
                                         fileInput2(inputId = ns("decon_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                 #p("* Additional rows can be added to the table by right-clicking on the table")
                          )
                        )
               ),
               tabPanel(title = tagList("Decommissioning Waste", icon("arrow-circle-right")), value = "wasMan",
                        fluidRow(
                          column(width = 12,
                                 h4("Decommissioning Waste Emissions (tCO2e):  ", textOutput(outputId = ns("sum_was_trans_tCO2"), inline = T)), HTML("<br> </br>"),
                                 h5(HTML("<b>Note:</b> If detailed information on decommissioning waste transport is available, select emission factors labelled with 
                                         ‘(excl. transport)’ in the waste type column and proceed to complete the waste transport columns with the transport data. 
                                         If information on decommissioning waste transport is not available, select the standard emission factors, which include a 
                                         transport estimate, and leave the waste transport columns blank.")),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("wasman_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("wasman_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("wasManTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("wasManTbl"), rhandsontable_headstyle))
                                 # 
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wasMan_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wasMan_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wasMan_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("wasManTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("wasMan_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;", 
                                         fileInput2(inputId = ns("wasMan_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
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

eolife_server <- function(id, option_number, thetitle, theoutput, appR_returned){
  
  
  #+# move to global 
  decon_dropdown_options <- efs$Fuel %>% 
    select(Fuel, Category, `Sub Category`, Unit, `kgCO2e per unit`) %>%
    as.data.table()
  
  #+# move to global 
  was_dropdown_options <- efs$Waste %>%
    select(`Waste Type`, `Waste Route`, Unit, `kgCO2e per unit`) %>%
    as.data.table()
  
  #+## Initial values for DF_was df - move to global
  eolife_wasMan_wasType_dropdown <- was_dropdown_options %>% pull(`Waste Type`) %>% unique
  
  # generate conversion factors from hectare (default) to other area units
  #area_conversion <- data.table(c("ha", "m2","km2","mi2"))[, V2 := c(1,0.0001,100,258.9989174)]
  #names(area_conversion) <- c("unit","conv_factor")
  
  # definition of data.table for decon table
  DF_decon = data.table(`Activity Category` = as.character(rep("Deconstruction", 5)), #+# change 5 to object defined in global.r
                       `Activity Type` = as.character(NA),
                       `Fuel Type` = as.character(NA),
                       `Fuel Use per hour` = 0.0,
                       Unit = as.character(NA),
                       `hours per day` = 0.0,
                       `total days` = 0.0,
                       `Activity tCO2e` = 0.0,
                       Comments = as.character(NA),
                       stringsAsFactors = F, check.names = FALSE)
  
  # definition of data.table for decon table
  DF_was = data.table(`Waste Type` = as.character(rep(eolife_wasMan_wasType_dropdown[1], 5)), #+# change 5 to object defined in global.r
                      `Waste Route` = as.character(NA),
                      Quantity = 0.0,
                      Unit = as.character(NA),
                      `Transport Mode` = as.character(NA),
                      Distance = 0.0,
                      `Distance Unit` = as.character(NA),
                      `Waste Processing Carbon tCO2e` = 0.0,
                      `Transport tCO2e` = 0.0,
                      Comments = as.character(NA),
                      stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = rep("", rhot_rows), 
                              `Rationale for why the option has not been taken forward for implementation` = rep("", rhot_rows), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = rep("", rhot_rows), 
                            `Rationale for implementation` = rep("", rhot_rows), stringsAsFactors = F, check.names = FALSE)
  
  
  deconvalues <- reactiveValues(data=DF_decon)
  wasvalues <- reactiveValues(data=DF_was)
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  
  sum_act_tCO2 <- reactiveValues(data=0.0)#sum(DF_decon$`Activity tCO2e`))
  sum_was_tCO2 <- reactiveValues(data=0.0)#sum(DF_was$`Waste Processing Carbon tCO2e`))
  sum_trans_tCO2 <- reactiveValues(data=0.0)#sum(DF_was$`Transport tCO2e`))
  sum_was_trans_tCO2 <- reactiveValues(data=0.0)
  sum_eolife_tCO2 <- reactiveValues(data=0.0)
  
  
  DF_returned <- data.table(Option = rep(option_number, 4), # c(option_number, option_number, option_number, option_number),
                            Stage = rep("End of Life", 4), # c("End of Life","End of Life","End of Life", "End of Life"),
                            Measure = c("Activity","Waste Processing","Transport","Total"),
                            Value = rep(0.0, 4), # c(0.0,0.0,0.0,0.0),
                            stringsAsFactors = F, check.names = FALSE)
  
  eolife_returned <- reactiveValues(data=DF_returned,
                                    carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                              Stage = c("End of Life"),
                                                              Description = c(""), Rationale = c("")),
                                    carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                           Stage = c("End of Life"),
                                                           Description = c(""), Rationale = c("")),
														   deconTblResave = DF_decon,
														   wasManTblResave = DF_was,
														   csavoNoImplTblResave = DF_csavoNoImpl,
														   csavoImplTblResave = DF_csavoImpl)
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 output$sum_act_tCO2 <- renderText({formatC(round(sum_act_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_was_trans_tCO2<- renderText({formatC(round(sum_was_trans_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 #output$sum_deconAct_kgCO2_roadsummary <- renderText(sum_deconAct_kgCO2$data)
                 output$sum_eolife_tCO2 <- renderText({formatC(round(sum_eolife_tCO2$data, digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')}) # sum of carbon emissions for full pre-construction stage
                 
                 output$some_title <- renderText({thetitle})
                 output$the_ns_id <- renderText({id})
                 
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   EOLIFE   appR_returned$loadReact")
                   deconvalues$data = DF_decon
                   wasvalues$data = DF_was
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   sum_act_tCO2$data=0.0 #sum(DF_decon$`Activity kgCO2e`))
                   sum_was_tCO2$data=0.0 #sum(DF_was$`Waste Processing Carbon kgCO2e`))
                   sum_trans_tCO2$data=0.0 #sum(DF_was$`Transport kgCO2e`))
                   sum_was_trans_tCO2$data=0.0
                   sum_eolife_tCO2$data=0.0
                   
                   eolife_returned$data$Value = c(0.0,0.0,0.0,0.0)
                   
                   eolife_returned$carbsaveimp$Description = c("")
                   eolife_returned$carbsaveimp$Rationale = c("")
                   eolife_returned$carbsavenotimp$Description = c("")
                   eolife_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_wasManTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                   
                   
                   # Load data from the load file into rhandsontables and reactivevalues
                   tmpData <- appR_returned$data[[paste0(id,"_wasManTbl")]]
                   colnames(tmpData) <- colnames(DF_was)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   tmpData$`Distance Unit` <- as.character(tmpData$`Distance Unit`)
                   wasvalues$data = tmpData
                   eolife_returned$wasManTblResave = tmpData
                   
                   sum_was_tCO2$data = sum(na.omit(tmpData$`Waste Processing Carbon tCO2e`))
                   sum_trans_tCO2$data = sum(na.omit(tmpData$`Transport tCO2e`))
                   sum_was_trans_tCO2$data = sum(sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_deconTbl")]]
                   colnames(tmpData) <- colnames(DF_decon)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   deconvalues$data = tmpData
                   eolife_returned$deconTblResave = tmpData
                   sum_act_tCO2$data = sum(na.omit(tmpData$`Activity tCO2e`))
                   
                   
                   sum_eolife_tCO2$data = sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value = c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   eolife_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("End of Life", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   eolife_returned$carbsavenotimp = tmpdat
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   eolife_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("End of Life", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   eolife_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
                 # Decommissioning Activities/energy use table - change to datatables ----
                 output$deconTbl <- DT::renderDT({
                   DT = deconvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(8), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$decon_Add_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("decon_add_col0"), label = "Activity Category", choices = c("Deconstruction", "Demolition")),
                     selectizeInput(ns("decon_add_col1"), label = "Activity Type", choices = c("Plant Use", "Generator Use")),
                     selectizeInput(ns("decon_add_col2"), label = "Fuel Type", choices = use_oeu_energytype_dropdown),
                     numericInput(ns("decon_add_col3"), label = "Fuel Use Per Hour", value = 0),
                     uiOutput(ns("decon_add_col4_out")),
                     numericInput(ns("decon_add_col5"), label = "Hours Per Day", value = 0),
                     numericInput(ns("decon_add_col6"), label = "Total Days", value = 0),
                     textInput(ns("decon_add_col7"), label = "Comments"),
                     actionButton(ns("decon_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$decon_add_row_go, {
                   #browser()
                   new_row = data.frame(input$decon_add_col0,
                                        input$decon_add_col1,
                                        input$decon_add_col2,
                                        input$decon_add_col3,
                                        input$decon_add_col4,
                                        input$decon_add_col5,
                                        input$decon_add_col6,
                                        "Activity tCO2e" = 0,
                                        input$decon_add_col7) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.decon_add_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.decon_add_col3 * input.decon_add_col5 * input.decon_add_col6 *
                                     `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   deconvalues$data <- data.table(rbind(deconvalues$data, new_row, use.names = F))
                   
                   sum_act_tCO2$data <- sum(deconvalues$data$`Activity tCO2e`)
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$deconTblResave = deconvalues$data
                   
                   removeModal()
                 })
                 
                 output$decon_add_col4_out <- renderUI({
                   selectizeInput(ns("decon_add_col4"), label = "Unit", choices = decon_unit_choices())
                 })
                 
                 decon_unit_choices <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$decon_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$decon_Del_row_head,{
                   showModal(
                     if(length(input$deconTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$deconTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("decon_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$decon_del_row_ok, {
                   
                   deconvalues$data=deconvalues$data[-input$deconTbl_rows_selected,]
                   
                   sum_act_tCO2$data <- sum(deconvalues$data$`Activity tCO2e`)
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$deconTblResave = deconvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$decon_mod_row_head, {
                   ### This is the pop up board for input a new row
                   showModal(
                     if(length(input$deconTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("decon_mod_col0"), label = "Activity Category", choices = c("Deconstruction", "Demolition")),
                         selectizeInput(ns("decon_mod_col1"), label = "Activity Type", choices = c("Plant Use", "Generator Use")),
                         selectizeInput(ns("decon_mod_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown),
                         numericInput(ns("decon_mod_col3"), label = "Fuel Use Per Hour", value = deconvalues$data[input$deconTbl_rows_selected,4]),
                         uiOutput(ns("decon_mod_col4_out")),
                         numericInput(ns("decon_mod_col5"), label = "Operating Time (Hours Per Day)", value = deconvalues$data[input$deconTbl_rows_selected,6]),
                         numericInput(ns("decon_mod_col6"), label = "Total Days", value = deconvalues$data[input$deconTbl_rows_selected,7]),
                         textInput(ns("decon_mod_col7"), label = "Comments", value = deconvalues$data[input$deconTbl_rows_selected,9]),
                         
                         hidden(numericInput(ns("decon_mod_rown"), value = input$deconTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("decon_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$decon_mod_col4_out <- renderUI({
                   selectizeInput(ns("decon_mod_col4"), label = "Unit", choices = decon_unit_choices_mod())
                 })
                 
                 decon_unit_choices_mod <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$decon_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 observeEvent(input$decon_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$decon_mod_col0,
                                        input$decon_mod_col1,
                                        input$decon_mod_col2,
                                        input$decon_mod_col3,
                                        input$decon_mod_col4,
                                        input$decon_mod_col5,
                                        input$decon_mod_col6,
                                        "Activity tCO2e" = 0,
                                        input$decon_mod_col7) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.decon_mod_col2" = "Fuel")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.decon_mod_col3 * input.decon_mod_col5 * input.decon_mod_col6 *
                                     `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   deconvalues$data[input$decon_mod_rown,] <- new_row
                   
                   sum_act_tCO2$data <- sum(deconvalues$data$`Activity tCO2e`)
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$deconTblResave = deconvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$decon_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_EndofLife_Decon.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_EndofLife_Decon.xlsx",to = file)}
                 )
                 
                 observeEvent(input$decon_Template_upload$name, {

                   templateIn <- readxl::read_xlsx(input$decon_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:4], names(deconvalues$data)[1:4])){
                     
                     if (typeof(templateIn$`Fuel Use per hour`) == "character" | typeof(templateIn$`hours per day`) == "character" | 
                         typeof(templateIn$`total days`) == "character"){
                       templateIn$`Fuel Use per hour` <- as.numeric(templateIn$`Fuel Use per hour`)
                       templateIn$`hours per day` <- as.numeric(templateIn$`hours per day`)
                       templateIn$`total days` <- as.numeric(templateIn$`total days`)
                     }
                     
                     templateIn_data <- bind_rows(deconvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Fuel Type" = "Fuel")) %>%
                       dplyr::mutate(`Activity tCO2e` = `Fuel Use per hour` * `hours per day` * `total days`
                                     * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Fuel Use per hour` > 0)
                     
                     deconvalues$data <- templateIn_data
                     
                     sum_act_tCO2$data <- sum(deconvalues$data$`Activity tCO2e`)
                     sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                     
                     eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                     eolife_returned$deconTblResave = deconvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 

                 # Decommissioning Waste table - change to datatables ----
                 output$wasManTbl <- DT::renderDT({
                   DT = wasvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(8,9), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$wasMan_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("wasMan_add_col1"), label = "Waste Type", choices = eolife_wasMan_wasType_dropdown),
                     uiOutput(ns("wasMan_add_col2_out")),
                     numericInput(ns("wasMan_add_col3"), label = "Quantity", value = 0),
                     uiOutput(ns("wasMan_add_col4_out")),
                     selectizeInput(ns("wasMan_add_col5"), label = "Transport Mode", choices = transmodewasteTbl_dropdown_opts_road$Vehicle),
                     numericInput(ns("wasMan_add_col6"), label = "Distance", value = 0),
                     uiOutput(ns("wasMan_add_col7_out")),
                     textInput(ns("wasMan_add_col8"), label = "Comments"),
                     actionButton(ns("wasMan_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$wasMan_add_row_go, {
                   #browser()
                   new_row = data.frame(input$wasMan_add_col1,
                                        input$wasMan_add_col2,
                                        input$wasMan_add_col3,
                                        input$wasMan_add_col4,
                                        input$wasMan_add_col5,
                                        input$wasMan_add_col6,
                                        input$wasMan_add_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$wasMan_add_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.wasMan_add_col1"="Waste Type", "input.wasMan_add_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.wasMan_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.wasMan_add_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.wasMan_add_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wasvalues$data <- data.table(rbind(wasvalues$data, new_row, use.names = F))
                   
                   sum_was_tCO2$data <- sum(wasvalues$data$`Waste Processing Carbon tCO2e`)
                   sum_trans_tCO2$data <- sum(wasvalues$data$`Transport tCO2e`)
                   
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   sum_was_trans_tCO2$data <- sum(sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$wasManTblResave = wasvalues$data
                   
                   removeModal()
                 })
                 
                 output$wasMan_add_col2_out <- renderUI({
                   selectizeInput(ns("wasMan_add_col2"), label = "Waste Route", choices = wasMan_wasteroute_choices())
                 })
                 
                 wasMan_wasteroute_choices <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$wasMan_add_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$wasMan_add_col4_out <- renderUI({
                   selectizeInput(ns("wasMan_add_col4"), label = "Unit", choices = wasMan_unit_choices())
                 })
                 
                 wasMan_unit_choices <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$wasMan_add_col1) %>%
                     filter(`Waste Route` == input$wasMan_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$wasMan_add_col7_out <- renderUI({
                   selectizeInput(ns("wasMan_add_col7"), label = "Distance Unit", choices = wasMan_distunit_choices())
                 })
                 
                 wasMan_distunit_choices <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$wasMan_add_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$wasMan_Del_row_head,{
                   showModal(
                     if(length(input$wasManTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$wasManTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("wasMan_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wasMan_del_row_ok, {
                   
                   wasvalues$data=wasvalues$data[-input$wasManTbl_rows_selected,]
                   
                   sum_was_tCO2$data <- sum(wasvalues$data$`Waste Processing Carbon tCO2e`)
                   sum_trans_tCO2$data <- sum(wasvalues$data$`Transport tCO2e`)
                   
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   sum_was_trans_tCO2$data <- sum(sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$wasManTblResave = wasvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wasMan_mod_row_head,{
                   showModal(
                     if(length(input$wasManTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("wasMan_mod_col1"), label = "Waste Type", choices = eolife_wasMan_wasType_dropdown),
                         uiOutput(ns("wasMan_mod_col2_out")),
                         numericInput(ns("wasMan_mod_col3"), label = "Quantity", value = wasvalues$data[input$wasManTbl_rows_selected,3]),
                         uiOutput(ns("wasMan_mod_col4_out")),
                         selectizeInput(ns("wasMan_mod_col5"), label = "Transport Mode", choices = transmodewasteTbl_dropdown_opts_road$Vehicle),
                         numericInput(ns("wasMan_mod_col6"), label = "Distance", value = wasvalues$data[input$wasManTbl_rows_selected,6]),
                         uiOutput(ns("wasMan_mod_col7_out")),
                         textInput(ns("wasMan_mod_col8"), label = "Comments", value = wasvalues$data[input$wasManTbl_rows_selected,10]),
                         
                         hidden(numericInput(ns("wasMan_mod_rown"), value = input$wasManTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("wasMan_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$wasMan_mod_col2_out <- renderUI({
                   selectizeInput(ns("wasMan_mod_col2"), label = "Waste Route", choices = wasMan_wasteroute_choices_mod())
                 })
                 
                 wasMan_wasteroute_choices_mod <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$wasMan_mod_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$wasMan_mod_col4_out <- renderUI({
                   selectizeInput(ns("wasMan_mod_col4"), label = "Unit", choices = wasMan_unit_choices_mod())
                 })
                 
                 wasMan_unit_choices_mod <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$wasMan_mod_col1) %>%
                     filter(`Waste Route` == input$wasMan_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$wasMan_mod_col7_out <- renderUI({
                   selectizeInput(ns("wasMan_mod_col7"), label = "Distance Unit", choices = wasMan_distunit_choices_mod())
                 })
                 
                 wasMan_distunit_choices_mod <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$wasMan_mod_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$wasMan_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$wasMan_mod_col1,
                                        input$wasMan_mod_col2,
                                        input$wasMan_mod_col3,
                                        input$wasMan_mod_col4,
                                        input$wasMan_mod_col5,
                                        input$wasMan_mod_col6,
                                        input$wasMan_mod_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$wasMan_mod_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.wasMan_mod_col1"="Waste Type", "input.wasMan_mod_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.wasMan_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.wasMan_mod_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.wasMan_mod_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wasvalues$data[input$wasMan_mod_rown,] <- new_row

                   sum_was_tCO2$data <- sum(wasvalues$data$`Waste Processing Carbon tCO2e`)
                   sum_trans_tCO2$data <- sum(wasvalues$data$`Transport tCO2e`)
                   
                   sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   sum_was_trans_tCO2$data <- sum(sum_was_tCO2$data, sum_trans_tCO2$data)
                   
                   eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                   eolife_returned$wasManTblResave = wasvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$wasMan_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_EndofLife_Waste.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_EndofLife_Waste.xlsx",to = file)}
                 )
                 
                 # Could set to trigger off multiple action buttons (e.g. to upload a sheet containing all tables within each module)
                 # so that all tables within a module can be filled in via the upload feature in a single button click
                 # but will keep it more straightforward for now, with one dedicated excel sheet for each table in each module 
                 #observeEvent(c(input$decon_Template_upload$name, input$wasMan_Template_upload$name), {
                 observeEvent(input$wasMan_Template_upload$name, {
                   #browser()
                   #req(input$wasMan_Template_upload$datapath)
                   templateIn <- readxl::read_xlsx(input$wasMan_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:4], names(wasvalues$data)[1:4])){
                     
                     if (typeof(templateIn$Quantity) == "character" | typeof(templateIn$Distance) == "character"){
                       templateIn$Quantity <- as.numeric(templateIn$Quantity)
                       templateIn$Distance <- as.numeric(templateIn$Distance)
                     }
                     
                     templateIn_data <- bind_rows(wasvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                        by = c("Waste Type"="Waste Type", "Waste Route"="Waste Route")) %>%
                       dplyr::mutate(`Waste Processing Carbon tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("Transport Mode"="Vehicle")) %>%
                       dplyr::mutate(`Transport tCO2e` = Distance * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Quantity` > 0)
                     
                     wasvalues$data <- templateIn_data
                     
                     sum_was_tCO2$data <- sum(wasvalues$data$`Waste Processing Carbon tCO2e`)
                     sum_trans_tCO2$data <- sum(wasvalues$data$`Transport tCO2e`)
                     
                     sum_eolife_tCO2$data <- sum(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data)
                     
                     sum_was_trans_tCO2$data <- sum(sum_was_tCO2$data, sum_trans_tCO2$data)
                     
                     eolife_returned$data$Value <- c(sum_act_tCO2$data, sum_was_tCO2$data, sum_trans_tCO2$data, sum_eolife_tCO2$data)
                     eolife_returned$wasManTblResave = wasvalues$data
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsavenotimp <- tmpdf
                   eolife_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsavenotimp <- tmpdf
                   eolife_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsavenotimp <- tmpdf
                   eolife_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsaveimp <- tmpdf
                   eolife_returned$csavoImplTblResave = csavoImplvalues$data
                   
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsaveimp <- tmpdf
                   eolife_returned$csavoImplTblResave = csavoImplvalues$data
                   
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
                                       Stage = rep("End of Life", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   eolife_returned$carbsaveimp <- tmpdf
                   eolife_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
               }, session = getDefaultReactiveDomain()
  )
  
  return(eolife_returned)
  
}
